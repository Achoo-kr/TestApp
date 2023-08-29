//
//  DownloadedHistoryRow.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/29.
//

import SwiftUI

struct DownloadedHistoryRow: View {
    @State private var selected: Bool = false
    var body: some View {
        HStack(alignment: .center){
            Button {
                selected.toggle()
            } label: {
                if selected == false {
                    Circle()
                        .stroke(lineWidth: 3)
                        .foregroundColor(.lightGray)
                        .frame(width: 35)
                } else if selected == true {
                    ZStack {                        Circle()
                            .foregroundColor(.representColor)
                            .frame(width: 35)
                        Image(systemName: "checkmark")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.trailing)
            Image("OfficeLogo")
                .resizable()
                .frame(width: 35, height: 35)
            Text("2023-08-01 ~ 2023-08-17.xls")
            Spacer()
            Button {
                //
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(Angle(degrees: 90))
                    .foregroundColor(.lightGray)
            }
        }
        .padding()
    }
}

struct DownloadedHistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        DownloadedHistoryRow()
    }
}
