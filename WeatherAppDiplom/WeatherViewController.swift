import UIKit

class WeatherViewController: UIViewController {
    //MARK: - OUTLETS
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var daysView: UIView!
    @IBOutlet weak var feelView: UIView!
    @IBOutlet weak var hoursView: UIView!
    
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
    
    @IBOutlet weak var plusFiveDaysImageView: UIImageView!
    @IBOutlet weak var plusFiveDaysLabel: UILabel!
    @IBOutlet weak var plusFiveDaysTemp: UILabel!
    
    
    //MARK: - VAR
    var apiKey = "9447cdea74b8b95f4fc841ab07797377"
    var town: String = "Saint Petersburg"
    var accsessPoint = "q="
    var lat: Double = 59.8944
    var lon: Double = 30.2642
    var currentWeather = CurrentWeather()
    var dailyWeather = NextDaysWeather()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setUp() {
        setTown()
        makeCornerInterface()
        loadForecast()
    }
    
    func setTown() {
        town = town.urlEncoded()!
    }
    
    func loadForecast() {
        
        sendRequest {  [weak self] сurrentWeather in
            
            self?.grabDaily { [weak self] dailyWeather in
                DispatchQueue.main.async {
                    self?.plus3hoursLabel.text = dailyWeather.nextThreeHours
                    self?.plus3hoursTempLabel.text = dailyWeather.nextThreeHoursTemp + "°"
                    self?.plus3hoursImageView.downloaded(from: "https://openweathermap.org/img/wn/\(dailyWeather.nextThreeHoursPicture)@4x.png")
                    
                    
                    self?.next6hoursLabel.text = dailyWeather.nextSixHours
                    self?.next6hoursTempLabel.text = dailyWeather.nextSixHoursTemp + "°"
                    self?.next6hoursImageView.downloaded(from: "https://openweathermap.org/img/wn/\(dailyWeather.nextSixHoursPicture)@4x.png")
                    
                    self?.next9hoursLabel.text = dailyWeather.nextEightHours
                    self?.next9hoursTempLabel.text = dailyWeather.nextEightHoursTemp + "°"
                    self?.next9hoursImageView.downloaded(from: "https://openweathermap.org/img/wn/\(dailyWeather.nextEightHoursPicture)@4x.png")
                    
                    self?.next12hoursLabel.text = dailyWeather.nextTwelveHours
                    self?.next12hoursTempLabel.text = dailyWeather.nextTwelveHoursTemp + "°"
                    self?.next12hoursImageView.downloaded(from: "https://openweathermap.org/img/wn/\(dailyWeather.nextTwelveHoursPicture)@4x.png")
                    
                    self?.tommorowLabel.text = dailyWeather.nextDay
                    self?.tommorowImageView.downloaded(from: "https://openweathermap.org/img/wn/\(dailyWeather.nextDayPicture)@4x.png")
                    self?.tommorowTempLabel.text = dailyWeather.nextDayTemp + "°"
                    
                    self?.plusTwoDaysLabel.text = dailyWeather.secondNextDay
                    self?.plusTwoDaysImageView.downloaded(from: "https://openweathermap.org/img/wn/\(dailyWeather.secondNextDayPicture)@4x.png")
                    self?.plusTwoDaysTempLabel.text = dailyWeather.secondNextDayTemp + "°"
                    
                    self?.plusThreeDaysLabel.text = dailyWeather.thirdNextDay
                    self?.plusThreeDaysImageView.downloaded(from: "https://openweathermap.org/img/wn/\(dailyWeather.thirdNextDayPicture)@4x.png")
                    self?.plusThreeDaysTemp.text = dailyWeather.thirdNextDayTemp + "°"
                    
                    self?.plusFourDaysLabel.text = dailyWeather.fourthNextDay
                    self?.plusFourDaysImageView.downloaded(from: "https://openweathermap.org/img/wn/\(dailyWeather.fourthNextDayPicture)@4x.png")
                    self?.plusFourDaysTemp.text = dailyWeather.fourthNextDayTemp + "°"
                    
                    self?.plusFiveDaysLabel.text = dailyWeather.fifthNextDay
                    self?.plusFiveDaysImageView.downloaded(from: "https://openweathermap.org/img/wn/\(dailyWeather.fifthNextDayPicture)@4x.png")
                    self?.plusFiveDaysTemp.text = dailyWeather.fifthNextDayTemp + "°"
                    
                    guard let currentlat = self?.currentWeather.lat else {return}
                    self?.lat = currentlat
                    
                    guard let currentlon = self?.currentWeather.lon else {return}
                    self?.lon = currentlon
                    
                    guard let currentTempLabel = self?.currentWeather.temp else {return}
                    self?.tempLabel.text = String(Int(currentTempLabel)) + "°"
                    
                    
                    self?.cityLabel.text = self!.currentWeather.name
                    self?.humidityLabel.text = String(self!.currentWeather.humidity) + "%"
                    self?.windLabel.text = String(self!.currentWeather.wind)
                    self?.pressureLabel.text = String(self!.currentWeather.pressure)
                    self?.feelLikeLabel.text = String(Int(self!.currentWeather.feelsLike)) + "°"
                    self!.weatherImage.downloaded(from: "https://openweathermap.org/img/wn/\(self!.currentWeather.picture)@4x.png")
                }
            }
        }
    }
    
    func makeCornerInterface() {
        weatherView.cornerRadius()
        weatherView.dropShadow()
        daysView.cornerRadius()
        feelView.cornerRadius()
        hoursView.cornerRadius()
        hoursView.dropShadow()
        daysView.dropShadow()
    }
    
    
    func sendRequest(complition: @escaping (CurrentWeather) -> ()) {
        
        let unFormattedURL = "https://api.openweathermap.org/data/2.5/weather?\(accsessPoint)\(town)&appid=9447cdea74b8b95f4fc841ab07797377&units=metric"
        
        guard let url = URL(string: unFormattedURL) else {return}
        
        
        
        let task = URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            guard let dataResponse = data,
                  error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                                                                        dataResponse, options: [])
                let object = try JSONDecoder().decode(Welcome.self, from: data!)
                
                guard let temp = object.main.temp as? Double else {return}
                self.currentWeather.temp = Double(temp)
                
                guard let humidity = object.main.humidity as? Double else {return}
                self.currentWeather.humidity = Int(humidity)
                
                guard let name = object.name as? String else {return}
                self.currentWeather.name = name
                
                guard let wind = object.wind.speed as? Double else {return}
                self.currentWeather.wind = Int(wind)
                
                guard let pressure = object.main.pressure as? Double else {return}
                self.currentWeather.pressure = Int(pressure)
                
                guard let feel = object.main.feelsLike as? Double else {return}
                self.currentWeather.feelsLike = Double(feel)
                
                guard let description = object.weather[0].main as? String else {return}
                self.currentWeather.picture = description
                
                guard let lat = object.coord.lat as? Double else {return}
                self.currentWeather.lat = lat
                
                
                guard let lon = object.coord.lon as? Double else {return}
                self.currentWeather.lon = lon
                
                guard let icon = object.weather[0].icon as? String else {return}
                self.currentWeather.picture = icon
                
                complition(self.currentWeather)
                
                print(jsonResponse) //Response result
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    
    func grabDaily(complition: @escaping (NextDaysWeather) -> ()) {
        
        let unFormattedURL = "https://api.openweathermap.org/data/2.5/forecast?\(accsessPoint)\(town)&appid=9447cdea74b8b95f4fc841ab07797377&units=metric"
        
        guard let url = URL(string: unFormattedURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                  error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                                                                        dataResponse, options: [])
                let object = try JSONDecoder().decode(WelcomeNextDays.self, from: data!)
                // next 3 hours
                guard let timeFirst = object.list[0].dt as? Int else {return}
                self.dailyWeather.nextThreeHours = String(self.getFormattedDate(input: Double(timeFirst), format: "HH:mm"))
                guard let tempFirst = object.list[0].main.temp as? Double else {return}
                self.dailyWeather.nextThreeHoursTemp = String(Int(tempFirst))
                guard let picFirst = object.list[0].weather[0].icon as? String else {return}
                self.dailyWeather.nextThreeHoursPicture = picFirst
                
                
                // next 6 hours
                guard let timeSecond = object.list[1].dt as? Int else {return}
                self.dailyWeather.nextSixHours = String(self.getFormattedDate(input: Double(timeSecond), format: "HH:mm"))
                guard let tempSecond = object.list[1].main.temp as? Double else {return}
                self.dailyWeather.nextSixHoursTemp = String(Int(tempFirst))
                guard let picSecond = object.list[1].weather[0].icon as? String else {return}
                self.dailyWeather.nextSixHoursPicture = picFirst
                
                // next 9 hours
                guard let timeThird = object.list[2].dt as? Int else {return}
                self.dailyWeather.nextEightHours = String(self.getFormattedDate(input: Double(timeThird), format: "HH:mm"))
                guard let tempThird  = object.list[2].main.temp as? Double else {return}
                self.dailyWeather.nextEightHoursTemp = String(Int(tempThird))
                guard let picThird  = object.list[2].weather[0].icon as? String else {return}
                self.dailyWeather.nextEightHoursPicture = picThird
                
                // next 12 hours
                guard let timeFourth = object.list[3].dt as? Int else {return}
                self.dailyWeather.nextTwelveHours = String(self.getFormattedDate(input: Double(timeFourth), format: "HH:mm"))
                guard let tempFourth = object.list[3].main.temp as? Double else {return}
                self.dailyWeather.nextTwelveHoursTemp = String(Int(tempThird))
                guard let picFourth  = object.list[3].weather[0].icon else {return}
                self.dailyWeather.nextTwelveHoursPicture = picFourth
                
                
                // next days
                guard let timeNextDay = object.list[9].dt as? Int else {return}
                self.dailyWeather.nextDay = String(self.getFormattedDate(input: Double(timeNextDay)))
                guard let iconNextDay = object.list[9].weather[0].icon else {return}
                self.dailyWeather.nextDayPicture = iconNextDay
                guard let tempNextDay = object.list[9].main.temp as? Double else {return}
                self.dailyWeather.nextDayTemp = String(Int(tempNextDay))
                
                guard let timeSecondNextDay = object.list[17].dt as? Int else {return}
                self.dailyWeather.secondNextDay = String(self.getFormattedDate(input: Double(timeSecondNextDay)))
                guard let iconSecondNextDay = object.list[17].weather[0].icon as? String else {return}
                self.dailyWeather.secondNextDayPicture = iconSecondNextDay
                guard let tempSecondNextDay = object.list[17].main.temp as? Double else {return}
                self.dailyWeather.secondNextDayTemp = String(Int(tempSecondNextDay))
                
                guard let timeThirdNextDay = object.list[25].dt as? Int else {return}
                self.dailyWeather.thirdNextDay = String(self.getFormattedDate(input: Double(timeThirdNextDay)))
                guard let iconThirdNextDay = object.list[25].weather[0].icon else {return}
                self.dailyWeather.thirdNextDayPicture = iconThirdNextDay
                guard let tempThirdNextDay = object.list[25].main.temp as? Double else {return}
                self.dailyWeather.thirdNextDayTemp = String(Int(tempThirdNextDay))
                
                guard let timeFourthNextDay = object.list[33].dt as? Int else {return}
                self.dailyWeather.fourthNextDay = String(self.getFormattedDate(input: Double(timeFourthNextDay)))
                guard let iconFourthNextDay = object.list[33].weather[0].icon else {return}
                self.dailyWeather.fourthNextDayPicture = iconFourthNextDay
                guard let tempFourthNextDay = object.list[33].main.temp as? Double else {return}
                self.dailyWeather.fourthNextDayTemp = String(Int(tempFourthNextDay))
                
                guard let timeFifthNextDay = object.list[39].dt as? Int else {return}
                self.dailyWeather.fifthNextDay = String(self.getFormattedDate(input: Double(timeFifthNextDay)))
                guard let iconFifthNextDay = object.list[39].weather[0].icon else {return}
                self.dailyWeather.fifthNextDayPicture = iconFifthNextDay
                guard let tempFifthNextDay = object.list[39].main.temp as? Double else {return}
                self.dailyWeather.fifthNextDayTemp = String(Int(tempFifthNextDay))
                
                complition(self.dailyWeather)
                
                print(jsonResponse) //Response result
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    
    func getFormattedDate(input: Double,format: String = "EEEE, d") -> String {
        let date = Date(timeIntervalSince1970: input)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}




extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }
        .resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


public extension CharacterSet {
    
    static let urlQueryParameterAllowed = CharacterSet.urlQueryAllowed.subtracting(CharacterSet(charactersIn: "&?"))
    
    static let urlQueryDenied           = CharacterSet.urlQueryAllowed.inverted()
    static let urlQueryKeyValueDenied   = CharacterSet.urlQueryParameterAllowed.inverted()
    static let urlPathDenied            = CharacterSet.urlPathAllowed.inverted()
    static let urlFragmentDenied        = CharacterSet.urlFragmentAllowed.inverted()
    static let urlHostDenied            = CharacterSet.urlHostAllowed.inverted()
    
    static let urlDenied                = CharacterSet.urlQueryDenied
        .union(.urlQueryKeyValueDenied)
        .union(.urlPathDenied)
        .union(.urlFragmentDenied)
        .union(.urlHostDenied)
    
    
    func inverted() -> CharacterSet {
        var copy = self
        copy.invert()
        return copy
    }
}



public extension String {
    func urlEncoded(denying deniedCharacters: CharacterSet = .urlDenied) -> String? {
        return addingPercentEncoding(withAllowedCharacters: deniedCharacters.inverted())
    }
}
