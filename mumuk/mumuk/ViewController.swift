//ViewController.swift

import CoreLocation
import NMapsMap
import SwiftSoup

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            print(locationManager.location?.coordinate)
            
            //현 위치로 카메라 이동
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            cameraUpdate.animation = .easeIn
            mapView.moveCamera(cameraUpdate)
            
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            marker.mapView = mapView
        } else {
            print("위치 서비스 Off 상태")
        }
        crawl()
    }
}

func crawl(){
    let url = URL(string: "https://map.naver.com/p/search/%EC%9D%8C%EC%8B%9D%EC%A0%90?c=15.00,0,0,0,dh")
  
    guard let myURL = url else {   return    }
    
    do {
        let html = try String(contentsOf: myURL, encoding: .utf8)
        let doc: Document = try SwiftSoup.parse(html)
        let headerTitle = try doc.title()
        print(headerTitle)
        
        let places: Elements = try doc.select(".place_bluelink.TYaxT").select("span") // 정확한 CSS 선택자 사용
        for place in places {
            let placeName = try place.text()
            print("Title: \(placeName)")
        }
        
        
    } catch Exception.Error(let type, let message) {
        print("Message: \(message)")
    } catch {
        print("error")
    }
    
}
