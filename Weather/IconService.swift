//
//  IconService.swift
//  Weather
//
//  Created by Walter Smith on 5/16/23.
//

import Foundation
import UIKit

protocol IconServiceDelegate {
    func iconDidFinishLoad(_ service: IconService) -> Void
}

class IconService {
    var image: UIImage?
    var delegate: IconServiceDelegate?
    
    func fetch(code:String) {
        guard let url = URL(string:"https://openweathermap.org/img/wn/\(code)@2x.png") else {return}
        let urlSession = URLRequest(url:url)
        let task = URLSession.shared.dataTask(with:urlSession) { [weak self] data, response, error in
            if let data = data {
                self?.image = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.delegate?.iconDidFinishLoad(self!)
                }
            }
        }
        task.resume()
    }
}
