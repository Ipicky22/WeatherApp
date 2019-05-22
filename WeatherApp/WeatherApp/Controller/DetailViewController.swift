import UIKit
import MapKit

class DetailViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var annotationDetail: MKPointAnnotation?
    var currently: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        requestCurrentlyDetail()
    }
    
    func requestCurrentlyDetail() {
        RequestWeather.requestCurrently(
            latitude: annotationDetail?.coordinate.latitude ?? 0,
            longitude: annotationDetail?.coordinate.longitude ?? 0,
            success: { (data) in
            let decoder = JSONDecoder()
            self.currently = (try? decoder.decode(WeatherModel.self, from: data))
            self.tableView.reloadData()
            print(self.currently)
        }) { (error) in
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
