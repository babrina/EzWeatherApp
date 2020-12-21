import UIKit
import CoreLocation
import AutocompleteField

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: OUTLETS
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    
    //MARK: VAR
    var viewModel = ViewModel()
    var weatherViewModel = WeatherViewModel()
    
    //MARK: Lifecycle Func
    override func viewDidLoad() {
        super.viewDidLoad()
        firstSetup()
    }
    //MARK: - Actions
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController else {return}
        controller.town = viewModel.searchCity
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func tapRecognized(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController else {return}
        weatherViewModel.accsessPoint = "lat=\(viewModel.lat)&lon=\(viewModel.lon)"
        weatherViewModel.currentTown = ""
        self.navigationController?.pushViewController(controller, animated: true)
    }
    //MARK: - Funcs
    func setupTapRecognize() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapRecognized(_:)))
        self.view.addGestureRecognizer(recognizer)
    }
    
    func firstSetup() {
        viewModel.jsonCity()
        viewModel.locationManagerSetup()
        searchView.cornerRadius()
        searchView.dropShadow()
        addSearchBarWithAutoComplete()
        setupTapRecognize()
    }
    
    func addSearchBarWithAutoComplete() {
        let textfield = AutocompleteField(frame: CGRect(x: 10, y: 13, width: 264, height: 40))
        textfield.placeholder = "City"
        textfield.suggestions = viewModel.citiesArray
        textfield.delegate = self
        textfield.autocorrectionType = .no
        self.searchView.addSubview(textfield)
        textfield.anchor(top: searchView.topAnchor, paddingTop: 5, bottom: searchView.bottomAnchor, paddingBottom: 5, left: searchView.leftAnchor, paddingLeft: 15, right: locationButton.leftAnchor, paddingRight: 3, width: 264, height: 36)
    }
}
//MARK: - Extensions
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ tf: UITextField) -> Bool {
        // fill out the rest when user hits return
        let textField = tf as! AutocompleteField
        textField.text = textField.suggestion
        viewModel.searchCity = textField.text!
        textField.resignFirstResponder()
        return true
    }
}
