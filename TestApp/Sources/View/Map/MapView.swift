//
//  MapView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import SwiftUI

struct MapView: View {
    
    @State var searchText: String = ""
    
    var body: some View {
//        KakaoMapVCWrapper()
        ZStack {
            ZStack {
                TextField("도착지를 입력해주세요", text: $searchText)
            }.zIndex(1)
            KakaoMapWrapper()
        }
//            .onAppear {
//                Coordinator.shared.checkIfLocationServicesIsEnabled()
//            }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
