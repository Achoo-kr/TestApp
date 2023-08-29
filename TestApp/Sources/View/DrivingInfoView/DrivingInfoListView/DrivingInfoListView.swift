//
//  DrivingInfoListView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/29.
//

import SwiftUI

struct DrivingInfoListView: View {
    var body: some View {
        VStack{
            SelectionBlockView()
                .padding(.vertical, 5)
            ScrollView {
                CardView()
                    .padding(.vertical)
                CardView()
                    .padding(.vertical)
            }
        }
    }
}

struct DrivingInfoListView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingInfoListView()
    }
}
