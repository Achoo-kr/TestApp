//
//  EditChargeView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/30.
//

import SwiftUI

struct EditChargeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    let drivingInfo: DrivingInfo
    let type: String
    @State var charge: String = "0"
    @State var chargeInfo: String = "법인카드"
    var body: some View {
        VStack(alignment: .center){
            VStack(alignment: .leading) {
                HStack(alignment: .bottom){
                    Text("운행정보")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding()
                Text("지출 등록")
                    .font(.title3)
                    .foregroundColor(.representColor)
                    .bold()
                VStack(alignment: .leading) {
                    HStack{
                        Text("날짜")
                            .foregroundColor(.gray)
                            .padding(.trailing)
                        Text("\(drivingInfo.date)")
                            .font(.title3)
                            .bold()
                    }
                    .padding()
                    Divider()
                    HStack{
                        Text("항목")
                            .foregroundColor(.gray)
                            .padding(.trailing)
                        if type == "유류비" {
                            Image(systemName: "fuelpump")
                                .bold()
                        } else if type == "통행료" {
                            Image(systemName: "mappin.and.ellipse")
                                .bold()
                        }
                        
                        Text(type)
                            .font(.title3)
                            .bold()
                        if type == "유류비" {
                            Text("(차량 등록 연비 * 거리)")
                                .font(.title3)
                                .foregroundColor(.representColor)
                        }
                        
                    }
                    .padding()
                    Divider()
                    
                    HStack(spacing: 10) {
                        Text("금액")
                            .bold()
                            .foregroundColor(.black)
                            .padding(.trailing)
                        
                        TextField(type == "유류비" ? "\(drivingInfo.fuelFee)" : "\(drivingInfo.tollFee)",
                                  text: $charge)
                            .keyboardType(.numberPad)
                            .disableAutocorrection(true)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Text("원")
                            .foregroundColor(.black)
                            .font(.title3)
                    }
                    .padding()
                    
                }
                Text("결제 정보")
                    .foregroundColor(.representColor)
                    .font(.title3)
                    .bold()
                VStack(alignment: .leading){
                    HStack {
                        Text("결제방법")
                            .bold()
                            .foregroundColor(.black)
                            .padding(.trailing)
                        DropDownMenu(menus: ["법인카드", "개인카드"], selection: $chargeInfo)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            HStack(spacing: 30) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("취소")
                        .foregroundColor(.gray)
                        .font(.title2)
                        .bold()
                }
                .frame(width: 150, height: 60)
                .background(Color.white)
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray, lineWidth: 3)
                )
                
                Button {
                    if type == "유류비" {
                        Task {
                            await drivingInfoViewModel.updateDrivingInfo(["fuelFee":charge])
                        }
                        
                    } else if type == "통행료" {
                        Task {
                            await drivingInfoViewModel.updateDrivingInfo(["tollFee":charge])
                        }
                    }
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("등록")
                        .font(.title2)
                        .bold()
                }
                .frame(width: 150, height: 60)
                .background(Color.representColor)
                .foregroundColor(.white)
                .cornerRadius(16)
            }
            .padding()
        }
    }
}

//struct EditChargeView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditChargeView()
//    }
//}
