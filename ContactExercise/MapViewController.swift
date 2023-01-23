import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapV: MKMapView!
    
    var caddress: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(caddress) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            let addressLocation = CLLocation(latitude: lat!, longitude: lon!)
            self.mapV.centerToLocation(addressLocation)
        }
    }
}

private extension MKMapView{
    func centerToLocation(_ location: CLLocation,regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
