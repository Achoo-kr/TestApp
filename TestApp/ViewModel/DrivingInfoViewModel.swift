//
//  DrivingInfoViewModel.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/30.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class DrivingInfoViewModel: ObservableObject {
    
    @AppStorage("carReg") var carReg: String = ""
    @Published var drivingInfos: [DrivingInfo] = []
    @Published var recentRef: String = ""
    
    /*
     let date: String
     let purpose: String
     let totalDistance: Int
     */
    
    func saveStartDrivingInfo(id: String, drivingInfo: DrivingInfo) async {
        let documents = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo")
        await documents.document(id)
            .setData(drivingInfo.dictionary) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Success")
                }
            }
    }
    
    func saveEndDrivingInfo(_ updatedField:[String:Any]) async {
        let documents = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo").document(recentRef)
        await documents.setData(updatedField, merge: true) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success")
            }
        }
    }
    
    //TODO: 운행날짜도 포함시켜서 filter 넣어줘야함 + 운행목적 + 총운행거리
    func fetchDrivingInfos() async {
        let documentRef = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo")
        
        documentRef.addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let documents = snapshot?.documents else {
                print("스냅샷 Nil")
                return
            }
            self.drivingInfos = []
            documents.forEach { content in
                do {
                    var drivingInfo = try Firestore.Decoder().decode(DrivingInfo.self, from: content.data())
                    self.drivingInfos.append(drivingInfo)
                } catch {
                    print("저장 실패")
                }
            }
        }
    }
}
