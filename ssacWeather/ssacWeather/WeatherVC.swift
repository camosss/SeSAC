//
//  WeatherVC.swift
//  ssacWeather
//
//  Created by 강호성 on 2021/10/25.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDate()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    // MARK: - Helper
    
    func makeRadius(label: UILabel) {
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
    }
    
    func configureUI() {
        makeRadius(label: temperatureLabel)
        makeRadius(label: humidityLabel)
        makeRadius(label: windLabel)
        makeRadius(label: textLabel)
        
        weatherImageView.clipsToBounds = true
        weatherImageView.layer.cornerRadius = 10
    }
    
    func configureDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 HH시 mm분"
        
        let dateString = formatter.string(from: Date())
        timeLabel.text = dateString
    }
    
    
    // MARK: - Action
    
    @IBAction func handleShare(_ sender: UIButton) {
        print("share")
    }
    
    @IBAction func handleRefresh(_ sender: UIButton) {
        print("refresh")
    }
    
    
}

// MARK: - CLLocationManagerDelegate

extension WeatherVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchCoordinate(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
