import UIKit
import MapKit

class DetailViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var annotationDetail: MKPointAnnotation?
    var weather: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        requestCurrentlyDetail()
        setUpTableView()
    }
    
    func requestCurrentlyDetail() {
        RequestWeather.requestCurrently(
            latitude: annotationDetail?.coordinate.latitude ?? 0,
            longitude: annotationDetail?.coordinate.longitude ?? 0,
            success: { (data) in
                let decoder = JSONDecoder()
                self.weather = (try? decoder.decode(WeatherModel.self, from: data))
                self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func setUpTableView() {
        
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell_ID")
        tableView.register(UINib(nibName: "ForecastTextTableViewCell", bundle: nil), forCellReuseIdentifier: "ForecastTextTableViewCell_ID")
        tableView.register(UINib(nibName: "HourlyTableViewCell", bundle: nil), forCellReuseIdentifier: "HourlyTableViewCell_ID")
        tableView.register(UINib(nibName: "DailyTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyTableViewCell_ID")
        tableView.register(UINib(nibName: "ExtraFirstTableViewCell", bundle: nil), forCellReuseIdentifier: "ExtraFirstTableViewCell_ID")
        tableView.register(UINib(nibName: "ExtraTableViewCell", bundle: nil), forCellReuseIdentifier: "ExtraTableViewCell_ID")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return weather?.hourly.data.count ?? 0
        case 2:
            return weather?.daily.data.count ?? 0
        case 3:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cellHeader = tableView.dequeueReusableCell(withIdentifier:"HeaderTableViewCell_ID", for: indexPath)
                as? HeaderTableViewCell {
                cellHeader.configure(temperature: weather?.currently.temperature ?? 0, summary: weather?.currently.summary ?? "", iconHeader: weather?.currently.icon ?? "")
                return cellHeader
            }
        case 1:
            if indexPath.row == 0 {
                if let cellHeaderHourly = tableView.dequeueReusableCell(withIdentifier: "ForecastTextTableViewCell_ID", for: indexPath)
                    as? ForecastTextTableViewCell {
                    cellHeaderHourly.configure(summary: weather?.hourly.summary ?? "")
                    return cellHeaderHourly
                }
            } else {
                if let cellDetailsHourly = tableView.dequeueReusableCell(withIdentifier: "HourlyTableViewCell_ID", for: indexPath)
                    as? HourlyTableViewCell {
                    cellDetailsHourly.configure(time: weather?.hourly.data[indexPath.row].time ?? 0, temperature: weather?.hourly.data[indexPath.row].temperature ?? 0, humidity: weather?.hourly.data[indexPath.row].humidity ?? 0)
                    return cellDetailsHourly
                }
            }
        case 2:
            if indexPath.row == 0 {
                if let cellHeaderDaily = tableView.dequeueReusableCell(withIdentifier: "ForecastTextTableViewCell_ID", for: indexPath) as? ForecastTextTableViewCell {
                    cellHeaderDaily.configure(summary: weather?.daily.summary ?? "")
                    return cellHeaderDaily
                }
            } else {
                if let cellDetailDaily = tableView.dequeueReusableCell(withIdentifier: "DailyTableViewCell_ID", for: indexPath) as? DailyTableViewCell {
                    cellDetailDaily.configure(day: weather?.daily.data[indexPath.row].time ?? 0, temperatureHigh:  weather?.daily.data[indexPath.row].temperatureHigh ?? 0, temperatureLow:  weather?.daily.data[indexPath.row].temperatureLow ?? 0)
                    return cellDetailDaily
                }
            }
        case 3:
            if indexPath.row == 0 {
                if let cellHeaderExtra = tableView.dequeueReusableCell(withIdentifier: "ForecastTextTableViewCell_ID", for: indexPath) as? ForecastTextTableViewCell {
                    cellHeaderExtra.configure(summary: "Extra Informations")
                    return cellHeaderExtra
                }
            } else if indexPath.row == 1 {
                if let cellExtraFirst = tableView.dequeueReusableCell(withIdentifier: "ExtraFirstTableViewCell_ID", for: indexPath) as? ExtraFirstTableViewCell {
                    cellExtraFirst.configure(humidity: weather?.currently.humidity ?? 0, windSpeed: weather?.currently.windSpeed ?? 0)
                    return cellExtraFirst
                }
            } else {
                if let cellExtra = tableView.dequeueReusableCell(withIdentifier: "ExtraTableViewCell_ID", for: indexPath) as? ExtraTableViewCell {
                    cellExtra.configure(pressure: weather?.currently.pressure ?? 0, uvIndex: weather?.currently.uvIndex ?? 0)
                    return cellExtra
                }
            }
            
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
}
