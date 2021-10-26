//
//  WeatherVC.swift
//  ssacWeather
//
//  Created by 강호성 on 2021/10/25.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import Kingfisher

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
    
    var locationManager = CLLocationManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDate()
        
        locationManager.delegate = self
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
    
    // MARK: - fetch Data
    
    func configureDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 HH시 mm분"
        
        let dateString = formatter.string(from: Date())
        timeLabel.text = dateString
    }
    
    func configureAddress(_ coordinate: CLLocationCoordinate2D) {
        let geoCoder = CLGeocoder()
        let currentLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let locale = Locale(identifier: "Ko-kr")

        geoCoder.reverseGeocodeLocation(currentLocation, preferredLocale: locale) { (placemarks, error) in
            if error != nil { return }
            guard let place = placemarks?.first else {return}
            
            self.cityLabel.text = "\(place.administrativeArea!), \(place.locality!)"
        }
    }
    
    func fetchCoordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let apikey = Bundle.main.apiKey
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(apikey)&units=metric"
        
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        getData(with: urlString)
    }
    
    func getData(with urlString: String) {
        AF.request(urlString, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                print(json)
                self.configureData(json: json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureData(json: JSON) {
        let temp = json["main"]["temp"].doubleValue
        temperatureLabel.text = "지금은 \(String(format: "%.1f", temp))℃ 에요"
        
        let humidity = json["main"]["humidity"].doubleValue
        humidityLabel.text = "\(humidity)% 만큼 습해요"
        
        let windSpeed = json["wind"]["speed"].doubleValue
        windLabel.text = "\(windSpeed)m/s의 바람이 불어요"
        
        let weatherImage = json["weather"][0]["icon"]
        let url = URL(string: "https://openweathermap.org/img/wn/\(weatherImage)@2x.png")
        weatherImageView.kf.setImage(with: url)
    }
    
    // MARK: - Location Service
    
    func checkLocationServices() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization(authorizationStatus)
        } else {
            let alert = UIAlertController(title: "위치 설정 권한이 필요합니다", message: "설정에 위치 서비스를 켜주세요", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func checkLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        // switch-case문을 통해 GPS 권한 설정 여부에 따라 로직을 나눈다.
        switch authorizationStatus {
        case .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            locationManager.startUpdatingLocation()
            
        case .notDetermined: // 아직 결정 x - 시스템 팝업 호출
            print("GPS 권한 설정되지 않음")
            locationManager.requestWhenInUseAuthorization()
            
        case .denied, .restricted: // 거부 - 설정 창으로 가서 권한을 변경하도록 유도
            print("GPS 권한 요청 거부됨")
            
            AlertHelper.okHandlerAlert(title: "위치 서비스 권한이 거부되었습니다.", message: "설정에서 위치 서비스 권한을 승인해주세요.", onConfirm: {
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }, over: self)
            
        case .authorizedAlways:
            print("항상 허용")
        default:
            print("GPS: Default")
        }
    }
    
    
    // MARK: - Action
    
    @IBAction func handleRefresh(_ sender: UIButton) {
        checkLocationServices()
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            fetchCoordinate(latitude: lat, longitude: lon)
            configureAddress(location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
