//
//  MapSearchBar.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/25.
//

import SwiftUI

struct MapSearchBar: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.trailing, 8)
            Text("목적지를 입력해주세요")
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding(.leading, 16)
        .padding(.trailing, 56)
        .padding(.vertical, 8)
        .frame(height: 48, alignment: .leading)
        .background(.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.24), radius: 7, x: 0, y: 4)
    }
}
