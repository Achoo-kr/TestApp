//
//  MapBottomSheet.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/26.
//

import SwiftUI

struct MapBottomSheet: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var coordinator: Coordinator = Coordinator.shared
    //@StateObject var mainViewModel: MainViewModel
    
    var address: String
    var currentAddress: String
    
    var body: some View {
            ZStack {
                Color(UIColor(.paneColor))
                VStack(spacing: 0) {
                    HStack {
                        Image("StartMapMarker")
                            .padding(.trailing, -10)
                        Text("현위치:")
                            .bold()
                        Text("\(currentAddress)")
                        Spacer()
                    }
                    
                    HStack {
                        Image("EndMapMarker")
                            .padding(.trailing, -10)
                        Text("목적지:")
                            .bold()
                        Text("\(address)")
                        Spacer()
                    }
                    
                    HStack {
                        CustomButton {
                            mainViewModel.active = true
                        } content: {
                            Text("안내시작")
                        }
                    }
                    Spacer()
                }
                .font(.title3)
                .padding(10)
                
            }
            .cornerRadius(10)
            .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .leading)
    }
}

struct MapBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.systemGray)
            MapBottomSheet(address: "Test", currentAddress: "Test")
        }
        
    }
}
