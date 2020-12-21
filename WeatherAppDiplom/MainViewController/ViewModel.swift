import Foundation
import UIKit
import CoreLocation
import AutocompleteField

class ViewModel: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    //MARK: - VAR
    var lat: Double = 0
    var lon: Double = 0
    private let locationManager = CLLocationManager()
    var searchCity: String = ""
    var citiesArray: [String] = []
    
    //MARK: - Funcs
    func locationManagerSetup() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
   
    func jsonCity() {
        let path = Bundle.main.path(forResource: "weatherappcitiescleaned", ofType: "json")!
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let object = try JSONDecoder().decode(CityJSON.self, from: data)
            citiesArray = object.name
        } catch {
            print("Data err")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocationCoordinate2D = manager.location!.coordinate
        lat = location.latitude
        lon = location.longitude
        locationManager.stopUpdatingLocation()
    }
}
