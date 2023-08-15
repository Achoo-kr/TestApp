//
//  ContentView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavView(active: $viewModel.active,
                startDest: "현재 위치",
                startX: 321286,
                startY: 533707,
//                    startX: CGFloat(location.coordinate.longitude),
//                    startY: CGFloat(location.coordinate.latitude),
                endDest: "도착 위치",
                endX: 321525,
                endY: 532951)
        .ignoresSafeArea()
//        if let location = viewModel.currentLocation {
//            NavView(active: $viewModel.active,
//                    startDest: "현재 위치",
//                    startX: CGFloat(location.coordinate.latitude),
//                    startY: CGFloat(location.coordinate.longitude),
//                    endDest: "도착 위치",
//                    endX: 321525,
//                    endY: 532951)
//            .ignoresSafeArea()
//            .onAppear {
//                //                LocationManager().checkIfLocationServicesIsEnabled()
//                //                print(viewModel.currentLocation)
//            }
//        }
//        else {
//            Text("위치 정보를 가져오는 중...")
//                .ignoresSafeArea()
//                .onAppear {
//                    // print(viewModel.currentLocation)
//                }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
