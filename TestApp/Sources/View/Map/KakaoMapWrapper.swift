//
//  KakaoMapVCWrapper.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/19.
//

import Foundation
import SwiftUI
import UIKit
import KakaoMapsSDK
import KakaoMapsSDK_SPM

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

final class Coordinator: NSObject, ObservableObject, MTMapViewDelegate, MTMapReverseGeoCoderDelegate, CLLocationManagerDelegate {
    static let shared = Coordinator()
    
    let view = MTMapView(frame: .zero)
    var locationManager: CLLocationManager?
    var geoCoder: MTMapReverseGeoCoder!
    var currentGeoCoder: MTMapReverseGeoCoder!
    
    @Published var destination: (Double, Double) = (0.0, 0.0)
    @Published var userLocation: (Double, Double) = (0.0, 0.0)
    @Published var address: String = ""
    @Published var currentAddress: [String] = ["서울 중구 태평로1가 31"]
    @Published var isLocationDataLoaded: Bool = false

    override init() {
        super.init()
        view.showCurrentLocationMarker = true
        //view.currentLocationTrackingMode = .onWithoutHeading
        view.baseMapType = .standard
        view.delegate = self
    }
    
    func getKakaoMapView() -> MTMapView {
        view
    }
    
    deinit {
        print("Coordinator deinit!")
    }
    
    func checkIfLocationServicesIsEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async { [self] in
                    self.locationManager = CLLocationManager()
                    self.locationManager!.delegate = self
                    self.checkLocationAuthorization()
                }
            } else {
                print("Show an alert letting them know this is off and to go turn i on.")
            }
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
            print("You have denied this app location permission. Go into setting to change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Success")
            userLocation = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
            print("LocationManager-userLocation: \(userLocation)")
            fetchCurrentUserLocation()
//            isLocationDataLoaded = true
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
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
        mapView.setMapCenter(mapPoint, animated: true)
        // 마커 생성
        let marker = MTMapPOIItem()
        marker.markerType = MTMapPOIItemMarkerType.redPin
        marker.mapPoint = mapPoint
        mapView.add(marker)
        view.add(marker)
    }
    
    // MARK: - 현 위치 트래킹 함수
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        let currentLocation = location?.mapPointGeo()
        if let latitude = currentLocation?.latitude, let longitude = currentLocation?.longitude {
            print("MTMapView updateCurrentLocation (\(latitude),\(longitude)) accuracy (\(accuracy))")
        }
    }
    
    // MARK: - 위도, 경도 좌표 -> 주소 변환
    func mapView(_ mapView: MTMapView!, finishedMapMoveAnimation mapCenterPoint: MTMapPoint!) {
        let geoCoder = MTMapReverseGeoCoder(
            mapPoint: MTMapPoint(geoCoord: MTMapPointGeo(
                latitude: mapCenterPoint.mapPointGeo().latitude,
                longitude: mapCenterPoint.mapPointGeo().longitude)),
            with: self,
            withOpenAPIKey: "923b28d9b3a43a58017321fb76583ace")
        // 목적지 위도 경도 저장
        destination = (mapCenterPoint.mapPointGeo().latitude,
                       mapCenterPoint.mapPointGeo().longitude)
        print(CGFloat(destination.0),CGFloat(destination.1))
        self.geoCoder = geoCoder
        
        geoCoder?.startFindingAddress()
    }
    
    // MARK: - 좌표를 통해 얻은 주소 문자열값을 얻기 위한 함수
    func mtMapReverseGeoCoder(_ rGeoCoder: MTMapReverseGeoCoder!, foundAddress addressString: String!) {
        guard let addressString = addressString else { return }
        address = addressString
        // FIXME: - 임시적인 로직(리팩토링 필요)
        guard currentAddress.count == 3 else {
            currentAddress.insert(address, at: 1)
            // 위치정보 데이터 로드 시(리팩토링)
            isLocationDataLoaded = true
            return
        }
    }
    
    // MARK: - 주소 문자열 생성 실패 시 에러 핸들링
    func mtMapReverseGeoCoder(_ rGeoCoder: MTMapReverseGeoCoder!, failedToFindAddressWithError error: Error!) {
        print(error.localizedDescription)
    }
    
    func mapView(_ mapView: MTMapView!, centerPointMovedTo mapCenterPoint: MTMapPoint!) {
        mtMapReverseGeoCoder(geoCoder, foundAddress: address)
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
