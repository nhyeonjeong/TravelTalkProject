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

    var annotationType: LocationType = .전체보기 {
        didSet {
            mapView.removeAnnotations(pinList)
            pinList = [] // 다시 초기화
            setAnnotation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setAnnotation()
        

    }
    func configureView() {

        let button = UIBarButtonItem(title: "Filter", image: nil, target: self, action: #selector(presentAlert))
        navigationItem.rightBarButtonItem = button
        
    }
    
    /// 지도와 핀 다시 그리는 로직 함수
    func setAnnotation() {
        
        // 서울대입구역 중심으로 핀이 다 나오도록
        let coordinate = CLLocationCoordinate2D(latitude: 37.4824761978647, longitude: 126.9521680487202)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 15000, longitudinalMeters: 15000)
        
        mapView.setRegion(region, animated: true)
        
        print(annotationType.rawValue)
        if annotationType == .전체보기 {
            annotationList = originalAnnotations
        } else {
            annotationList = originalAnnotations.filter({$0.type == annotationType.rawValue})
            print(annotationList)
        }
        
        for item in annotationList {
            print("didi")
            let coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            
            // 핀 여러개 꽂고 싶으면 여기에 선언해줘야한다. -> ?왜지...ㅎ
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = item.location
            
            pinList.append(annotation)
            mapView.addAnnotation(annotation)
        
        }
  
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
