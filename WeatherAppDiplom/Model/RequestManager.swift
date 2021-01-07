import UIKit
import Alamofire


class RequestManager {
    
    static let shared = RequestManager()
    private init() {}
    
    func sendDayForecast(town: String, accessPoint: String, complition: @escaping (ParseCurrentDay?) -> ()) {
        let unFormattedURL = "https://api.openweathermap.org/data/2.5/weather?\(accessPoint)\(town)&appid=9447cdea74b8b95f4fc841ab07797377&units=metric"
        guard let url = URL(string: unFormattedURL) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
            do {
                let object = try JSONDecoder().decode(ParseCurrentDay.self, from: data)
                complition(object)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    
    
    func alamo() {
        
    }

    func sendOneCallForecast(lat: String, lon: String, complition: @escaping (OneCallWelcome?)->()) {
        let unFormattedURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,alerts&appid=9447cdea74b8b95f4fc841ab07797377&units=metric"
        guard let url = URL(string: unFormattedURL) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
            do {
                let object = try JSONDecoder().decode(OneCallWelcome.self, from: data)
                complition(object)
                print()
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}
