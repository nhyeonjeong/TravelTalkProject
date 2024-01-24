//
//  TheatherViewController.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    /// 원본 : 건드리지 말 것
    var originalAnnotations = TheaterList.mapAnnotations
    
    var annotationList = TheaterList.mapAnnotations
    
    var pinList: [MKPointAnnotation] = []
//    var annotation = MKPointAnnotation()

    /// 제일 처음에 디폴트로 뜨는 장소(서울대입구역)
    let defaultCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.4824761978647, longitude: 126.9521680487202)
    var coordinateMeters: CLLocationDistance = 15000
    
    /// 위치 허용하지 않았을 때 디폴트로 뜨는 장소 - 영등포 캠퍼스
    let ydpCoordinate = CLLocationCoordinate2D(latitude: 37.51740601118354, longitude: 126.88669183880141)
    
    // annotationType이 AlertAction에서 선택될 때마다 알아서 핀을 다시 꼽는다.ㅎㅎ
    var annotationType: LocationType = .전체보기 {
        didSet {
            mapView.removeAnnotations(pinList) // 맵뷰에서 핀들 삭제
            pinList = [] // 다시 초기화
            setMapCenter(center: defaultCoordinate, coordinateMeters: 15000)
            setAnnotation()
        }
    }
    
    let locationManager = CLLocationManager() // class, 중앙집권적 관리
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self // 프로토콜 사용
        
        configureView()
        setMapCenter(center: defaultCoordinate, coordinateMeters: coordinateMeters) // 중심잡기
        setAnnotation() // 핀 꼽기
        

    }
    func configureView() {

        // rightBarButtonItems(s들어감)으로 하면 취대 두 개 넣을 수 있다
        let button = UIBarButtonItem(title: "Filter", image: nil, target: self, action: #selector(presentAlert))
        navigationItem.rightBarButtonItem = button
        
        // 위치 버튼
        let myLocationButton = UIBarButtonItem(image: UIImage(systemName: "location.fill"), style: .plain, target: self, action: #selector(checkDeviceLocationAuthorization))
        navigationItem.leftBarButtonItem = myLocationButton
        
    }
    
    /// 지도와 핀 다시 그리는 로직 함수
    func setMapCenter(center: CLLocationCoordinate2D, coordinateMeters: CLLocationDistance) {
        
        // 서울대입구역 중심으로 핀이 다 나오도록
        let coordinate = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: coordinateMeters, longitudinalMeters: coordinateMeters)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    /// 핀꼽는 함수
    func setAnnotation() {
        if annotationType == .전체보기 {
            annotationList = originalAnnotations
        } else {
            annotationList = originalAnnotations.filter({$0.type == annotationType.rawValue})
            print(annotationList)
        }
        
        for item in annotationList {
            print("didi")
            let coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            
            // 핀 여러개 꽂고 싶으면 여기에 선언해줘야한다. -> 인스턴스마다 각자로 등록되어있어야 한다.그래서 재활용하면 안됨.
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = item.location
            
            pinList.append(annotation)
            mapView.addAnnotation(annotation)
        
        }
    }
    
}

// 위치 권한관련 메서드
extension TheaterViewController {
    /// iOS 시스템의 권한 확인
    @objc func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authorizationStatus: CLAuthorizationStatus // enum인데 어떻게 let으로 해도 밴경가능? & 초기화 안해도 되는 이유??
                
                if #available(iOS 14.0, *) {
                    authorizationStatus = self.locationManager.authorizationStatus
                } else {
                    authorizationStatus = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorizationStatus)
                }
            }
        }
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            locationManager.requestWhenInUseAuthorization() // info랑 맞추기

        case .denied: // 권한을 거부한 경우 영등포 캠퍼스가 맵뷰의 중심이 되도록
            print("denied")
            // 일단 영등포 캠퍼스(디폴트 장소) 띄우기
            setMapCenter(center: ydpCoordinate, coordinateMeters: 100)
            
            showLocationSettingAlert() // 여기서 거절하면 그냥 끝, 허용하면? 다시 상태체크
            
        case .authorizedAlways:
            print("authorizedAlways")
            locationManager.startUpdatingLocation() //didupdateLocation함수 실행

        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.startUpdatingLocation() //didupdateLocation함수 실행

        default: // 설정으로 허용하러 감 -> 허용해줌 - 들어오면 다시 상태체크해서 허용상태로 바로 가는건가?(한 번 허용해서 앱설정은 허용이 됐는데 다므에 들어갈떄 notdetermined라고 하면 알아서 설정앱에 권한switch도 풀리는건가?
            print("Error")
        }
    }
    
    // 권한 거부 했을 때 설정으로 유도하는 alert
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다.", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let settingURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingURL)
            } else {
                print("설정 클릭 실패!")
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}

extension TheaterViewController: CLLocationManagerDelegate {
    // 위치 허용 해준 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            // 사용자의 위치를 맵유의 중심으로
            setMapCenter(center: coordinate, coordinateMeters: 100)

        }
    }
    
    // 위치 허용을 하지 않은 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // 중심을 영등포 캠퍼스로
        setMapCenter(center: ydpCoordinate, coordinateMeters: 100)
    }
    
    // 권한이 변경되었을 때
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
}

extension TheaterViewController {
    @objc func presentAlert() {
        // 1. 알럿 컨텐츠title: 굵은 제목, message: 그 밑의 문구
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 2. 버튼 생성
        let button1 = UIAlertAction(title: "취소", style: .cancel)//cancel자리를 애플에서 지정 : 무조건 alert에서는 왼쪽/ actionsheet일떄는 아래 => HIG
        let button2 = UIAlertAction(title: LocationType.메가박스.rawValue, style: .default, handler: {_ in self.annotationType = .메가박스}) // destructive는 빨간색 글씨..
        let button3 = UIAlertAction(title: LocationType.롯데시네마.rawValue, style: .default, handler: {_ in self.annotationType = .롯데시네마})
        let button4 = UIAlertAction(title: LocationType.CGV.rawValue, style: .default, handler: {_ in self.annotationType = .CGV})
        let button5 = UIAlertAction(title: LocationType.전체보기.rawValue, style: .default, handler: {_ in self.annotationType = .전체보기})
        
        // 3. 컨텐츠붙은 공간 + 버튼이랑 붙이기. 까지를 코드로 구현
        alert.addAction(button1) // addAction순서로 수직으로 붙음. button1의 스탙일이 cancel이라 맨아래나 맨왼쪽으로 붙게되어있음
        alert.addAction(button3)
        alert.addAction(button2)
        alert.addAction(button4)
        alert.addAction(button5)
        
        // 4. 사용자에게 붙인거 띄워주기 : 띄우는 기능은 present, 보통 animated는 true로 해주는 편..
        present(alert, animated: true) // UIAlertController도 UIViewController을 상속하기 때문에 들어갈 수 있다.
    }
}
