import UIKit
import CoreLocation
import AutocompleteField

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: OUTLETS
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        controller.town = searchBar.searchTextField.text ?? "Saint Petersburg"
        self.navigationController?.pushViewController(controller, animated: true)
    }
        
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController else {return}
        controller.accessPoint = "lat=\(viewModel.lat)&lon=\(viewModel.lon)"
        controller.town = ""
        controller.myLat = viewModel.lat
        controller.myLon = viewModel.lon
        self.navigationController?.pushViewController(controller, animated: true)
    }
    //MARK: - Funcs
    func firstSetup() {
        self.hideKeyboardWhenTappedAround()
        tableView.isHidden = true
        tableView.cornerRadius()
        searchButton.isUserInteractionEnabled = false
        viewModel.jsonCity()
        viewModel.locationManagerSetup()
        searchView.cornerRadius()
        searchView.dropShadow()
        viewModel.filteredData = viewModel.citiesArray
    }
}
//MARK: - Extensions
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(name: viewModel.filteredData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SearchTableViewCell?
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.text = cell?.cityNameLabel.text
            self.viewModel.filteredData = []
            self.tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.isHidden = true
            }
            if viewModel.citiesArray.contains(searchBar.searchTextField.text ?? "Saint Petersburg") {
                searchButton.isUserInteractionEnabled = true
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filteredData = []
        if searchText == "" {
            UIView.animate(withDuration: 0.3) {
                self.tableView.isHidden = true
            }
            searchButton.isUserInteractionEnabled = false
        } else {
            UIView.animate(withDuration: 0.3) {
                self.tableView.isHidden = false
            }
            for cities in viewModel.citiesArray {
                if cities.lowercased().contains(searchText.lowercased()) {
                    viewModel.filteredData.append(cities)
                }
            }
            self.tableView.reloadData()
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
