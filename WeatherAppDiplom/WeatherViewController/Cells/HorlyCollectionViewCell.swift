import UIKit

class HorlyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    
    
    func configure(time: String, temp: String, icon: String) {
        
        timeLabel.text = time
        tempLabel.text = temp + "°"
        forecastImageView.image = UIImage(named: "\(icon).png")
    }
}
