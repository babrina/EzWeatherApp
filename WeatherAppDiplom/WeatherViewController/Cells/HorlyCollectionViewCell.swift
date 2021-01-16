import UIKit

class HorlyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
   
    
    func configure(time: String, temp: String) {
        
        timeLabel.text = time
        tempLabel.text = temp + "°"
    }
}
