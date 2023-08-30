//
//  CarRegistrationView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import SwiftUI

struct CarRegistrationView: View {
    @ObservedObject var carRegVM: CarRegistrationViewModel
    @ObservedObject var mainViewModel: MainViewModel
    @State private var userId: String = ""
    @State private var carNum: String = ""
    @State private var ownerName: String = ""
    @State private var isShowingAlert: Bool = false
    @AppStorage("carName") var carName: String = ""
    @AppStorage("carReg") var carReg: String = ""
    
    var body: some View {
        ZStack{
            ScrollViewReader { proxy in
                VStack(spacing: 50){
                    Text("차량을 등록해주세요")
                        .bold()
                        .font(.title)
                        .padding(.top, 80)
                    Spacer()
                    Image("Car")
                        .resizable()
                        .frame(width: 240, height: 140)
                    VStack(spacing: 20){
                        HStack{
                            Image(systemName: "car")
                                .foregroundColor(Color.representColor)
                            Text("차량번호")
                            TextField("23사5678", text: $carNum)
                                .disableAutocorrection(true)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack{
                            Image(systemName: "car")
                                .foregroundColor(Color.representColor)
                            Text("소유주명")
                            TextField("홍길동", text: $ownerName)
                                .disableAutocorrection(true)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.horizontal, 50)
                    Spacer()
                    CustomButton(action: {
                        carRegVM.getCarInfo(registratedNum: carNum, ownerName: ownerName) { carName in
                            if let name = carName {
                                print("차이름: \(name)")
                                self.carName = name
                                self.carReg = carNum
                            } else {
                                print("차 이름을 가져오지 못했습니다.")
                            }
                        }
                        mainViewModel.createUser(user: UserInfo(id: carNum,
                                                                ownerName: ownerName,
                                                                carNumber: carNum))
                    }) {
                        Text("등록하기")
                    }
                    .padding(.bottom, 50)
                }
            }
            if carRegVM.isLoadingData == true {
                Color.gray.opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                ProgressView()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .alert(isPresented: $carRegVM.isShowingAlert) {
            Alert(
                title: Text("확인되지 않은 차량!"),
                message: Text("등록된 차를 찾을 수 없습니다."),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}

struct CarRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        CarRegistrationView(carRegVM: CarRegistrationViewModel(), mainViewModel: MainViewModel())
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
