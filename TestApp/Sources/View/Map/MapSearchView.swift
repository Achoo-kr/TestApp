//
//  MapSearchView.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/31.
//

import SwiftUI
import Combine

struct Place: Identifiable {
    let id: String
    let name: String
    let address: String
    let x, y: String
}

struct MapSearchView: View {
    
    @State private var keyword: String = ""
    @State private var places: [Place] = []
    @Binding var tapSearchBar: Bool
    
    // Combine - Debouncing
    @State var keywordPublisher = PassthroughSubject<String, Never>()
    @State var debounceCancellable: AnyCancellable?
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color(.white)
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center) {
                    
                    Button {
                        tapSearchBar = false
                    } label: {
                        Image("backButton")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .aspectRatio(contentMode: .fit)
                            .offset(y: 5)
                    }
                    
                    TextField("목적지를 입력하세요", text: $keyword)
                        .padding()
                        .focused($isFocused)
                        .padding(.leading)
                        .disableAutocorrection(true)
                        .frame(width: 250, height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.lightGray, lineWidth: 1.5)
                        )
                        .onChange(of: keyword) { newValue in
                            keywordPublisher.send(newValue)
                        }
                        
                    Spacer()
                        
                }
                .padding()
                .background(Color.white)
                
                List(places) { place in
                    Button {
                        tapSearchBar = false
                        // 목적지 주소 변경
                        Coordinator.shared.address = place.address
                        Coordinator.shared.destination = (Double(place.y)!, Double(place.x)!)
                        // 목적지로 카메라 이동
                        Coordinator.shared.cameraUpdateToDestination()
                    } label: {
                        VStack(alignment: .leading) {
                            Text(place.name)
                                .font(.headline)
                            Text(place.address)
                                .font(.subheadline)
                        }
                    }

                    
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear {
            isFocused = true
            // Debounce 설정
            debounceCancellable = keywordPublisher
                .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
                .sink { keyword in
                    self.searchPlaces()
                }
        }
    }
    
    func searchPlaces() {
        guard !keyword.isEmpty else { return }
        
        let kakaoApiKey = "da02a05d46189ed10a815fbe783d51a3"
        let apiUrl = "https://dapi.kakao.com/v2/local/search/keyword.json"
        
        var urlComponents = URLComponents(string: apiUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: keyword)
        ]
        
        guard let url = urlComponents.url else {
            print("URL 생성 실패")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("KakaoAK \(kakaoApiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("네트워크 오류: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        places = searchResponse.documents.map {
                            Place(id: $0.id, name: $0.placeName, address: $0.addressName, x: $0.x, y: $0.y)
                        }
                    }
                } catch {
                    print("파싱 오류: \(error.localizedDescription)")
                }
            }
            
            // 디버그 정보 출력
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP 응답 코드: \(httpResponse.statusCode)")
            }
            
            if let dataString = String(data: data!, encoding: .utf8) {
                print("API 응답 데이터: \(dataString)")
            }
        }.resume()
    }
}

struct SearchResponse: Codable {
    let documents: [PlaceData]
}

struct PlaceData: Codable {
    let addressName, categoryGroupCode, categoryGroupName, categoryName: String
    let distance, id, phone, placeName: String
    let placeURL: String
    let roadAddressName, x, y: String
    
    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case categoryGroupCode = "category_group_code"
        case categoryGroupName = "category_group_name"
        case categoryName = "category_name"
        case distance, id, phone
        case placeName = "place_name"
        case placeURL = "place_url"
        case roadAddressName = "road_address_name"
        case x, y
    }
}


struct MapSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchView(tapSearchBar: Binding.constant(false))
    }
}
