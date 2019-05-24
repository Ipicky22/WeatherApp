//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Efreitech on 22/05/2019.
//  Copyright © 2019 Adrien & Maxime. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var button: UIBarButtonItem!
    
    var cities: [City] = CitiesData.list
    
    @IBAction func pressButton(_ sender: Any) {
        
        if tableView.isHidden == true {
            tableView.isHidden = false
            mapView.isHidden = true
            
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "worldwide")?.withRenderingMode(.alwaysOriginal)
            
        } else {
            
            mapView.isHidden = false
            tableView.isHidden = true
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mapView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        title = "WeatherApp"
        self.navigationItem.rightBarButtonItem?.image = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        
        for city in cities {
            
            let pin = MKPointAnnotation()
            pin.coordinate = city.coordinates
            pin.title = city.name
            mapView.addAnnotation(pin)
        }
        setUpTableView()
    }
    
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell_ID")
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKPointAnnotation  {
            mapView.deselectAnnotation(annotation, animated: false)
            performSegue(withIdentifier: "DetailWeather_ID", sender: annotation)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellCity = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell_ID", for: indexPath) as? CityTableViewCell {
            cellCity.configure(city: cities[indexPath.row].name)
            return cellCity
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CityTableViewCell_ID", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    
        if segue.identifier == "DetailWeather_ID" {
            if let detailsWeatherMap = segue.destination as? DetailViewController {
                detailsWeatherMap.annotationDetail = sender as? MKPointAnnotation
            }
        } else if segue.identifier == "CityTableViewCell_ID" {
            if let detailsWeatherList = segue.destination as? DetailViewController,
                let element = tableView.indexPathForSelectedRow {
                let annotation = MKPointAnnotation()
                annotation.coordinate = cities[element.row].coordinates
                annotation.title = cities[element.row].name
                detailsWeatherList.annotationDetail = annotation
                tableView.deselectRow(at: element, animated: false)
            }
        }
    }
    
}

