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
    @Published var drivingInfo: [DrivingInfo] = []
    @Published var recentRef: String = ""
    
    
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
        await documents.updateData(updatedField) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success")
            }
        }
    }
}
