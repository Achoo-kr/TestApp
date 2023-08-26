//
//  MainViewModel.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import Foundation
import Combine
import CoreLocation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class MainViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var active: Bool = false
    @Published var endX: CGFloat = 0
    @Published var endY: CGFloat = 0
    
    @Published var userInfo: [UserInfo] = []
    @Published var drivingInfo: [DrivingInfo] = []
    
    // MARK: - User 생성
    func createUser(user: UserInfo) {
        Firestore.firestore().collection("Users")
            .document(user.id)
            .setData([
                "id": user.id,
                "ownerName": user.ownerName,
                "carNumber": user.carNumber
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
    }
    
    // MARK: - User Data 불러오기
    func getUserData() async {
        do {
            let documents = try await Firestore.firestore().collection("Users").getDocuments()
            for document in documents.documents {
                let docData = document.data()
                // 있는지를 따져서 있으면 데이터 넣어주고, 없으면 옵셔널 처리
                
                let id : String = document.documentID
                let ownerName: String = docData["ownerName"] as? String ?? ""
                let carNumber : String = docData["carNumber"] as? String ?? ""
                //                let start : GeoPoint = docData["start"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
                //                let end : GeoPoint = docData["end"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
                //                let route : String = docData["route"] as? String ?? ""
                
                // 날짜 데이터 포맷
                //                let timeStampData : Timestamp = document["date"] as? Timestamp ?? Timestamp()
                //                let date : Date = timeStampData.dateValue()
                
                let userData: UserInfo = UserInfo(id: id, ownerName: ownerName, carNumber: carNumber)
                
                self.userInfo.append(userData)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - User Data 추가
    func addUserData() {
        
    }
    //    @Published var currentLocation: CLLocation?
    //
    //    private var locationService = LocationManager()
    //
    //    init() {
    //        locationService.locationUpdateHandler = { [weak self] location in
    //            self?.currentLocation = location
    //        }
    //    }
    
    
    
    
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
}
