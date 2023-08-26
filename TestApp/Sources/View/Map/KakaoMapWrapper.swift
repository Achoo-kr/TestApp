//
//  KakaoMapVCWrapper.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/19.
//

import Foundation
import SwiftUI
import UIKit

struct KakaoMapWrapper: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator.shared
    }
    
    func makeUIView(context: Context) -> some UIView {
        context.coordinator.getKakaoMapView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}

final class Coordinator: NSObject, ObservableObject, MTMapViewDelegate, CLLocationManagerDelegate {
    static let shared = Coordinator()
    
    var view = MTMapView(frame: .zero)
    var locationManager: CLLocationManager?
//    var mapView: MTMapView?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    @Published var coord: (Double, Double) = (0.0, 0.0)
    @Published var userLocation: (Double, Double) = (0.0, 0.0)
    
    override init() {
        super.init()
        
        view.baseMapType = .standard
        view.delegate = self
    }
    
    func getKakaoMapView() -> MTMapView {
        view
    }
    
    func checkIfLocationServicesIsEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async { [self] in
                    self.locationManager = CLLocationManager()
                    self.locationManager!.delegate = self
                    self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
                    self.checkLocationAuthorization()
                }
            } else {
                print("Show an alert letting them know this is off and to go turn i on.")
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse {
            view.currentLocationTrackingMode = .onWithoutHeading
            view.showCurrentLocationMarker = true
            
        }
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Go into settings to change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Success")
            coord = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
            print("LocationManager-coord: \(coord)")
            userLocation = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
            print("LocationManager-userLocation: \(userLocation)")
            locationManager.startUpdatingLocation()
            fetchCurrentUserLocation()
        @unknown default:
            break
        }
    }
    
    func fetchCurrentUserLocation() {
        let userMapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: userLocation.0, longitude: userLocation.1))
        let cameraUpdate = MTMapCameraUpdate.move(userMapPoint)
        view.setMapCenter(userMapPoint, animated: true)
        view.animate(with: cameraUpdate)
        print("fetchCurrentUserLocation() 실행!")
    }
    
    // MARK: - 지도 롱탭 시 이벤트 발생 메서드
    func mapView(_ mapView: MTMapView!, longPressOn mapPoint: MTMapPoint!) {
        print("롱탭 이벤트 발생!")
        fetchCurrentUserLocation()
        view.setMapCenter(mapPoint, animated: true)
        
        // 마커 생성
        let marker = MTMapPOIItem()
        marker.markerType = MTMapPOIItemMarkerType.redPin
        marker.mapPoint = mapPoint
        mapView.add(marker)
    }
    
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        //
    }
    // MARK: - 마커 생성 메서드
    func makeMarker(at mapPoint: MTMapPoint) {
        //
    }
    
    // MARK: - [POI Item] 단말 사용자가 POI Item 아이콘(마커) 위에 나타난 말풍선(Callout Balloon)을 터치한 경우 호출된다.
    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonOf poiItem: MTMapPOIItem!) {
        //
    }
    
    // kakaomap://route?sp=37.537229,127.005515&ep=37.4979502,127.0276368&by=CAR
    // https://roniruny.tistory.com/171
}
