//
//  ViewController.swift
//  Weather
//
//  Created by Walter Smith on 5/16/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    
    @IBAction func goButtonTouch(_ sender: Any) {
        //print(queryBox.text)
        weatherViewController.rootView.wvd.getWeather(query: queryBox.text ?? "")
        
    }
    @IBOutlet weak var queryBox: UITextField!
    
    var weatherViewController = UIHostingController(rootView: WeatherView())

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(weatherViewController)
        weatherViewController.view.frame = CGRect(x: 50, y: 20, width: 400, height: 400)
        self.view.addSubview(weatherViewController.view)
        
    }
    
    //TODO: write code to link UIKit to SwiftUI
    func go() {
        
    }
    
}
