import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(name: String) {
        cityNameLabel.text = name
    }
}
