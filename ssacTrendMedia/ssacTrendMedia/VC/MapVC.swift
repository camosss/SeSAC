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
    
    var manager = CLLocationManager()
    var previousLocation: CLLocation? // 현재 위치 저장
    
    let mapAnnotations = MapAnnotations()
    let userDefaults = UserDefaults.standard
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(tapFilter))
    }
    
    // MARK: - Action
    
    @objc func tapFilter() {
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
        
        if #available(iOS 14, *) { authorizationStatus = manager.authorizationStatus }
        else { authorizationStatus = CLLocationManager.authorizationStatus() }
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization(authorizationStatus)
        } else {
            AlertHelper.setAlert(title: "오류", message: "위치 서비스 권한을 허용해야 서비스 정상 이용이 가능합니다. 권한 요청을 허용해주세요.", okMessage: "확인", over: self)
        }
    }
    
    // 2. 위치 업데이트
    func setupLocationManager() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization() // 사용자에게 승인 요구
        manager.desiredAccuracy = kCLLocationAccuracyBest // 정확도 (정밀한 정확도는 배터리를 많이 소모한다)
        manager.startUpdatingLocation()
    }
    
    // 3. 권한 설정
    func checkLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        // switch-case문을 통해 GPS 권한 설정 여부에 따라 로직을 나눈다.
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            startTrackingUserLocation() // 4 사용자 위치
            
        case .notDetermined: // 아직 결정 x - 시스템 팝업 호출
            print("GPS 권한 설정되지 않음")
            setupLocationManager()
            
        case .denied, .restricted: // 거부 - 설정 창으로 가서 권한을 변경하도록 유도
            print("GPS 권한 요청 거부됨")
            
            AlertHelper.okHandlerAlert(title: "위치 서비스 권한이 거부되었습니다.", message: "설정에서 위치 서비스 권한을 승인해주세요.", onConfirm: {
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }, over: self)
            
        default:
            print("GPS: Default")
        }
    }
    
    // 4-1. 권한 허용 X, 기본 주소
    func defaultLocation() {
        let coordinate = CLLocationCoordinate2D(latitude: 37.5638155, longitude: 126.965426)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.title = "서울 시청"
        annotation.coordinate = coordinate
        
        mapView.addAnnotation(annotation)
    }
    
    // 4-2. 권한이 허용됐을 때, 사용자 위치 업데이트
    func startTrackingUserLocation() {
        manager.startUpdatingLocation()
        centerViewOnUserLocation()
        previousLocation = getCenterLocation(for: mapView) // 위치 저장
    }
    
    // 5. 현재 위치 반경
    func centerViewOnUserLocation() {
        if let location = manager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.setRegion(region, animated: true)
        }
    }
    
    // 6 사용자 위치 (위도, 경도) 가져오기
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        getCurrentAddress(location: CLLocation(latitude: latitude, longitude: longitude))
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    // 7. 현재 위치 주소
    func getCurrentAddress(location: CLLocation) {
        let location: CLLocation = location
        let geoCoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr") // 한국어 주소 설정
        
        geoCoder.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
            guard error == nil, let placemark = placemarks?.first else {
                print("주소 설정 불가능")
                return
            }
            // UI 업데이트마다 메인 스레드로 다시 이동
            DispatchQueue.main.async {
                let address = "\(placemark.administrativeArea ?? "") \(placemark.locality ?? "") \(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? "")"
                self.title = address
            }
        }
    }
    
    // MARK: - Annotations
    
    func getTheaterAnnotations(_ theater: String) {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        currentAnnotations()
        
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
    
    // 현재 사용자 위치
    func currentAnnotations() {
        let coordinate = userDefaults.object(forKey: "coordinate") as! [Double]
        let latitude = coordinate[0]
        let longitude = coordinate[1]
        print(latitude, longitude)
        let nowCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let nowAnnotaion = MKPointAnnotation()
        nowAnnotaion.title = "현위치"
        nowAnnotaion.coordinate = nowCoordinate
        mapView.addAnnotation(nowAnnotaion)
    }
    
    // 전체 위치
    func allAnnotations() {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        currentAnnotations()
        
        for location in mapAnnotations.mapAnnotations {
            let theaterCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let theaterAnnotation = MKPointAnnotation()
            
            theaterAnnotation.title = location.location
            theaterAnnotation.coordinate = theaterCoordinate
            mapView.addAnnotation(theaterAnnotation)
        }
    }
    
}

// MARK: - CLLocationManagerDelegate

extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
            mapView.setRegion(region, animated: true)
            UserDefaults.standard.set([coordinate.latitude, coordinate.longitude], forKey: "coordinate")
            
            manager.startUpdatingLocation()
            allAnnotations()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationServices()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        AlertHelper.setAlert(title: "위치를 찾을 수 없습니다.", message: "위치 서비스 권한을 허용해주세요.", okMessage: "확인", over: self)
        defaultLocation()
    }
}
