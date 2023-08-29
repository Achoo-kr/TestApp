//
//  CarRegistrationViewModel.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import Foundation
import Combine

class CarRegistrationViewModel: ObservableObject {
    @Published var carName: String = ""
    @Published var isLoadingData: Bool = false
    @Published var isShowingAlert: Bool = false
    
    func getCarInfo(registratedNum: String, ownerName: String, completion: @escaping (String?) -> Void) {
        isLoadingData = true
        Requests.carRequest(
            "https://datahub-dev.scraping.co.kr/assist/common/carzen/CarAllInfoInquiry",
            .post,
            params: ["REGINUMBER": "\(registratedNum)", "OWNERNAME": "\(ownerName)"]) { [self] (result: Result<CarData, Error>) in
            switch result {
            case .success(let carData):
                print("성공 ! Car Name: \(carData.data.CARNAME)")
                completion(carData.data.CARNAME)
                carName = carData.data.CARNAME
                self.isLoadingData = false
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(nil)
                self.isLoadingData = false
                self.isShowingAlert = true
            }
        }
    }
}
