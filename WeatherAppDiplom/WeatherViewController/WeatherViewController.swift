import UIKit

class WeatherViewController: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var daysView: UIView!
    @IBOutlet weak var feelView: UIView!
    @IBOutlet weak var hoursView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var daysTableView: UITableView!
    @IBOutlet weak var hoursCollectionView: UICollectionView!
    
    //MARK: - VAR
    var town: String = "Saint Petersburg"
    var accessPoint: String = "q="
    let weatherViewModel = WeatherViewModel()
    var myLat: Double = 0
    var myLon: Double = 0
    var favoriteCityArray: [FavoriteCity] = []
    var currentCity = ""
    var detailMyCity = OneCallWelcome()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.gray.withAlphaComponent(0.6))
        weatherViewModel.currentTown = town
        setUp()
        bindUI()
        removeBlurWithGDC()
        weatherViewModel.loadCityArray()
    }
    
    //MARK: - Actions
    @IBAction func backButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name.backButtonPressed, object: nil, userInfo: nil)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            weatherViewModel.addCityToFavorite()
            } else {
                weatherViewModel.removeFromFavorite()
        }
        UserDefaults.standard.set(encodable: weatherViewModel.favoriteCityArray, forKey: "saved")
    }
    
    //MARK: - Func
    func loadFavoriteButtonState() {
        if weatherViewModel.checkFavorite() {
            self.favoriteButton.isSelected = true
        }
    }
    
    func setUp() {
        weatherViewModel.setTown()
        weatherViewModel.accessPoint = accessPoint
        weatherViewModel.myLat = myLat
        weatherViewModel.myLon = myLon
        interfaceShadowsAndCorners()
        weatherViewModel.loadForecast(with: detailMyCity)
        
    }
    
    func removeBlurWithGDC() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.view.activityStopAnimating()
            self.loadFavoriteButtonState()
        }
    }
    
    private func bindUI() {
        weatherViewModel.currentTime.bind { (currentTime) in
            self.currentTimeLabel.text = self.weatherViewModel.fixTime()
            let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(60), repeats: true) { (_) in
                var nextMinute = self.weatherViewModel.addMinuteToTime()
                UIView.animate(withDuration: 0.3) {
                    self.currentTimeLabel.text = nextMinute
                }
            }
        }
        weatherViewModel.currentWeatherTemp.bind { (currentWeatherTemp) in
            self.tempLabel.text = currentWeatherTemp + "°"
        }
        weatherViewModel.currentWeatherName.bind { (currentWeatherName) in
            self.cityLabel.text = currentWeatherName
            self.currentCity = currentWeatherName
        }
        weatherViewModel.currentWeatherHumidity.bind { (currentWeatherHumidity) in
            self.humidityLabel.text = String(currentWeatherHumidity) + "%"
        }
        weatherViewModel.currentWeatherWind.bind { (currentWeatherWind) in
            self.windLabel.text = String(currentWeatherWind)
        }
        weatherViewModel.currentWeatherPressure.bind { (currentWeatherPressure) in
            self.pressureLabel.text = String(currentWeatherPressure)
        }
        weatherViewModel.currentWeatherFellsLike.bind { (currentWeatherFellsLike) in
            self.feelLikeLabel.text = String(currentWeatherFellsLike) + "°"
        }
        weatherViewModel.currentWeatherPicture.bind { (currentWeatherPicture) in
            self.weatherImage.image = UIImage(named: "\(currentWeatherPicture).png")
        }
        weatherViewModel.dailyArray.bind { [weak self] dailyArray in
            self?.daysTableView.reloadData()
            self?.hoursCollectionView.reloadData()
            
        }
        
    }
    
    func interfaceShadowsAndCorners() {
        weatherView.cornerRadius()
        weatherView.dropShadow()
        daysView.cornerRadius()
        feelView.cornerRadius()
        daysView.dropShadow()
    }
}

extension Notification.Name {
    static let backButtonPressed = Notification.Name("backButtonPressed")
}


extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherViewModel.dailyArray.value.first?.daily?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DailyTableViewCell") as? DailyTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: weatherViewModel.dailyArray.value.first?.daily?[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
     
}


extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorlyCollectionViewCell", for: indexPath) as? HorlyCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(time: String(weatherViewModel.getFormattedTime(input: Double(weatherViewModel.dailyArray.value.first?.hourly?[indexPath.row].dt ?? 0))), temp: String(Int(weatherViewModel.dailyArray.value.first?.hourly?[indexPath.row].temp ?? 0)), icon:  weatherViewModel.dailyArray.value.first?.hourly?[indexPath.row].weather?.first?.icon ?? "")
        cell.cornerRadius()
        collectionView.showsHorizontalScrollIndicator = false
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let side = collectionView.frame.size.height - 5
        let width = collectionView.frame.size.height / 1.2
        return CGSize(width: width, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
