//
//  DrivingInfoView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/19.
//

import SwiftUI

struct DrivingInfoView: View {
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    let drivingInfo: DrivingInfo
    var body: some View {
        VStack{
            HStack(alignment: .bottom){
                Text("운행정보")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding()
            VStack(alignment: .leading) {
                HStack {
                    Text("\(drivingInfo.date)")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding(.vertical)
                
                HStack {
                    Text("운행 목적")
                        .foregroundColor(.representColor)
                    DropDownMenu(menus: ["출장", "출퇴근", "몰라"])
                }
                
                Divider()
                HStack {
                    Text("차량 선택")
                        .foregroundColor(.representColor)
                    DropDownMenu(menus: ["출장", "출퇴근", "몰라"])
                    
                }
                Divider()
                HStack(alignment: .top) {
                    Text("운행정보")
                        .foregroundColor(.representColor)
                        .padding(.trailing, 5)
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            VStack {
                                Text(drivingInfo.startTime)
                                    .font(.subheadline)
                                    .padding(.bottom, 35)
                                Text(drivingInfo.endTime)
                                    .font(.subheadline)
                            }
                            VStack {
                                Image("DepartureDestination")
                            }
                            VStack(alignment: .leading) {
                                Text(drivingInfo.startAddress)
                                    .font(.subheadline)
                                    .padding(.bottom, 35)
                                Text(drivingInfo.endAddress)
                                    .font(.subheadline)
                            }
                            VStack{
                                
                            }
                        }
                        .padding(.bottom, 5)
                        
                        // 지도 들어갈 공간
                        ZStack(alignment: .bottom) {
                            //                            Rectangle()
                            //                                .cornerRadius(10)
                            //                                .frame(width: 300)
                            //
                            //                            Color.white.opacity(0.0)
                            //                                .frame(width: 300, height: 50)
                            //                                .background(.ultraThinMaterial)
                            //
                            //                            HStack {
                            //                                Image(systemName: "car.circle.fill")
                            //                                    .font(.subheadline)
                            //                                    .foregroundColor(.representColor)
                            //                                Text("총 운행 100km")
                            //                                    .font(.subheadline)
                            //                                    .padding(.trailing, 5)
                            //                                Image(systemName: "wonsign.circle.fill")
                            //                                    .font(.subheadline)
                            //                                    .foregroundColor(.representColor)
                            //                                Text("총 비용 3000원")
                            //                                    .font(.subheadline)
                            //                            }
                            //                            .padding()
                            
                        }
                        .frame(width: 100, height: 100)
                        .background(Color.gray)
                        .cornerRadius(15)
                    }
                }
                Divider()
                HStack(alignment: .top) {
                    Text("메모")
                        .foregroundColor(.representColor)
                        .padding(.trailing, 30)
                    HStack{
                        Button {
                            //
                        } label: {
                            VStack(alignment: .leading){
                                Image(systemName: "mappin.and.ellipse")
                                    .resizable()
                                    .frame(width: 20, height: 23)
                                    .foregroundColor(.black)
                                HStack {
                                    Text("통행료")
                                    Image(systemName: "square.and.pencil")
                                }
                                .foregroundColor(.gray)
                                Text("\(drivingInfo.tollFee)")
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer()
                        Button {
                            //
                        } label: {
                            VStack(alignment: .leading){
                                Image(systemName: "fuelpump")
                                    .resizable()
                                    .frame(width: 20, height: 23)
                                    .foregroundColor(.black)
                                HStack {
                                    Text("유류비")
                                    Image(systemName: "square.and.pencil")
                                }
                                .foregroundColor(.gray)
                                Text("\(drivingInfo.fuelFee)")
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer()
                        Button {
                            //
                        } label: {
                            VStack(alignment: .leading){
                                Image(systemName: "arrow.counterclockwise.circle.fill")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                                    .foregroundColor(.black)
                                HStack {
                                    Text("감가상각")
                                    Image(systemName: "square.and.pencil")
                                }
                                .foregroundColor(.gray)
                                Text("\(drivingInfo.depreciation)")
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.trailing, 3)
                    }
                }
                
            }
            .padding(.horizontal)
            //TODO: 저장버튼
            CustomButton(action: {
                Task {
                    await drivingInfoViewModel.saveEndDrivingInfo(["purpose":"운행목적",
                                                                   "tollFee":123,
                                                                   "fuelFee":123,
                                                                   "depriciate":123])
                }
                
            }) {
                Text("저장하기")
            }
            .padding(.vertical)
        }
        //        .navigationTitle("운행정보")
    }
}

struct DrivingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingInfoView(drivingInfoViewModel: DrivingInfoViewModel(), drivingInfo: DrivingInfo(id: "", date: "2023.08.30.(수)", purpose: "출장", totalDistance: 0, startAddress: "출발", startTime: "15:33", endAddress: "도착", endTime: "13:33", fuelFee: 123, tollFee: 123, depreciation: 123))
    }
}
