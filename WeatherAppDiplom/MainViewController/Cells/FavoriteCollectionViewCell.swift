import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var lat: String = ""
    var lon: String = ""
    
    func sendOneCallForecast() {
        let unFormattedURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,alerts&appid=9447cdea74b8b95f4fc841ab07797377&units=metric"
        guard let url = URL(string: unFormattedURL) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
            do {
                let object = try JSONDecoder().decode(OneCallWelcome.self, from: data)
                DispatchQueue.main.async {
                    self.weatherImageView.downloaded(from: "https://openweathermap.org/img/wn/\(object.current.weather[0].icon)@4x.png", contentMode: .scaleAspectFit)
                    self.tempLabel.text = String(Int(object.current.temp)) + "°"
                    
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func configure(name: String, temp: String, icon: String, lat: String, lon: String) {
        self.lat = lat
        self.lon = lon
        self.nameLabel.text = name
        sendOneCallForecast()
        
    }
}
