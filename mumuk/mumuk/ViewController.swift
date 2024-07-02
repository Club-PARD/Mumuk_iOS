//ViewController.swift

import CoreLocation
import NMapsMap

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    let boxView : UIView = {
        let box = UIView()
        
        box.layer.cornerRadius = 20
        box.backgroundColor = .clear
        box.translatesAutoresizingMaskIntoConstraints = false
        return box
    }()
    
    
    
    let menuButton : UIButton = {
        var config = UIButton.Configuration.filled()
        
        config.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
        
        
        if let image = UIImage(systemName: "text.justify" ){
            let size = CGSize(width: 18, height: 18)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            config.image = scaledImage
        }
        
        let button = UIButton(configuration: config)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true // bound 밖으로 나가지 않게 조절
        button.layer.cornerRadius = 14
        return button
        
    }()
    
    
    
    
    let backButton  : UIButton = {
        var config = UIButton.Configuration.filled()
        
        config.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
        
        
        if let image = UIImage(systemName: "arrow.backward" ){
            let size = CGSize(width: 18, height: 18)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            config.image = scaledImage
        }
        
        let button = UIButton(configuration: config)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true // bound 밖으로 나가지 않게 조절
        button.layer.cornerRadius = 14
        return button
        
    }()
    
    
    //눌렀을때 현위치로 돌아가는 버튼
    let currentLocationButton  : UIButton = {
        var config = UIButton.Configuration.filled()
        
        config.background.backgroundColor = #colorLiteral(red: 0.9469566941, green: 0.6374832988, blue: 0.2344205678, alpha: 1)
        
        
        if let image = UIImage(systemName: "location.circle" ){
            let size = CGSize(width: 18, height: 18)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0) // 그래픽 컨텍스트 생성
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // 그래픽 컨텍스트에서 UIImage 객체 생성
            UIGraphicsEndImageContext() // 그래픽 컨텍스트 종료
            config.image = scaledImage
        }
        
        let button = UIButton(configuration: config)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true // bound 밖으로 나가지 않게 조절
        button.layer.cornerRadius = 14
        return button
        
    }()
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = NMFMapView(frame: view.frame)
        mapModal()
        view.addSubview(mapView)
        view.addSubview(boxView)
        view.addSubview(menuButton)
        view.addSubview(backButton)
        view.addSubview(currentLocationButton)
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
        
        
        
        
        //MARK: - 오토레이아웃 잡기
                NSLayoutConstraint.activate([
                    menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                    menuButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                    
                    boxView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                    boxView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                    boxView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                    boxView.heightAnchor.constraint(equalToConstant: 300),
                    
                    
                    backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                    backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -320),
                    
                
                    currentLocationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                    currentLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -320),
                    

                
                ])
            }
    // MARK: -modal 창 사이즈 설정
        @objc func mapModal() {
            let MapModalViewController = MapModalViewController()
            MapModalViewController.modalPresentationStyle = .formSheet


            // detent 설정
            if let sheet = MapModalViewController.sheetPresentationController {
                // detents 배열을 설정하여 원하는 위치에 맞게 모달 창의 위치를 조정할 수 있습니다.
                sheet.detents = [
                    .custom { _ in
                        return 300  //이 숫자로 원하는 만큼 조절가능

                    },
                    .large()
                ]
                
                sheet.preferredCornerRadius = 40 // 모달 창의 모서리 둥글기 설정
                sheet.prefersScrollingExpandsWhenScrolledToEdge = true // full일 때 스크롤 시 창 크기 조정
            
                //모달창 떠 있어서도 ViewController의 mapView 움직이게 하기
                //        MapModalViewController.modalPresentationStyle = .overCurrentContext
                // 모달을 present
                present(MapModalViewController, animated: true)
            }
        }
    }
