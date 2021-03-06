import Foundation
import UIKit
import CoreLocation

class ViewModel: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate  {
    
    //MARK: - VAR
    var lat: Double = 0
    var lon: Double = 0
    private let locationManager = CLLocationManager()
    var searchCity: String = ""
    var citiesArray: [String] = []
    var filteredData: [String] = []
    var favoriteCityArray: [FavoriteCity] = []

    //MARK: - Funcs
    func loadCityArray() {
        if let favoriteCityArray = UserDefaults.standard.value([FavoriteCity].self, forKey: "saved") {
        self.favoriteCityArray = favoriteCityArray
        }
    }
    
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
            print("Data error")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocationCoordinate2D = manager.location!.coordinate
        lat = location.latitude
        lon = location.longitude
        locationManager.stopUpdatingLocation()
    }
}
