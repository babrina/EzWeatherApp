//
//  TestViewController.swift
//  WeatherAppDiplom
//
//  Created by Андрей Замиралов on 26.11.2020.
//

import UIKit
import AutocompleteField

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let textfield = AutocompleteField(frame: CGRect(x: view.frame.midX, y: view.frame.midY, width: 200, height: 40))
        textfield.placeholder = "City"

        textfield.suggestions = [
          "Washington",
          "Berlin",
          "Minsk",
          "Saint Petersburg",
          "New York",
        ]

        self.view.addSubview(textfield)
        
    }
    

    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
