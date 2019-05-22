import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        for city in CitiesData.list {
            let pin = MKPointAnnotation()
            pin.coordinate = city.coordinates
            pin.title = city.name
            mapView.addAnnotation(pin)
        }
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
    
    
}
