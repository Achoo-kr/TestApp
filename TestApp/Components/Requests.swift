//
//  Requests.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import Alamofire
import Foundation

class Requests {
    static func simple(_ url: String,
                       _ method: HTTPMethod,
                       params: [String: Any]? = nil,
                       completion: @escaping () -> Void) {
        AF.request(url,
                   method: method,
                   parameters: params,
                   encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                   interceptor: Interceptor()
        )
        .validate()
        .responseData { response in
            switch response.result {
            case .success:
                completion()
            case .failure:
                print("error")
            }
        }
    }
    
    static func request<T: Codable>(_ url: String,
                                    _ method: HTTPMethod,
                                    params: [String: Any]? = nil,
                                    _ model: T.Type,
                                    completion: @escaping (T) -> Void) {
        AF.request(url,
                   method: method,
                   parameters: params,
                   encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                   headers: ["Authorization": "KakaoAK"],
                   interceptor: Interceptor()
        )
        .validate()
        .responseData { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    if let decodedData = try? decoder.decode(T.self, from: data) {
                        DispatchQueue.main.async {
                            completion(decodedData)
                        }
                    }
                }
            case .failure:
                print("error")
            }
        }
    }
    
    static func carRequest<T: Codable>(_ url: String,
                                       _ method: HTTPMethod,
                                       params: [String: Any]? = nil,
                                       completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(url, method: method,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: ["Authorization":"fb6628d276b645ef9cc662e997e0e2a54b520765", "Content-Type":"application/json;charset=UTF-8"])
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let err):
                    completion(.failure(err))
                }
            }
    }
}
