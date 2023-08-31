//
//  MapSearchBar.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/25.
//

import SwiftUI

struct MapSearchBar: View {
    
    var body: some View {
        HStack {
            Text("목적지를 입력해주세요")
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
            Spacer()
            Image("magnifyingglass")
        }
        .padding(10)
        .frame(width: 300)
        .background{
            Color.white
        }
        .cornerRadius(10)
    }
}
