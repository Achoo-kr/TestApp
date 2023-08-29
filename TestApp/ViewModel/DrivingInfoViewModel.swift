//
//  DrivingInfoViewModel.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/30.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class DrivingInfoViewModel: ObservableObject {
    
    @Published var drivingInfo: [DrivingInfo] = []
    @Published var documentPath: DocumentReference?
    
    init() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("GuideEnded"), object: nil, queue: .main) { [weak self] (_) in
            Task {
                await self?.saveEndDrivingInfo(["endAddress":Coordinator.shared.currentAddress[1]])
            }
        }
    }
    
    func saveStartDrivingInfo(userId: String, drivingInfo: DrivingInfo) async {
        let documents = Firestore.firestore().collection("Users").document(userId).collection("DrivingInfo")
        await documents.addDocument(data: drivingInfo.dictionary) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success")
                self.documentPath = documents.document(drivingInfo.id)
            }
        }
    }
    
    func saveEndDrivingInfo(_ updatedField:[String:Any]) async {
        do {
            try? await self.documentPath?.updateData(updatedField)
        } catch {
            print(error.localizedDescription)
        }
    }
}
