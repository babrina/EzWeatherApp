import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    
   
    func configure(with: FavoriteCity) {
    
        self.nameLabel.text = with.name
        self.countryLabel.text = with.country
        RequestManager.shared.sendOneCallForecast(lat: with.lat, lon: with.lon) { [weak self] object in
            DispatchQueue.main.async {
                self?.weatherImageView.image = UIImage(named: "\(object?.current?.weather?.first?.icon ?? "01d").png")
                self?.tempLabel.text = String(Int(object?.current?.temp ?? 0)) + "°"
            }
        }
        
    }
}
