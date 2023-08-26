//
//  CarRegistrationViewModel.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import Foundation
import Combine

class CarRegistrationViewModel: ObservableObject {
    
    func getCarInfo(registratedNum: String, ownerName: String) -> String {
        var carName: String = ""
        
        Requests.request("https://datahub-dev.scraping.co.kr",
                         .post,
                         params: ["REGINUMBER": "\(registratedNum)", "OWNERNAME": "\(ownerName)"], CarData.self) { data in
            carName = data.data.carname
        }
        
        
        
        return carName
    }
}
