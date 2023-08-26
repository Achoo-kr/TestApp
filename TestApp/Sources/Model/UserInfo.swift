//
//  UserInfo.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/26.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift   //GeoPoint 사용을 위한 프레임워크

struct UserInfo {
    var id: String
    var ownerName: String
    var carNumber: String
}
