//
//  ViewController.swift
//  Weather
//
//  Created by Walter Smith on 5/16/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    var weatherViewController = UIHostingController(rootView: WeatherView())
    var queryBox = UITextField(frame: CGRect(x: 50, y: 80, width: 200, height: 50))
    var goButton = UIButton(type: UIButton.ButtonType.roundedRect)
    var queryLabel = UILabel(frame: CGRect(x:50, y:40, width:400, height:40))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(weatherViewController)
        weatherViewController.view.frame = CGRect(x: 50, y: 20, width: 400, height: 400)
        self.view.addSubview(weatherViewController.view)
        queryBox.text = ""
        queryBox.backgroundColor = UIColor.lightGray
        queryBox.frame = CGRect(x: 140, y:480, width: 120, height:40)
        
        goButton.backgroundColor = UIColor.systemBlue
        goButton.backgroundColor = UIColor.systemBlue
        goButton.frame = CGRect(x: 100, y:480, width: 40, height:40)
        
        queryLabel.text = "City by <zip>, <name, [state]>, or <lat, long>"
        queryLabel.frame = CGRect(x: 20, y:520, width: 300, height:40)
        self.view.addSubview(queryBox)
        self.view.addSubview(goButton)
        self.view.addSubview(queryLabel)
        
    }
    
    //TODO: write code to link UIKit to SwiftUI
    func go() {
        
    }
    
}
