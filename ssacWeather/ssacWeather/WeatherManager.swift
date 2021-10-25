//
//  WeatherManager.swift
//  ssacWeather
//
//  Created by 강호성 on 2021/10/25.
//

import Foundation
import CoreLocation
import Alamofire

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3bd336680248f3f4d90c941f6d034673&units=metric"
    
    func fetchCoordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        requestURL(with: urlString)
    }
    
    func requestURL(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil { print("Error Request"); return }
                
                if let data = data {
                    let dataString = String(data: data, encoding: .utf8)
                    print(dataString ?? "")
                    
                }
            }
            task.resume()
        }
    }
    
}
