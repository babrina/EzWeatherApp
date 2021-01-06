import UIKit
import CoreLocation
import AutocompleteField
import SkeletonView

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: OUTLETS
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: VAR
    var viewModel = ViewModel()
    var weatherViewModel = WeatherViewModel()
    var favoriteCityArray: [FavoriteCity] = []
    
    //MARK: Lifecycle Func
    override func viewDidLoad() {
        super.viewDidLoad()
        firstSetup()
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollection), name: Notification.Name.backButtonPressed, object: nil)
        viewModel.loadCityArray()
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
    
    @objc func updateCollection() {
        viewModel.loadCityArray()
        self.collectionView.reloadData()
    }
    
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
        cell.contentView.cornerRadius()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SearchTableViewCell?
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.text = cell?.cityNameLabel.text
            self.collectionView.isHidden = false
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
                self.collectionView.isHidden = false
            }
            searchButton.isUserInteractionEnabled = false
        } else {
            UIView.animate(withDuration: 0.3) {
                self.tableView.isHidden = false
                self.collectionView.isHidden = true
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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource {
      func collectionSkeletonView(_ collectionView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "FavoriteCollectionViewCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favoriteCityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as? FavoriteCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .white, secondaryColor: .systemBlue), animation: nil, transition: .crossDissolve(0.3))
        cell.cornerRadiusDecorate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            cell.stopSkeletonAnimation()
            cell.hideSkeleton()
        }
        cell.configure(name: viewModel.favoriteCityArray[indexPath.row].name, temp: viewModel.favoriteCityArray[indexPath.row].temp, icon: viewModel.favoriteCityArray[indexPath.row].icon, lat: viewModel.favoriteCityArray[indexPath.row].lat, lon: viewModel.favoriteCityArray[indexPath.row].lon)
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let side = collectionView.frame.size.width / 2 - 5
    
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController else {return}
        controller.accessPoint = "lat=\(viewModel.favoriteCityArray[indexPath.row].lat)&lon=\(viewModel.favoriteCityArray[indexPath.row].lon)"
        controller.town = ""
        controller.myLat = Double(viewModel.favoriteCityArray[indexPath.row].lat) ?? 0
        controller.myLon = Double(viewModel.favoriteCityArray[indexPath.row].lon) ?? 0
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
