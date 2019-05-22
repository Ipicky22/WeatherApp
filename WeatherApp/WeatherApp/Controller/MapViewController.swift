import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for City in CitiesData.list {
            let pin = MKPointAnnotation()
            pin.coordinate = City.coordinates
            mapView.addAnnotation(pin)
        }
    }


}
