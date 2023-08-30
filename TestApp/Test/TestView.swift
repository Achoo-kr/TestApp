//
//  TestView.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/28.
//  da02a05d46189ed10a815fbe783d51a3

//import SwiftUI
//
//struct Place: Identifiable {
//    let id: String
//    let name: String
//    let address: String
//}
//
//struct TestView: View {
//    @State private var keyword: String = ""
//    @State private var places: [Place] = []
//    
//    var body: some View {
//        VStack {
//            TextField("검색어를 입력하세요", text: $keyword)
//                .padding()
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal)
//            
//            Button("검색") {
//                searchPlaces()
//            }
//            .padding()
//            
//            List(places) { place in
//                VStack(alignment: .leading) {
//                    Text(place.name)
//                        .font(.headline)
//                    Text(place.address)
//                        .font(.subheadline)
//                }
//            }
//            .listStyle(PlainListStyle())
//        }
//    }
//    
//    func searchPlaces() {
//        guard !keyword.isEmpty else { return }
//        
//        let kakaoApiKey = "da02a05d46189ed10a815fbe783d51a3"
//        let apiUrl = "https://dapi.kakao.com/v2/local/search/keyword.json"
//        
//        var urlComponents = URLComponents(string: apiUrl)!
//        urlComponents.queryItems = [
//            URLQueryItem(name: "query", value: keyword)
//        ]
//        
//        guard let url = urlComponents.url else {
//            print("URL 생성 실패")
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.addValue("KakaoAK \(kakaoApiKey)", forHTTPHeaderField: "Authorization")
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("네트워크 오류: \(error.localizedDescription)")
//                return
//            }
//            
//            if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    let searchResponse = try decoder.decode(SearchResponse.self, from: data)
//                    
//                    DispatchQueue.main.async {
//                        places = searchResponse.documents.map {
//                            Place(id: $0.id, name: $0.placeName, address: $0.addressName)
//                        }
//                    }
//                } catch {
//                    print("파싱 오류: \(error.localizedDescription)")
//                }
//            }
//            
//            // 디버그 정보 출력
//            if let httpResponse = response as? HTTPURLResponse {
//                print("HTTP 응답 코드: \(httpResponse.statusCode)")
//            }
//            
//            if let dataString = String(data: data!, encoding: .utf8) {
//                print("API 응답 데이터: \(dataString)")
//            }
//        }.resume()
//    }
//}
//
//struct SearchResponse: Codable {
//    let documents: [PlaceData]
//}
//
//struct PlaceData: Codable {
//    let addressName, categoryGroupCode, categoryGroupName, categoryName: String
//    let distance, id, phone, placeName: String
//    let placeURL: String
//    let roadAddressName, x, y: String
//
//    enum CodingKeys: String, CodingKey {
//        case addressName = "address_name"
//        case categoryGroupCode = "category_group_code"
//        case categoryGroupName = "category_group_name"
//        case categoryName = "category_name"
//        case distance, id, phone
//        case placeName = "place_name"
//        case placeURL = "place_url"
//        case roadAddressName = "road_address_name"
//        case x, y
//    }
//}
