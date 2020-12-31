//
//  SearchTableViewCell.swift
//  WeatherAppDiplom
//
//  Created by Андрей Замиралов on 31.12.2020.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(name: String) {
        cityNameLabel.text = name
    }
}
