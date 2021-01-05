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
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //MARK: - Next weather
    
    @IBOutlet weak var plus3hoursLabel: UILabel!
    @IBOutlet weak var plus3hoursTempLabel: UILabel!
    @IBOutlet weak var plus3hoursImageView: UIImageView!
    
    @IBOutlet weak var next6hoursLabel: UILabel!
    @IBOutlet weak var next6hoursTempLabel: UILabel!
    @IBOutlet weak var next6hoursImageView: UIImageView!
    
    @IBOutlet weak var next9hoursLabel: UILabel!
    @IBOutlet weak var next9hoursTempLabel: UILabel!
    @IBOutlet weak var next9hoursImageView: UIImageView!
    
    @IBOutlet weak var next12hoursLabel: UILabel!
    @IBOutlet weak var next12hoursTempLabel: UILabel!
    @IBOutlet weak var next12hoursImageView: UIImageView!
    
    
    //MARK: - Six days weather
    
    @IBOutlet weak var tommorowLabel: UILabel!
    @IBOutlet weak var tommorowTempLabel: UILabel!
    @IBOutlet weak var tommorowImageView: UIImageView!
    
    @IBOutlet weak var plusTwoDaysLabel: UILabel!
    @IBOutlet weak var plusTwoDaysImageView: UIImageView!
    @IBOutlet weak var plusTwoDaysTempLabel: UILabel!
    
    
    @IBOutlet weak var plusThreeDaysLabel: UILabel!
    @IBOutlet weak var plusThreeDaysTemp: UILabel!
    @IBOutlet weak var plusThreeDaysImageView: UIImageView!
    
    @IBOutlet weak var plusFourDaysLabel: UILabel!
    @IBOutlet weak var plusFourDaysTemp: UILabel!
    @IBOutlet weak var plusFourDaysImageView: UIImageView!
    
    
    
    //MARK: - VAR
    var town: String = "Saint Petersburg"
    var accessPoint: String = "q="
    let weatherViewModel = WeatherViewModel()
    var myLat: Double = 0
    var myLon: Double = 0
    var favoriteCityArray: [FavoriteCity] = []
    var currentCity = ""
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.gray.withAlphaComponent(0.6))
        weatherViewModel.currentTown = town
        setUp()
        removeBlurWithGDC()
        loadCityArray()
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
    
    func loadCityArray() {
        if let favoriteCityArray = UserDefaults.standard.value([FavoriteCity].self, forKey: "saved") {
            self.weatherViewModel.favoriteCityArray = favoriteCityArray
        }
    }
    
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
        weatherViewModel.loadForecast()
        bindUI()
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
            self.weatherImage.downloaded(from: "https://openweathermap.org/img/wn/\(currentWeatherPicture)@4x.png", contentMode: .scaleAspectFill)
        }
        weatherViewModel.plus3hours.bind { (plus3hours) in
            self.plus3hoursLabel.text = String(self.weatherViewModel.getFormattedTime(input: Double(plus3hours)))
        }
        weatherViewModel.plus3hoursTemp.bind { (plus3hoursTemp) in
            self.plus3hoursTempLabel.text = String(plus3hoursTemp) + "°"
        }
        weatherViewModel.plus3hoursImageView.bind { (plus3hoursImageView) in
            self.plus3hoursImageView.downloaded(from: "https://openweathermap.org/img/wn/\(plus3hoursImageView)@4x.png", contentMode: .scaleAspectFill)
        }
        weatherViewModel.next6hours.bind { (next6hours) in
            self.next6hoursLabel.text = String(self.weatherViewModel.getFormattedTime(input: Double(next6hours)))
        }
        weatherViewModel.next6hoursTemp.bind { (next6hoursTemp) in
            self.next6hoursTempLabel.text = String(next6hoursTemp) + "°"
        }
        weatherViewModel.next6hoursImageView.bind { (next6hoursImageView) in
            self.next6hoursImageView.downloaded(from: "https://openweathermap.org/img/wn/\(next6hoursImageView)@4x.png", contentMode: .scaleAspectFill)
        }
        weatherViewModel.next9hours.bind { (next9hours) in
            self.next9hoursLabel.text = String(self.weatherViewModel.getFormattedTime(input: Double(next9hours)))
        }
        weatherViewModel.next9hoursTemp.bind { (next9hoursTemp) in
            self.next9hoursTempLabel.text = String(next9hoursTemp) + "°"
        }
        weatherViewModel.next9hoursImageView.bind { (next9hoursImageView) in
            self.next9hoursImageView.downloaded(from: "https://openweathermap.org/img/wn/\(next9hoursImageView)@4x.png", contentMode: .scaleAspectFill)
        }
        weatherViewModel.next12hours.bind { (next12hours) in
            self.next12hoursLabel.text = String(self.weatherViewModel.getFormattedTime(input: Double(next12hours)))
        }
        weatherViewModel.next12hoursTemp.bind { (next12hoursTemp) in
            self.next12hoursTempLabel.text = String(next12hoursTemp) + "°"
        }
        weatherViewModel.next12hoursImageView.bind { (next12hoursImageView) in
            self.next12hoursImageView.downloaded(from: "https://openweathermap.org/img/wn/\(next12hoursImageView)@4x.png", contentMode: .scaleAspectFill)
        }
        weatherViewModel.tommorowLabel.bind { (tommorowLabel) in
            self.tommorowLabel.text = String(self.weatherViewModel.getFormattedDate(input: Double(tommorowLabel)))
        }
        weatherViewModel.tommorowTempLabel.bind { (tommorowTempLabel) in
            self.tommorowTempLabel.text = String(tommorowTempLabel) + "°"
        }
        weatherViewModel.tommorowImage.bind { (tommorowImage) in
            self.tommorowImageView.downloaded(from: "https://openweathermap.org/img/wn/\(tommorowImage)@4x.png", contentMode: .scaleAspectFit)
        }
        weatherViewModel.plusTwoDays.bind { (plusTwoDays) in
            self.plusTwoDaysLabel.text = String(self.weatherViewModel.getFormattedDate(input: Double(plusTwoDays)))
        }
        weatherViewModel.plusTwoDaysTempLabel.bind { (plusTwoDaysTempLabel) in
            self.plusTwoDaysTempLabel.text = String(plusTwoDaysTempLabel) + "°"
        }
        weatherViewModel.plusTwoDaysImage.bind { (plusTwoDaysImage) in
            self.plusTwoDaysImageView.downloaded(from: "https://openweathermap.org/img/wn/\(plusTwoDaysImage)@4x.png", contentMode: .scaleAspectFit)
        }
        weatherViewModel.plusThreeDays.bind { (plusThreeDays) in
            self.plusThreeDaysLabel.text = String(self.weatherViewModel.getFormattedDate(input: Double(plusThreeDays)))
        }
        weatherViewModel.plusThreeDaysTemp.bind { (plusThreeDaysTemp) in
            self.plusThreeDaysTemp.text = String(plusThreeDaysTemp) + "°"
        }
        weatherViewModel.plusThreeDaysImage.bind { (plusThreeDaysImage) in
            self.plusThreeDaysImageView.downloaded(from: "https://openweathermap.org/img/wn/\(plusThreeDaysImage)@4x.png", contentMode: .scaleAspectFit)
        }
        weatherViewModel.plusFourDays.bind { (plusFourDays) in
            self.plusFourDaysLabel.text = String(self.weatherViewModel.getFormattedDate(input: Double(plusFourDays)))
        }
        weatherViewModel.plusFourDaysTemp.bind { (plusFourDaysTemp) in
            self.plusFourDaysTemp.text = String(plusFourDaysTemp) + "°"
        }
        weatherViewModel.plusFourDaysImage.bind { (plusFourDaysImage) in
            self.plusFourDaysImageView.downloaded(from: "https://openweathermap.org/img/wn/\(plusFourDaysImage)@4x.png", contentMode: .scaleAspectFit)
        }
    }
    
    func interfaceShadowsAndCorners() {
        menuView.cornerRadius()
        menuView.dropShadow()
        weatherView.cornerRadius()
        weatherView.dropShadow()
        daysView.cornerRadius()
        feelView.cornerRadius()
        hoursView.cornerRadius()
        hoursView.dropShadow()
        daysView.dropShadow()
    }
}

extension Notification.Name {
    static let backButtonPressed = Notification.Name("backButtonPressed")
}
