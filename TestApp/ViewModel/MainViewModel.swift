//
//  MainViewModel.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//
import SwiftUI
import Foundation
import Combine
import CoreLocation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class MainViewModel: ObservableObject {
    
    @AppStorage("carReg") var carReg: String = ""
    
    @Published var searchText: String = ""
    @Published var active: Bool = false
    
    @Published var startX: Double = 0
    @Published var startY: Double = 0
    @Published var startAddress: String = ""
    @Published var endX: Double = 0
    @Published var endY: Double = 0
    
    @Published var showAlert: Bool = false
    @Published var userInfo: [UserInfo] = []
    
    init() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("GuideEnded"), object: nil, queue: .main) { [weak self] (_) in
            self?.active = false
            self?.showAlert = true
        }
    }
    
    // MARK: - User 생성
    func createUser(user: UserInfo) {
        Firestore.firestore().collection("Users")
            .document(user.carNumber)
            .setData([
                "id": user.carNumber,
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
}
