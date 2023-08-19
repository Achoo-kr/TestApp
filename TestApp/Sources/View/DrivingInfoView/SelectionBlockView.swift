//
//  SelectionBlockView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/19.
//

import SwiftUI

struct SelectionBlockView: View {
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .cornerRadius(16)
                .foregroundColor(.representColor)
            
            HStack {
                VStack {
                    Text("2023")
                        .foregroundColor(.white)
                        .padding(.bottom, 1)
                    HStack {
                        Button {
                            //
                        } label: {
                            Image(systemName: "arrowtriangle.left.fill")
                                .foregroundColor(.lightGray)
                                .frame(width: 8)
                        }
                        .padding(8)
                        
                        
                        Button {
                            //
                        } label: {
                            Text("8월")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .padding(8)
                        
                        Button {
                            //
                        } label: {
                            Image(systemName: "arrowtriangle.right.fill")
                                .foregroundColor(.lightGray)
                                .frame(width: 8)
                        }
                        .padding(8)
                    }
                }
                .padding(.leading, 20)
                
                Rectangle()
                    .frame(width: 1, height: 60)
                    .foregroundColor(.gray)
                    .padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("운행기록")
                        Text("운행거리")
                        Text("총 비용")
                    }
                    .foregroundColor(.lightGray)
                    .padding(.trailing)
                    VStack(alignment: .leading) {
                        Text("4 건")
                        Text("100km")
                        Text("15000원")
                    }.foregroundColor(.white)
                }
                .padding(.leading, 8)
            }
        }
        .frame(height: 100)
        .padding()
    }
}

struct SelectionBlockView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionBlockView()
    }
}
