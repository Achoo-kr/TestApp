//
//  MapBottomSheet.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/26.
//

import SwiftUI

struct MapBottomSheet: View {
    
    var address: String
    var currentAddress: String
    var body: some View {
        ZStack {
            Color(.systemBackground)
            VStack(alignment: .leading) {
                HStack {
                    Text("현위치:")
                    Text("\(currentAddress)")
                    Spacer()
                }
                .padding(.bottom)
                
                HStack {
                    Text("목적지:")
                    Text("\(address)")
                    Spacer()
                }
                
            }
            .padding(.leading, 10)
            
        }
        .cornerRadius(10)
        .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .leading)
//        .background(Color(.systemRed))
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
