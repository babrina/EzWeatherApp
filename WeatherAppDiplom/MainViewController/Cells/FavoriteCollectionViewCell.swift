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
                    self.weatherImageView.image = UIImage(named: "\(object.current?.weather?.first?.icon ?? "01d").png")
                    self.tempLabel.text = String(Int(object.current?.temp ?? 0)) + "°"
                    
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
//    func configure(name: String, temp: String, icon: String, lat: String, lon: String) {
    func configure(with: FavoriteCity) {
        self.lat = with.lat
        self.lon = with.lon
        self.nameLabel.text = with.name
        sendOneCallForecast()
        
    }
}
