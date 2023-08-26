//
//  DrivingHistoryView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import SwiftUI

struct DrivingHistoryView: View {

    var body: some View {
        VStack{
            HStack {
                Image(systemName: "doc.text.magnifyingglass")
                    .foregroundColor(.representColor)
                Text("양식")
                    .foregroundColor(.black)
                DropDownMenu(menus: ["출장", "출퇴근", "몰라"])
                    .padding(7)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1))
                
            }.padding()
            Divider()
            HStack {
                Image(systemName: "doc.text.magnifyingglass")
                    .foregroundColor(.representColor)
                Text("양식")
                    .foregroundColor(.black)
                DropDownMenu(menus: ["출장", "출퇴근", "몰라"])
                    .padding(7)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1))
                
            }
            .padding()
            Divider()
            HStack {
                Image(systemName: "doc.text.magnifyingglass")
                    .foregroundColor(.representColor)
                Text("양식")
                    .foregroundColor(.black)
                DropDownMenu(menus: ["출장", "출퇴근", "몰라"])
                    .padding(7)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1))
                
            }
            .padding()
            Divider()
            HStack {
                Image(systemName: "doc.text.magnifyingglass")
                    .foregroundColor(.representColor)
                Text("양식")
                    .foregroundColor(.black)
                DropDownMenu(menus: ["출장", "출퇴근", "몰라"])
                    .padding(7)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1))
                
            }
            .padding()
            
            Spacer()
            
            CustomButton {
                //
            } content: {
                Text("다운로드")
            }

        }
        .padding()
    }
}

struct DrivingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingHistoryView()
    }
}
