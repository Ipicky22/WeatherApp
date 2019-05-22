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
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell_ID")
        tableView.register(UINib(nibName: "ForecastTextTableViewCell", bundle: nil), forCellReuseIdentifier: "ForecastTextTableViewCell_ID")
        tableView.register(UINib(nibName: "HourlyTableViewCell", bundle: nil), forCellReuseIdentifier: "HourlyTableViewCell_ID")
        tableView.register(UINib(nibName: "DailyTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyTableViewCell_ID")

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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return weather?.hourly.data.count ?? 0
        case 2:
            return weather?.daily.data.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cellHeader = tableView.dequeueReusableCell(withIdentifier:"HeaderTableViewCell_ID", for: indexPath)
                as? HeaderTableViewCell {
                cellHeader.configure(temperature: weather?.currently.temperature ?? 0, summary: weather?.currently.summary ?? "")
                return cellHeader
            }
            
        case 1:
            if let cellHeader = tableView.dequeueReusableCell(withIdentifier:"ForecastTextTableViewCell_ID", for: indexPath)
                as? ForecastTextTableViewCell {
                cellHeader.configure( summary: weather?.hourly.summary ?? "")
                return cellHeader
            }
        default:
            return UITableViewCell()
        }
    return UITableViewCell()
    }

}
