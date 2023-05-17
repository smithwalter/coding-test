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
    //var queryBox = UITextField(frame: CGRect(x: 50, y: 80, width: 200, height: 50))
    //var goButton = UIButton(type: UIButton.ButtonType.roundedRect)
    //var queryLabel = UILabel(frame: CGRect(x:50, y:40, width:400, height:40))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(weatherViewController)
        self.view.addSubview(weatherViewController.view)
        //queryBox.text = ""
        //queryBox.backgroundColor = UIColor.lightGray
        //goButton.backgroundColor = UIColor.systemBlue
        //goButton.frame = CGRect(x: 260, y:80, width: 120, height:40)
        //queryLabel.text = "City by <name, [state]> or <lat, long>"
        
        //self.view.addSubview(queryBox)
        //self.view.addSubview(goButton)
        //self.view.addSubview(queryLabel)
        
    }
    func go() {
        
    }
    
}
