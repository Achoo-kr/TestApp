//
//  CarInfo.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import Foundation

// MARK: - CarData
struct CarData: Codable {
    let errCode: String
    let errMsg: String
    let result: String
    let data: CarDetails
}

// MARK: - CarDetails
struct CarDetails: Codable {
    let STATUS: String
    let RESPONSE: String
    let CARVENDER: String
    let CARNAME: String
    let SUBMODEL: String
    let UID: String
    let CARYEAR: String
    let DRIVE: String
    let FUEL: String
    let PRICE: String
    let CC: String
    let MISSION: String
    let CARURL: String
    let VIN: String
    let RESULT: String
    let ERRMSG: String
    let FRONTTIRE: String
    let REARTIRE: String
    let EOILLITER: String
    let WIPER: String
    let SEATS: String
    let BATTERYLIST: [Batterylist]
    let FUELECO: String
    let FUELTANK: String
}

// MARK: - Batterylist
struct Batterylist: Codable {
    let BRAND: String
    let MODEL: String
    let TYPE: String
}
