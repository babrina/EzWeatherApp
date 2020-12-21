import UIKit

class RequestManager {
    
    static let shared = RequestManager()
    private init() {}
    
    
    var weatherViewModel = WeatherViewModel()
    
    
    func sendDayForecast(town: String, complition: @escaping (ParseCurrentDay?) -> ()) {
       
        let unFormattedURL = "https://api.openweathermap.org/data/2.5/weather?\(weatherViewModel.accsessPoint)\(town)&appid=9447cdea74b8b95f4fc841ab07797377&units=metric"
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

    func sendDailyForecast(town: String, complition: @escaping (ParseNextDays?)->()) {

        let unFormattedURL = "https://api.openweathermap.org/data/2.5/forecast?\(weatherViewModel.accsessPoint)\(town)&appid=9447cdea74b8b95f4fc841ab07797377&units=metric"
        guard let url = URL(string: unFormattedURL) else {return}

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
            do {
                let object = try JSONDecoder().decode(ParseNextDays.self, from: data)
             
                complition(object)
                print()
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
}
