import UIKit
import Foundation

class WeatherViewModel {
    //MARK: - VAR
    var currentTown: String = "Saint Petersburg"
    var accessPoint = "q="
    var lat: Double = 59.8944
    var lon: Double = 30.2642
    //MARK: - LET
    let currentWeatherTemp: Bindable<String> = Bindable("")
    let timeZone: Bindable<Int> = Bindable(0)
    let currentTime: Bindable<Int> = Bindable(0)
    let currentWeatherHumidity: Bindable<Int> = Bindable(0)
    let currentWeatherName: Bindable<String> = Bindable("")
    let currentWeatherWind: Bindable<Int> = Bindable(0)
    let currentWeatherPressure: Bindable<Int> = Bindable(0)
    let currentWeatherFellsLike: Bindable<Int> = Bindable(0)
    let currentWeatherPicture: Bindable<String> = Bindable("")
    let currentWeatherLat: Bindable<Double> = Bindable(0)
    let currentWeatherLon: Bindable<Double> = Bindable(0)
    let plus3hours: Bindable<Int> = Bindable(0)
    let plus3hoursTemp: Bindable<Int> = Bindable(0)
    let plus3hoursImageView: Bindable<String> = Bindable("")
    let next6hours: Bindable<Int> = Bindable(0)
    let next6hoursTemp: Bindable<Int> = Bindable(0)
    let next6hoursImageView: Bindable<String> = Bindable("")
    let next9hours: Bindable<Int> = Bindable(0)
    let next9hoursTemp: Bindable<Int> = Bindable(0)
    let next9hoursImageView: Bindable<String> = Bindable("")
    let next12hours: Bindable<Int> = Bindable(0)
    let next12hoursTemp: Bindable<Int> = Bindable(0)
    let next12hoursImageView: Bindable<String> = Bindable("")
    let tommorowLabel: Bindable<Int> = Bindable(0)
    let tommorowImage: Bindable<String> = Bindable("")
    let tommorowTempLabel: Bindable<Int> = Bindable(0)
    let plusTwoDays: Bindable<Int> = Bindable(0)
    let plusTwoDaysImage: Bindable<String> = Bindable("")
    let plusTwoDaysTempLabel: Bindable<Int> = Bindable(0)
    let plusThreeDays: Bindable<Int> = Bindable(0)
    let plusThreeDaysImage: Bindable<String> = Bindable("")
    let plusThreeDaysTemp: Bindable<Int> = Bindable(0)
    let plusFourDays: Bindable<Int> = Bindable(0)
    let plusFourDaysImage: Bindable<String> = Bindable("")
    let plusFourDaysTemp: Bindable<Int> = Bindable(0)
    //MARK: - Funcs
    func setTown() {
        currentTown = currentTown.urlEncoded()!
        
    }
    
    func loadForecast() {
        RequestManager.shared.sendDayForecast(town: currentTown, accessPoint: accessPoint) { [weak self] object in
            self?.currentWeatherTemp.value = String(Int(object?.main.temp ?? 0))
            self?.currentWeatherName.value = object?.name ?? ""
            self?.currentWeatherHumidity.value = Int(object?.main.humidity ?? 0)
            self?.currentWeatherWind.value = Int(object?.wind.speed ?? 0)
            self?.currentWeatherPressure.value = Int(object?.main.pressure ?? 0)
            self?.currentWeatherFellsLike.value = Int(object?.main.feelsLike ?? 0)
            self?.currentWeatherPicture.value = object?.weather[0].icon ?? ""
            self?.currentWeatherLat.value = object?.coord.lat ?? 0
            self?.currentWeatherLon.value = object?.coord.lon ?? 0
            self?.timeZone.value = object?.timezone ?? 0
            self?.currentTime.value = object?.dt ?? 0
            
        }
        RequestManager.shared.sendDailyForecast(town: currentTown, accessPoint: accessPoint) { [weak self] object in
            self?.plus3hours.value = object?.list[0].dt ?? 0
            self?.plus3hoursTemp.value = Int(object?.list[0].main.temp ?? 0)
            self?.plus3hoursImageView.value = object?.list[0].weather[0].icon ?? ""
            self?.next6hours.value = object?.list[1].dt ?? 0
            self?.next6hoursTemp.value = Int(object?.list[1].main.temp ?? 0)
            self?.next6hoursImageView.value = object?.list[1].weather[0].icon ?? ""
            self?.next9hours.value = object?.list[2].dt ?? 0
            self?.next9hoursTemp.value = Int(object?.list[2].main.temp ?? 0)
            self?.next9hoursImageView.value = object?.list[2].weather[0].icon ?? ""
            self?.next12hours.value = object?.list[3].dt ?? 0
            self?.next12hoursTemp.value = Int(object?.list[3].main.temp ?? 0)
            self?.next12hoursImageView.value = object?.list[3].weather[0].icon ?? ""
            self?.tommorowLabel.value = object?.list[9].dt ?? 0
            self?.tommorowTempLabel.value = Int(object?.list[9].main.temp ?? 0)
            self?.tommorowImage.value = String(object?.list[9].weather[0].icon?.dropLast() ?? "") + "d"
            self?.plusTwoDays.value = object?.list[17].dt ?? 0
            self?.plusTwoDaysTempLabel.value = Int(object?.list[17].main.temp ?? 0)
            self?.plusTwoDaysImage.value = String(object?.list[17].weather[0].icon?.dropLast() ?? "") + "d"
            self?.plusThreeDays.value = object?.list[25].dt ?? 0
            self?.plusThreeDaysTemp.value = Int(object?.list[25].main.temp ?? 0)
            self?.plusThreeDaysImage.value = String(object?.list[25].weather[0].icon?.dropLast() ?? "") + "d"
            self?.plusFourDays.value = object?.list[33].dt ?? 0
            self?.plusFourDaysTemp.value = Int(object?.list[33].main.temp ?? 0)
            self?.plusFourDaysImage.value = String(object?.list[33].weather[0].icon?.dropLast() ?? "") + "d"
        }
    }
}
