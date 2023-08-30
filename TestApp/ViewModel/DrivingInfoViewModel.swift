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
    @Published var showAlert: Bool = false
    
    init() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("GuideEnded"), object: nil, queue: .main) { [weak self] (_) in
            self?.showAlert = true
        }
    }
    
    func saveStartDrivingInfo(drivingInfo: DrivingInfo) async {
        let documents = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo")
        await documents.addDocument(data: drivingInfo.dictionary) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success")
//                self.documentPath = documents.document(drivingInfo.id)
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
//                self.documentPath = documents.document(drivingInfo.id)
            }
        }
    }
}
