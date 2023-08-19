//
//  ButtonView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/19.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .cornerRadius(16)
                .foregroundColor(.representColor)
            
            Text("변경사항 저장")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
        }
        .frame(height: 70)
        .padding(.horizontal, 30)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
