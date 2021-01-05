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
    let country: Bindable<String> = Bindable("")
    
    //MARK: - Funcs
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
                                                icon: currentWeatherPicture.value))
        }
    }
    
    func setTown() {
        currentTown = currentTown.urlEncoded()!
    }
    
    func addMinuteToTime() -> String {
        var nextMinute = String(self.getFormattedTime(input: Double(self.currentTime.value + 60)))
        return nextMinute
    }
    
    func fixTime() -> String {
        let time = String(self.getFormattedTime(input: Double(self.currentTime.value)))
        return time
    }
    
    func loadForecast() {
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
            RequestManager.shared.sendOneCallForecast(lat: String(self?.myLat ?? 0), lon: String(self?.myLon ?? 0)) { [weak self] oneCall in
                self?.plus3hours.value = Int(oneCall?.hourly[1].dt ?? 0)
                self?.plus3hoursTemp.value = Int(oneCall?.hourly[1].temp ?? 0)
                self?.plus3hoursImageView.value = oneCall?.hourly[1].weather[0].icon ?? ""
                self?.next6hours.value = Int(oneCall?.hourly[2].dt ?? 0)
                self?.next6hoursTemp.value = Int(oneCall?.hourly[2].temp ?? 0)
                self?.next6hoursImageView.value = oneCall?.hourly[2].weather[0].icon ?? ""
                self?.next9hours.value = Int(oneCall?.hourly[3].dt ?? 0)
                self?.next9hoursTemp.value = Int(oneCall?.hourly[3].temp ?? 0)
                self?.next9hoursImageView.value = oneCall?.hourly[3].weather[0].icon ?? ""
                self?.next12hours.value = Int(oneCall?.hourly[4].dt ?? 0)
                self?.next12hoursTemp.value = Int(oneCall?.hourly[4].temp ?? 0)
                self?.next12hoursImageView.value = oneCall?.hourly[4].weather[0].icon ?? ""
                self?.tommorowTempLabel.value = Int(oneCall?.daily[1].temp.day ?? 0)
                self?.tommorowImage.value = oneCall?.daily[1].weather[0].icon ?? ""
                self?.tommorowLabel.value = Int(oneCall?.daily[1].dt ?? 0)
                self?.plusTwoDays.value = Int(oneCall?.daily[2].dt ?? 0)
                self?.plusTwoDaysTempLabel.value = Int(oneCall?.daily[2].temp.day ?? 0)
                self?.plusTwoDaysImage.value = oneCall?.daily[2].weather[0].icon ?? ""
                self?.plusThreeDays.value = Int(oneCall?.daily[3].dt ?? 0)
                self?.plusThreeDaysTemp.value = Int(oneCall?.daily[3].temp.day ?? 0)
                self?.plusThreeDaysImage.value = oneCall?.daily[3].weather[0].icon ?? ""
                self?.plusFourDays.value = Int(oneCall?.daily[4].dt ?? 0)
                self?.plusFourDaysTemp.value = Int(oneCall?.daily[4].temp.day ?? 0)
                self?.plusFourDaysImage.value = oneCall?.daily[4].weather[0].icon ?? ""
            }
        }
    }
    
    func getFormattedTime(input: Double) -> String {
        let date = Date(timeIntervalSince1970: input)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone.value)
        let localDate = dateFormatter.string(from: date)
        return localDate
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
