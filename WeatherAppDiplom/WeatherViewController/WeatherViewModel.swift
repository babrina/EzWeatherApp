import UIKit
import Foundation
import SkeletonView

class WeatherViewModel {
    //MARK: - VAR
    var currentTown: String = "Saint Petersburg"
    var accessPoint = "q="
    var myLat: Double = 59.8944
    var myLon: Double = 30.2642
    var favoriteCityArray: [FavoriteCity] = []
    var currentTemp = 0
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
    let currentTypeWeather: Bindable<String> = Bindable("")
    let currentMaxTemp: Bindable<String> = Bindable("")
    let currentMinTemp: Bindable<String> = Bindable("")
    let currentCountry: Bindable<String> = Bindable("")
    let country: Bindable<String> = Bindable("")
    var dailyArray: Bindable<[OneCall]> = Bindable([OneCall]())
    
    //MARK: - Funcs
    
    func loadCityArray() {
        if let favoriteCityArray = UserDefaults.standard.value([FavoriteCity].self, forKey: "saved") {
            self.favoriteCityArray = favoriteCityArray
        }
    }
    
    func removeFromFavorite() {
        if let index = self.favoriteCityArray.firstIndex(where: {$0.name == currentWeatherName.value}) {
            self.favoriteCityArray.remove(at: index)
        }
    }
    
    func checkFavorite() -> Bool {
        if self.favoriteCityArray.contains(where: {$0.name == self.currentWeatherName.value}) {
        return true
        }
        return false
    }
    
    func addCityToFavorite() {
        if !favoriteCityArray.contains(where: {$0.name == currentWeatherName.value}) {
            self.favoriteCityArray.append(.init(lat: String(myLat),
                                                lon: String(myLon),
                                                name: currentWeatherName.value,
                                                temp: String(currentWeatherTemp.value),
                                                icon: currentWeatherPicture.value,
                                                country: currentCountry.value))
        }
    }
    
    func setTown() -> String {
        return currentTown.urlEncoded() ?? "Saint Petersburg"

    }
    
    func addMinuteToTime() -> String {
        let nextMinute = String(self.getFormattedTime(input: Double(self.currentTime.value + 60)))
        return nextMinute
    }
    
    func fixTime() -> String {
        let time = String(self.getFormattedTime(input: Double(self.currentTime.value)))
        return time
    }
    
    func loadForecast(with: OneCall?) {
        RequestManager.shared.sendDayForecast(town: currentTown, accessPoint: accessPoint) { [weak self] current in
            self?.currentWeatherTemp.value = String(Int(current?.main.temp ?? 0))
            self?.currentWeatherName.value = current?.name ?? ""
            self?.currentWeatherHumidity.value = Int(current?.main.humidity ?? 0)
            self?.currentWeatherWind.value = Int(current?.wind.speed ?? 0)
            self?.currentWeatherPressure.value = Int(current?.main.pressure ?? 0)
            self?.currentWeatherFellsLike.value = Int(current?.main.feelsLike ?? 0)
            self?.currentWeatherPicture.value = current?.weather[0].icon ?? ""
            self?.myLat = current?.coord.lat ?? 0
            self?.myLon = current?.coord.lon ?? 0
            self?.currentTime.value = current?.dt ?? 0
            self?.timeZone.value = current?.timezone ?? 0
            self?.country.value = current?.sys.country ?? ""
            self?.currentTypeWeather.value = current?.weather[0].main ?? ""
            self?.currentMinTemp.value = String(Int(current?.main.tempMin ?? 0))
            self?.currentMaxTemp.value = String(Int(current?.main.tempMax ?? 0))
            self?.currentCountry.value = current?.sys.country ?? ""
            RequestManager.shared.sendOneCallForecast(lat: String(self?.myLat ?? 0), lon: String(self?.myLon ?? 0)) { [weak self] oneCall in
                guard let myCity = oneCall else {return}
                DispatchQueue.main.async {
                    self?.dailyArray.value.append(myCity)
                }
            }
        }
    }
    
    func getFormattedTime(input: Double) -> String {
        let time = Date(timeIntervalSince1970: input)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone.value)
        let localTime = dateFormatter.string(from: time)
        return localTime
    }
    
    func getFormattedDate(input: Double) -> String {
        let date = Date(timeIntervalSince1970: input)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone.value)
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
