//
//  CarInfo.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import Foundation

// MARK: - Bookmark
struct CarData: Codable {
    let errCode, errMsg, result: String
    let data: CarDetails
}

// MARK: - DataClass
struct CarDetails: Codable {
    let status, response, carvender, carname: String
    let submodel, uid, caryear, drive: String
    let fuel, price, cc, mission: String
    let carurl, vin, result, errmsg: String
    let fronttire, reartire, eoilliter, wiper: String
    let seats: String
    let batterylist: [Batterylist]
    let fueleco, fueltank: String
}

// MARK: - Batterylist
struct Batterylist: Codable {
    let brand, model, type: String
}
