//
//  MapView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var mainViewModel: MainViewModel
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    @StateObject var coordinator: Coordinator = Coordinator.shared
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            ZStack {
                VStack(alignment: .leading) {
                    TextField("도착지를 입력해주세요", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.top, 30)
                        .padding(.horizontal)
                    Spacer()
                    MapBottomSheet(mainViewModel: mainViewModel, drivingInfoViewModel: drivingInfoViewModel, address: coordinator.address,
                                   currentAddress: coordinator.isLocationDataLoaded ? coordinator.currentAddress[1] : coordinator.currentAddress[0])
                }
            }
            .zIndex(1)
            // FIXME: - 하단 탭바 이슈(가려짐)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
            // 도착 이미지 마커
            Image("MapMarker")
                .zIndex(1)
            
            KakaoMapWrapper()
                .ignoresSafeArea(.all, edges: .top)
        }
        .onAppear {
            coordinator.checkIfLocationServicesIsEnabled()
//            print("현재위치: \(coordinator.userLocation),\n 도착위치: \(coordinator.destination)")
//            print("도착위치(CGFloat): \(CGFloat(coordinator.destination.0)), \(CGFloat(coordinator.destination.1)))")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mainViewModel: MainViewModel(), drivingInfoViewModel: DrivingInfoViewModel())
    }
}
