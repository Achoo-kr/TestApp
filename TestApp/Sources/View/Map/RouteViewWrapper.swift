//
//  RouteView.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/31.
//

import Foundation
import KakaoMapsSDK
import SwiftUI
import CoreLocation

struct KakaoMapView: UIViewRepresentable {
    @Binding var draw: Bool
    
    /// UIView를 상속한 KMViewContainer를 생성한다.
    /// 뷰 생성과 함께 KMControllerDelegate를 구현한 Coordinator를 생성하고, 엔진을 생성 및 초기화한다.
    func makeUIView(context: Self.Context) -> KMViewContainer {
        let view: KMViewContainer = KMViewContainer()
        view.sizeToFit()
        context.coordinator.createController(view)
        context.coordinator.controller?.initEngine()
        
        return view
    }
    
    
    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    /// draw가 true로 설정되면 엔진을 시작하고 렌더링을 시작한다.
    /// draw가 false로 설정되면 렌더링을 멈추고 엔진을 stop한다.
    func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
        if draw {
            context.coordinator.controller?.startEngine()
            context.coordinator.controller?.startRendering()
        }
        else {
            context.coordinator.controller?.stopRendering()
            context.coordinator.controller?.stopEngine()
        }
    }
    
    /// Coordinator 생성
    func makeCoordinator() -> KakaoMapCoordinator {
        return KakaoMapCoordinator()
    }
    
    /// Cleans up the presented `UIView` (and coordinator) in
    /// anticipation of their removal.
    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        
    }
    
    /// Coordinator 구현. KMControllerDelegate를 adopt한다.
}

final class KakaoMapCoordinator: NSObject, MapControllerDelegate, CLLocationManagerDelegate {
    static let shared = KakaoMapCoordinator()
    
    var controller: KMController?
    var first: Bool
    var locationManager: CLLocationManager?
    @Published var destination: (Double, Double) = (0.0, 0.0)
    @Published var userLocation: (Double, Double) = (0.0, 0.0)
    override init() {
        first = true
        super.init()
    }
    
    // KMController 객체 생성 및 event delegate 지정
    func createController(_ view: KMViewContainer) {
        controller = KMController(viewContainer: view)
        controller?.delegate = self
    }
    
    // KMControllerDelegate Protocol method구현
    
    /// 엔진 생성 및 초기화 이후, 렌더링 준비가 완료되면 아래 addViews를 호출한다.
    /// 원하는 뷰를 생성한다.
    func addViews() {
        let defaultPosition: MapPoint = MapPoint(longitude: 14135167.020272, latitude: 4518393.389136)
        let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
        
        if controller?.addView(mapviewInfo) == Result.OK {
            let _ = controller?.getView("mapview") as! KakaoMap
        }
    }
    
    /// KMViewContainer 리사이징 될 때 호출.
    func containerDidResized(_ size: CGSize) {
        let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
        mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
        if first {
            let cameraUpdate: CameraUpdate = CameraUpdate.make(target: MapPoint(longitude: 14135167.020272, latitude: 4518393.389136), zoomLevel: 10, mapView: mapView!)
            mapView?.moveCamera(cameraUpdate)
            first = false
        }
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
    
    func moveCamera() {
        let mapView: KakaoMap = controller?.getView("mapview") as! KakaoMap
        
        // CameraUpdateType을 CameraPosition으로 생성하여 지도의 카메라를 특정 좌표로 이동시킨다. MapPoint, 카메라가 바라보는 높이, 회전각 및 틸트를 지정할 수 있다.
        mapView.moveCamera(CameraUpdate.make(cameraPosition: CameraPosition(target: MapPoint(longitude: 127.036933, latitude: 37.500816), height: 0, rotation: 0, tilt: 0)))
    }
    
    
    func fetchCurrentUserLocation() {
        let userMapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: userLocation.0, longitude: userLocation.1))
        let cameraUpdate = MTMapCameraUpdate.move(userMapPoint)
        
//        view.setMapCenter(userMapPoint, animated: true)
//        view.animate(with: cameraUpdate)
        print("fetchCurrentUserLocation() 실행!")
    }

    func testRouteCreate(startCoordinate: (Double,Double), endCoordinate: (Double,Double)) {
        let mapView = controller?.getView("mapview") as! KakaoMap
        let manager = mapView.getRouteManager()
        
        // RouteLayer 생성
        let layer = manager.addRouteLayer(layerID: "RouteLayer", zOrder: 0)
        
        // RouteSegment 생성
        let segment = RouteSegment(points: [MapPoint(longitude: startCoordinate.1, latitude: startCoordinate.0), MapPoint(longitude: endCoordinate.1, latitude: endCoordinate.0)], styleIndex: 0)
        // RouteLayer에 RouteSegment 추가
        if let layer = layer {
            let routeOptions = RouteOptions(routeID: "routes", styleID: "routeStyleSet1", zOrder: 0)
            layer.addRoute(option: routeOptions) { route in
                if let route = route {
                    // 경로 생성에 성공했을 때, 생성된 경로를 표시합니다.
                    route.show()
                }
            }
        }
    }
    
    // RouteStyleSet을 생성한다.
    func createRouteStyleSet() {
        let mapView = controller?.getView("mapview") as? KakaoMap
        let manager = mapView?.getRouteManager()
        let _ = manager?.addRouteLayer(layerID: "RouteLayer", zOrder: 0)
        let patternImages = [UIImage(named: "route_pattern_arrow.png"), UIImage(named: "route_pattern_walk.png"), UIImage(named: "route_pattern_long_dot.png")]
        
        // StyleSet에 pattern을 추가한다.
        let styleSet = RouteStyleSet(styleID: "routeStyleSet1")
        styleSet.addPattern(RoutePattern(pattern: patternImages[0]!, distance: 60, symbol: nil, pinStart: false, pinEnd: false))
        styleSet.addPattern(RoutePattern(pattern: patternImages[1]!, distance: 6, symbol: nil, pinStart: true, pinEnd: true))
        styleSet.addPattern(RoutePattern(pattern: patternImages[2]!, distance: 6, symbol: UIImage(named: "route_pattern_long_airplane.png")!, pinStart: true, pinEnd: true))
        
        let colors = [ UIColor(red: 119, green: 150, blue: 255, alpha: 1),
                       UIColor(red: 52, green: 52, blue: 52, alpha: 1),
                       UIColor(red: 51, green: 150, blue: 255, alpha: 0),
                       UIColor(red: 238, green: 99, blue: 174, alpha: 0) ]
        
        let strokeColors = [ UIColor(red: 255, green: 255, blue: 255, alpha: 1),
                             UIColor(red: 255, green: 255, blue: 255, alpha: 1),
                             UIColor(red: 255, green: 255, blue: 255, alpha: 0),
                             UIColor(red: 255, green: 255, blue: 255, alpha: 0) ]
        
        let level1Style = PerLevelRouteStyle(width: 10, color: .red, level: 1)
        let level2Style = PerLevelRouteStyle(width: 8, color: .blue, level: 2)
        let level3Style = PerLevelRouteStyle(width: 6, color: .green, level: 3)
        
        let patternIndex = [-1, 0, 1, 2]
        let perLevelRouteStyles: [PerLevelRouteStyle] = [level1Style, level2Style, level3Style]
        // 총 4개의 스타일을 생성한다.
        for index in 0 ..< colors.count {
            let routeStyle = RouteStyle(styles: perLevelRouteStyles)
            // 각 스타일은 1개의 표출 시작 레벨 = 0 인 PerLevelStyle을 갖는다. 즉, 전 레벨에서 동일하게 표출된다.
            // Style의 패턴인덱스가 -1로 지정되는 경우, 패턴을 사용하지 않고 컬러만 사용한다.
            //                routeStyle.addPerLevelStyle(PerLevelRouteStyle(width: 18, color: colors[index], strokeWidth: 4, strokeColor: strokeColors[index], level: 0, patternIndex: patternIndex[index]))
            //
            styleSet.addStyle(routeStyle)
        }
        manager?.addRouteStyleSet(styleSet)
    }
    
    func createRouteline() {
        let mapView = controller?.getView("mapview") as! KakaoMap
        let manager = mapView.getRouteManager()
        
        // Route 생성을 위해 RouteLayer를 생성한다.
        let layer = manager.addRouteLayer(layerID: "RouteLayer", zOrder: 0)
        
        // Route 생성을 위한 RouteSegment 생성
        //            let segmentPoints: RouteSegment
        //            var segments: [RouteSegment] = [RouteSegment]()
        //            var styleIndex: UInt = 0
        //            for points in segmentPoints {
        //                // 경로 포인트로 RouteSegment 생성. 사용할 스타일 인덱스도 지정한다.
        //                let seg = RouteSegment(points: points, styleIndex: styleIndex)
        //                segments.append(seg)
        //                styleIndex = (styleIndex + 1) % 4
        //            }
        
        // Route 생성을 위해 ID, styleID, zOrder, segment를 전달한다.
        //            let route = layer?.addRoute(option: <#RouteOptions#>, routeID: "routes", styleID: "routeStyleSet1", zOrder: 0, segments: segments)
        let route = layer?.addRoute(option: RouteOptions(routeID: "routes", styleID: "routeStyleSet1", zOrder: 0))
        route?.show()
    }
}

