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
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=APIkey&units=metric"
    
    func fetchCoordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
//        getData()
    }
    
    func getData() {
        
    }
    
}
