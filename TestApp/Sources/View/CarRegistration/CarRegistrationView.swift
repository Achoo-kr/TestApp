//
//  CarRegistrationView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import SwiftUI

struct CarRegistrationView: View {
    
    @StateObject var mainViewModel: MainViewModel
    @State private var userId: String = ""
    @State private var carNum: String = ""
    @State private var ownerName: String = ""
    
    var body: some View {
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
                    print("첫 번째 버튼이 눌렸습니다.")
                    mainViewModel.createUser(user: UserInfo(id: UUID().uuidString,
                                                            ownerName: ownerName,
                                                            carNumber: carNum))
                }) {
                    Text("첫 번째 버튼")
                }
                .padding(.bottom, 50)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct CarRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        CarRegistrationView(mainViewModel: MainViewModel())
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
