//
//  MapBottomSheet.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/26.
//

import SwiftUI

struct MapBottomSheet: View {
    
    @StateObject var coordinator: Coordinator = Coordinator.shared
    @ObservedObject var mainViewModel: MainViewModel
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    @Binding var tapSearchBar: Bool
    @State private var isStartedNavi: Bool = false
    
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
            HStack(spacing: 0) {
                VStack(spacing: 0){
                    HStack(alignment: .center) {
                        Image("StartMapMarker")
                            .padding(.bottom, -8)
                        Text("현위치:")
                            .bold()
                        Text("\(currentAddress)")
                            .padding(.leading, 8)
                        Spacer()
                    }
                    
                    HStack(alignment: .center) {
                        Image("EndMapMarker")
                            .padding(.bottom, -8)
                        Text("목적지:")
                            .bold()
                        Button {
                            //검색 전체화면
                            tapSearchBar = true
                        } label: {
                            Text("\(address)")
                                .lineLimit(1)
                                .foregroundColor(.black)
                        }
                        .frame(minWidth: 200, alignment: .leading)
                        .padding(10)
                        .overlay{
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.representColor, lineWidth: 3)
                        }
                        
                        Spacer()
                    }
                    
                }
            }
            .padding(7)
            .font(.subheadline)
            .background(Color.paneColor)
            .cornerRadius(20)
            .padding(7)
            .shadow(radius: 10)
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
            
            Spacer()
            
            HStack {
                if isStartedNavi {
                    CustomButton {
                        mainViewModel.active = true
                        mainViewModel.startAddress = coordinator.currentAddress[1]
                        Task {
                            let id = UUID().uuidString
                            await drivingInfoViewModel.saveStartDrivingInfo(id: id, drivingInfo: DrivingInfo(id: id, date: drivingDate, purpose: "", totalDistance: 0, startAddress: coordinator.currentAddress[1], startTime: currentTime, endAddress: "", endTime: "", fuelFee: 0, tollFee: 0, depreciation: 0))
                            drivingInfoViewModel.recentRef = id
                            
                            print("시작시점 경로:\(drivingInfoViewModel.recentRef)")
                        }
                        isStartedNavi.toggle()
                    } content: {
                        Text("안내시작")
                    }
                } else {
                    CustomButton {
                        coordinator.createRoute()
                        isStartedNavi.toggle()
                    } content: {
                        Text("길찾기")
                    }
                }
            }
            .padding(.bottom, 20)
        }
    }
}

struct MapBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.systemGray)
            MapBottomSheet(mainViewModel: MainViewModel(), drivingInfoViewModel: DrivingInfoViewModel(), tapSearchBar: Binding.constant(false), address: "Test", currentAddress: "Test")
        }
        
    }
}
