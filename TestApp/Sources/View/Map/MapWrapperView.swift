//
//  MapWrapperView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/31.
//

import SwiftUI

struct MapWrapperView: View {
    
    @StateObject var coordinator: Coordinator = Coordinator.shared
    @ObservedObject var mainViewModel: MainViewModel
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    @Binding var tapSearchBar: Bool
    @State private var isStartedNavi: Bool = false
    //선택시 분기처리 해줄 변수
    @State private var destinationSelected: Bool = false
    
    var address: String
    var currentAddress: String
    let currentDate: Date = Date()
    var currentTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let currentTime = formatter.string(from: currentDate)
        return currentTime
    }
    var drivingDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd.(E)"
        let drivingDate = formatter.string(from: currentDate)
        return drivingDate
    }
    
    var body: some View {
        VStack {
            if !destinationSelected {
                
                NavigationLink {
                    MapSearchView(tapSearchBar: $tapSearchBar)
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        VStack(spacing: 0){
                            MapSearchBar()
                        }
                    }
                    .padding(7)
                    .font(.subheadline)
                    .cornerRadius(20)
                    .padding(7)
                    .shadow(radius: 10)
                }
                
            } else {
                HStack{
                    Button {
                        destinationSelected = false
                    } label: {
                        Image("backButton")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .aspectRatio(contentMode: .fit)
                            .offset(y: 5)
                    }
                    Spacer()
                }

            }
            
            Spacer()
            if !destinationSelected {
                ShortcutScrollView(destinationSelected: $destinationSelected)
            } else {
                MapBottomSheet(mainViewModel: mainViewModel, drivingInfoViewModel: drivingInfoViewModel, address: address, currentAddress: currentAddress)
            }
            
        }
        .alert(
            "주행종료",
            isPresented: $mainViewModel.showAlert
        ) {
            Button {
                let endAddress: String = coordinator.currentAddress[1]
                Task {
                    await drivingInfoViewModel.updateDrivingInfo(["endAddress":endAddress,"endTime":currentTime])
                    
                }
            } label: {
                Text("확인")
            }
        } message: {
            Text("주행이 완료되었습니다")
        }
    }
}

struct MapWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.systemGray)
            MapWrapperView(mainViewModel: MainViewModel(), drivingInfoViewModel: DrivingInfoViewModel(), tapSearchBar: Binding.constant(false), address: "Test", currentAddress: "Test")
        }
        
    }
}
