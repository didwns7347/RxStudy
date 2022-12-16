//
//  ViewController.swift
//  CLLocationPractice
//
//  Created by yangjs on 2022/12/16.
//

import UIKit
import CoreLocation
class ViewController: UIViewController  , CLLocationManagerDelegate{
    var locationManager : CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testMain()
    }
    
    func testMain(){
        self.locationManager = CLLocationManager.init() // locationManager 초기화
        self.locationManager.delegate = self // 델리게이트 넣어줌
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest // 거리 정확도 설정
        self.locationManager.requestAlwaysAuthorization() // 위치 권한 설정 값을 받아옵니다
        
        self.locationManager.startUpdatingLocation() // 위치 업데이트 시작
    }
    
    
       // MARK: - [위치 서비스에 대한 권한 확인 실시]
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if status == .authorizedAlways {
               print("")
               print("===============================")
               print("[ViewController > locationManager() : 위치 사용 권한 항상 허용]")
               print("===============================")
               print("")
           }
           if status == .authorizedWhenInUse {
               print("")
               print("===============================")
               print("[ViewController > locationManager() : 위치 사용 권한 앱 사용 시 허용]")
               print("===============================")
               print("")
           }
           if status == .denied {
               print("")
               print("===============================")
               print("[ViewController > locationManager() : 위치 사용 권한 거부]")
               print("===============================")
               print("")
           }
           if status == .restricted || status == .notDetermined {
               print("")
               print("===============================")
               print("[ViewController > locationManager() : 위치 사용 권한 대기 상태]")
               print("===============================")
               print("")
           }
       }
       
    // MARK: - [위도, 경도 받아오기 에러가 발생한 경우]
      func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
          print("")
          print("===============================")
          print("[ViewController > didFailWithError() : 위치 정보 확인 에러]")
          print("[error : \(error)]")
          print("[localizedDescription : \(error.localizedDescription)]")
          print("===============================")
          print("")
      }

       
       
       
       
       // MARK: - [위치 정보 지속적 업데이트]
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           if let location = locations.first {
               // [위치 정보가 nil 이 아닌 경우]
               print("")
               print("===============================")
               print("[ViewController > didUpdateLocations() : 위치 정보 확인 실시]")
               print("[위도 : \(location.coordinate.latitude)]")
               print("[경도 : \(location.coordinate.longitude)]")
               print("===============================")
               print("")
           }
       }
       
    
}

