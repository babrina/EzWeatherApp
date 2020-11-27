import UIKit
import CoreLocation
import AutocompleteField

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    
    
    var lat: Double = 0
    var lon: Double = 0
    private let locationManager = CLLocationManager()
    var searchCity: String = ""
    var citiesArray: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonCity()
        searchView.cornerRadius()
        searchView.dropShadow()
        addSearchBarWithAutoComplete()

        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapRecognized(_:)))
        self.view.addGestureRecognizer(recognizer)
        
        locationManagerSetup()
    }
    
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController else {return}
        
        
        controller.town = searchCity
        self.navigationController?.pushViewController(controller, animated: true)
        
        
        
        
    }
    @IBAction func tapRecognized(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController else {return}
        
        controller.accsessPoint = "lat=\(lat)&lon=\(lon)"
        controller.town = ""
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func locationManagerSetup() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    func jsonCity() {
        let path = Bundle.main.path(forResource: "cititesWorked", ofType: "json")!
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let object = try JSONDecoder().decode(CityJSON.self, from: data)
            citiesArray = object.name
           
        } catch {
            print("Data err")
        }
        
    }
    
    func addSearchBarWithAutoComplete() {
        
        let textfield = AutocompleteField(frame: CGRect(x: 10, y: 13, width: 264, height: 40))
        textfield.placeholder = "City"   
        textfield.suggestions = citiesArray
        textfield.delegate = self
        textfield.autocorrectionType = .no

        self.searchView.addSubview(textfield)
        textfield.anchor(top: searchView.topAnchor, paddingTop: 5, bottom: searchView.bottomAnchor, paddingBottom: 5, left: searchView.leftAnchor, paddingLeft: 15, right: locationButton.leftAnchor, paddingRight: 3, width: 264, height: 36)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocationCoordinate2D = manager.location!.coordinate
        lat = location.latitude
        lon = location.longitude
        print("location = \(location.latitude) \(location.longitude)")
        locationManager.stopUpdatingLocation()
    }
    
}
extension UIView {
    func cornerRadius(_ radius: Int = 20) {
        self.layer.cornerRadius = CGFloat(radius)
    }
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        
        layer.shadowRadius = 10
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ tf: UITextField) -> Bool {
        // fill out the rest when user hits return
        let textField = tf as! AutocompleteField
        textField.text = textField.suggestion
        searchCity = textField.text!
        textField.resignFirstResponder()
        
        return true
    }
}



extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
