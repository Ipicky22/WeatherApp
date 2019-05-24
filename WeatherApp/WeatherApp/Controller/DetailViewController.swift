//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Efreitech on 22/05/2019.
//  Copyright © 2019 Adrien & Maxime. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, UITableViewDataSource {
    
    // IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var annotationDetail: MKPointAnnotation?
    var weather: WeatherModel?
    var vSpinner : UIView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        self.navigationItem.title = annotationDetail?.title
        
        showSpinner(onView: self.view)
        requestDataWeather()
        setUpTableView()
    }
    
    private func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        self.vSpinner = spinnerView
    }
    
    private func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
    private func requestDataWeather() {
        RequestWeather.requestCurrently(
            latitude: annotationDetail?.coordinate.latitude ?? 0,
            longitude: annotationDetail?.coordinate.longitude ?? 0,
            success: {(data) in
                let decoder = JSONDecoder()
                self.weather = (try? decoder.decode(WeatherModel.self, from: data))
                self.tableView.reloadData()
                self.removeSpinner()
                self.tableView.backgroundView = UIImageView(image: UIImage(named: "\(self.weather?.currently.icon ?? "")Picture"))
        }) {
            (error) in
            print(error)
        }
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell_ID")
        tableView.register(UINib(nibName: "ForecastTextTableViewCell", bundle: nil), forCellReuseIdentifier: "ForecastTextTableViewCell_ID")
        tableView.register(UINib(nibName: "HourlyTableViewCell", bundle: nil), forCellReuseIdentifier: "HourlyTableViewCell_ID")
        tableView.register(UINib(nibName: "DailyTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyTableViewCell_ID")
        tableView.register(UINib(nibName: "ExtraFirstTableViewCell", bundle: nil), forCellReuseIdentifier: "ExtraFirstTableViewCell_ID")
        tableView.register(UINib(nibName: "ExtraTableViewCell", bundle: nil), forCellReuseIdentifier: "ExtraTableViewCell_ID")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        // Header
        case 0:
            return 1
        // Hourly
        case 1:
            if (weather?.hourly.data.count ?? 0 > 10) {
                return 10
            } else {
                return weather?.hourly.data.count ?? 0
            }
        // Daily
        case 2:
            return weather?.daily.data.count ?? 0
        // Extra Information
        case 3:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        
        // Display Header
        case 0:
            if let cellHeader = tableView.dequeueReusableCell(withIdentifier:"HeaderTableViewCell_ID", for: indexPath)
                as? HeaderTableViewCell {
                
                cellHeader.configure(
                    temperature: weather?.currently.temperature ?? 0,
                    summary: weather?.currently.summary ?? "",
                    iconHeader: weather?.currently.icon ?? ""
                )
                
                cellHeader.backgroundColor = UIColor.clear
                cellHeader.summaryLabel.textColor = UIColor.white
                cellHeader.temperatureLabel.textColor = UIColor.white
                
                return cellHeader
            }
            
        // Display Hourly
        case 1:
            if indexPath.row == 0 {
                
                if let cellHeaderHourly = tableView.dequeueReusableCell(withIdentifier: "ForecastTextTableViewCell_ID", for: indexPath)
                    as? ForecastTextTableViewCell {
                    
                    cellHeaderHourly.configure(summary: weather?.hourly.summary ?? "")
                    cellHeaderHourly.backgroundColor = UIColor.clear
                    cellHeaderHourly.summaryLabel.textColor = UIColor.white
                    
                    return cellHeaderHourly
                }
            } else {
                if let cellDetailsHourly = tableView.dequeueReusableCell(withIdentifier: "HourlyTableViewCell_ID", for: indexPath)
                    as? HourlyTableViewCell {
                    
                    cellDetailsHourly.configure(
                        time: weather?.hourly.data[indexPath.row].time ?? 0,
                        temperature: weather?.hourly.data[indexPath.row].temperature ?? 0,
                        humidity: weather?.hourly.data[indexPath.row].humidity ?? 0,
                        iconHourly: weather?.hourly.data[indexPath.row].icon ?? "",
                        timezone: weather?.timezone ?? ""
                    )
                    
                    cellDetailsHourly.backgroundColor = UIColor.clear
                    cellDetailsHourly.humidityLabel.textColor = UIColor.white
                    cellDetailsHourly.temperatureLabel.textColor = UIColor.white
                    cellDetailsHourly.timeLabel.textColor = UIColor.white
                    
                    return cellDetailsHourly
                }
            }
            
        // Display Daily
        case 2:
            if indexPath.row == 0 {
                if let cellHeaderDaily = tableView.dequeueReusableCell(withIdentifier: "ForecastTextTableViewCell_ID", for: indexPath) as? ForecastTextTableViewCell {
                    
                    cellHeaderDaily.configure(summary: weather?.daily.summary ?? "")
                    cellHeaderDaily.backgroundColor = UIColor.clear
                    cellHeaderDaily.summaryLabel.textColor =  UIColor.white
                    
                    return cellHeaderDaily
                }
            } else {
                if let cellDetailDaily = tableView.dequeueReusableCell(withIdentifier: "DailyTableViewCell_ID", for: indexPath) as? DailyTableViewCell {
                    
                    cellDetailDaily.configure(
                        day: weather?.daily.data[indexPath.row].time ?? 0,
                        temperatureHigh:  weather?.daily.data[indexPath.row].temperatureHigh ?? 0,
                        temperatureLow:  weather?.daily.data[indexPath.row].temperatureLow ?? 0,
                         iconDaily: weather?.daily.data[indexPath.row].icon ?? ""
                    )
                    
                    cellDetailDaily.backgroundColor = UIColor.clear
                    cellDetailDaily.dayLabel.textColor = UIColor.white
                    cellDetailDaily.temperatureHighLabel.textColor = UIColor.white
                    cellDetailDaily.temperatureLowLabel.textColor = UIColor.white
                    
                    return cellDetailDaily
                }
            }
            
        // Display Extra Information
        case 3:
            if indexPath.row == 0 {
                if let cellHeaderExtra = tableView.dequeueReusableCell(withIdentifier: "ForecastTextTableViewCell_ID", for: indexPath) as? ForecastTextTableViewCell {
                    
                    cellHeaderExtra.configure(summary: "Extra Informations")
                    
                    cellHeaderExtra.backgroundColor = UIColor.clear
                    cellHeaderExtra.summaryLabel.textColor = UIColor.white
                    
                    return cellHeaderExtra
                }
            } else if indexPath.row == 1 {
                if let cellExtraFirst = tableView.dequeueReusableCell(withIdentifier: "ExtraFirstTableViewCell_ID", for: indexPath) as? ExtraFirstTableViewCell {
                    
                    cellExtraFirst.configure(humidity: weather?.currently.humidity ?? 0, windSpeed: weather?.currently.windSpeed ?? 0)
                    
                    cellExtraFirst.backgroundColor = UIColor.clear
                    cellExtraFirst.humidityLabel.textColor = UIColor.white
                    cellExtraFirst.humidityTitleLabel.textColor = UIColor.white
                    cellExtraFirst.windSpeedLabel.textColor = UIColor.white
                    cellExtraFirst.windSpeedTitleLabel.textColor = UIColor.white
                    
                    return cellExtraFirst
                }
            } else {
                if let cellExtra = tableView.dequeueReusableCell(withIdentifier: "ExtraTableViewCell_ID", for: indexPath) as? ExtraTableViewCell {
                    
                    cellExtra.configure(pressure: weather?.currently.pressure ?? 0, uvIndex: weather?.currently.uvIndex ?? 0)
                    
                    cellExtra.pressureTitleLabel.textColor = UIColor.white
                    cellExtra.pressureLabel.textColor = UIColor.white
                    cellExtra.uvIndexTitleLabel.textColor = UIColor.white
                    cellExtra.uvIndexLabel.textColor = UIColor.white
                    cellExtra.backgroundColor = UIColor.clear
                    
                    return cellExtra
                }
            }
            
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
}
