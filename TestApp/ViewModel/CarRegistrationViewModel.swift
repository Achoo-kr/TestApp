//
//  CarRegistrationViewModel.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import Foundation
import Combine

class CarRegistrationViewModel: ObservableObject {
    
    func getCarInfo(registratedNum: String, ownerName: String, completion: @escaping (String?) -> Void) {
        Requests.carRequest(
            "https://datahub-dev.scraping.co.kr/assist/common/carzen/CarAllInfoInquiry",
            .post,
            params: ["REGINUMBER": "\(registratedNum)", "OWNERNAME": "\(ownerName)"]) { (result: Result<CarData, Error>) in
            switch result {
            case .success(let carData):
                print("성공 ! Car Name: \(carData.data.CARNAME)")
                completion(carData.data.CARNAME)
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
