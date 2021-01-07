import UIKit

class DailyTableViewCell: UITableViewCell {
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    
    let weatherViewModel = WeatherViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with: OneCallDaily?) {
        self.dayNameLabel.text = String(self.weatherViewModel.getFormattedDate(input: with?.dt ?? 5))
        self.tempLabel.text = String(Int(with?.temp?.day ?? 0)) + "°"
        self.forecastImageView.image = UIImage(named: "\(with?.weather?.first?.icon ?? "").png")
        
    }
}
