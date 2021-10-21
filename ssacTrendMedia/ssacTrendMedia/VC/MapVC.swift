//
//  MapVC.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    
    var locationManager = CLLocationManager()
    var previousLocation: CLLocation? // 현재 위치 저장
    let regionInMeters: Double = 10000
    
    let mapAnnotations = MapAnnotations()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        filterButton.layer.cornerRadius = 50/2
    }
    
    // MARK: - Action
    
    @IBAction func handleFilter(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for theater in TheaterOptions.allCases {
            alert.addAction(UIAlertAction(title: theater.description, style: .default, handler: { _ in
                self.getTheaterAnnotations(theater.description)
            }))
        }
        
        let all = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.allAnnotations()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(all)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Helper
    
    // 1. 위치서비스 권한 확인
    func checkLocationServices() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14, *) { authorizationStatus = locationManager.authorizationStatus }
        else { authorizationStatus = CLLocationManager.authorizationStatus() }
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization(authorizationStatus)
        } else {
            AlertHelper.setAlert(title: "권한 요청을 허용해주세요.", message: "위치 서비스 권한을 허용해야 서비스 정상 이용이 가능합니다.", okMessage: "확인", over: self)
        }
    }
    
    // 2. 위치 관리 설정
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도
        mapView.delegate = self
    }
    
    // 3. 앱 내에서의 위치 서비스 권한을 요청
    func checkLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        // switch-case문을 통해 GPS 권한 설정 여부에 따라 로직을 나눈다.
        switch authorizationStatus {
        case .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            startTrackingUserLocation()
            
        case .notDetermined: // 아직 결정 x - 시스템 팝업 호출
            print("GPS 권한 설정되지 않음")
            locationManager.requestWhenInUseAuthorization()
            
        case .denied, .restricted: // 거부 - 설정 창으로 가서 권한을 변경하도록 유도
            print("GPS 권한 요청 거부됨")
            
            AlertHelper.okAndNoHandlerAlert(title: "위치 서비스 권한이 거부되었습니다.", message: "설정에서 위치 서비스 권한을 승인해주세요.", onConfirm: {
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }, onCancel: {
                self.defaultLocation()
                self.title = "서울 시청"
                self.addressLabel.text = "위치 서비스 권한을 허용해주세요."
            }, over: self)
            
        case .authorizedAlways:
            print("항상 허용")
        default:
            print("GPS: Default")
        }
    }
    
    // 4-1. 권한 허용 X, 기본 주소
    func defaultLocation() {
        let coordinate = CLLocationCoordinate2D(latitude: 37.5638155, longitude: 126.965426)
        let region = MKCoordinateRegion(center: coordinate,
                                        latitudinalMeters: regionInMeters,
                                        longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.title = "서울 시청"
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    // 4-2. 권한이 허용됐을 때, 사용자 위치 업데이트
    func startTrackingUserLocation() {
        mapView.showsUserLocation = true // 현위치
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation() // 지도를 움직일때마다 현위치를 업데이트한다.
        previousLocation = getPinCenterLocation(for: mapView)
    }
    
    // 사용자 위치 확대
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location,
                                            latitudinalMeters: regionInMeters,
                                            longitudinalMeters: regionInMeters)
            print(location.latitude, location.longitude)
            mapView.setRegion(region, animated: true)
        }
    }
    
    // 핀의 중심 위치
    func getPinCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    // MARK: - Annotations
    
    // 전체 위치 Annotations
    func allAnnotations() {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)

        for location in mapAnnotations.mapAnnotations {
            let theaterCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let theaterAnnotation = MKPointAnnotation()

            theaterAnnotation.title = location.location
            theaterAnnotation.coordinate = theaterCoordinate
            mapView.addAnnotation(theaterAnnotation)
        }
    }
    
    // 타입별 영화관 위치 Annotations
    func getTheaterAnnotations(_ theater: String) {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        for location in mapAnnotations.mapAnnotations {
            if location.type == theater {
                let theaterCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                let theaterAnnotation = MKPointAnnotation()

                theaterAnnotation.title = location.location
                theaterAnnotation.coordinate = theaterCoordinate
                mapView.addAnnotation(theaterAnnotation)
            }
        }
    }

}

// MARK: - CLLocationManagerDelegate

extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
        allAnnotations() // 전체 annotation 업데이트
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization(status)
    }
}

// MARK: - MKMapViewDelegate

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getPinCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        guard let previousLocation = self.previousLocation else { return }
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center, preferredLocale: locale) { placemark, error in
            guard error == nil, let place = placemark?.first else {
                print("주소 설정 불가능")
                return
            }
            
            // UI 업데이트마다 메인 스레드로 다시 이동
            DispatchQueue.main.async {
                let address = "\(place.administrativeArea ?? "") \(place.locality ?? "") \(place.subThoroughfare ?? "") \(place.thoroughfare ?? "")"
                self.addressLabel.text = address
            }
        }
    }
}
