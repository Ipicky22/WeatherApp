import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var button: UIBarButtonItem!
    
    var cities: [City] = CitiesData.list
    
    @IBAction func pressButton(_ sender: Any) {
        
        if tableView.isHidden == true {
            tableView.isHidden = false
            mapView.isHidden = true
            
        } else {
            mapView.isHidden = false
            tableView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mapView.delegate = self
        tableView.dataSource = self
        
        for city in CitiesData.list {
            let pin = MKPointAnnotation()
            pin.coordinate = city.coordinates
            pin.title = city.name
            mapView.addAnnotation(pin)
        }
        
        setUpTableView()
    }
    
    func setUpTableView() {
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell_ID")
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKPointAnnotation  {
            performSegue(withIdentifier: "DetailWeather_ID", sender: annotation)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailWeather_ID" {
            if let detailsWeather = segue.destination as? DetailViewController {
                detailsWeather.annotationDetail = sender as? MKPointAnnotation
            }
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
    
    
}
