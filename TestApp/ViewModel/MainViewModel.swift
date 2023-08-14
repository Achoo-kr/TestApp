//
//  MainViewModel.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import Combine
import CoreLocation

class MainViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var active: Bool = false
    @Published var endX: CGFloat = 0
    @Published var endY: CGFloat = 0
    @Published var currentLocation: CLLocation?
    
    private var locationService = LocationManager()
    
    init() {
        locationService.locationUpdateHandler = { [weak self] location in
            self?.currentLocation = location
        }
    }

}


//func getInfo(_ startX: CGFloat, _ startY: CGFloat, _ endX: CGFloat, _ endY: CGFloat) -> [Int] {
//    var routeInfo = [Int]()
//    Requests.request("https://apis-navi.kakaomobility.com/v1/directions",
//                     .get,
//                     params: ["origin": "\(startX),\(startY)", "destination": "\(endX),\(endY)"],
//                     DrivingInfo.self) { data in
//        routeInfo = [data.route.summary.distance, data.route.summary.duration]
//    }
//    
//    return routeInfo
//}
