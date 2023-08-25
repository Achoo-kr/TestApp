//
//  MapView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import SwiftUI

struct MapView: View {
    
    var body: some View {
//        KakaoMapVCWrapper()
        ZStack {
            ZStack {
                MapSearchBar()
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
