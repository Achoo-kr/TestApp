//
//  ButtonView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/19.
//

import SwiftUI

struct CustomButton<Content: View>: View {
    let action: () -> Void
    let content: Content
    
    init(action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        Button(action: action) {
            content
                .font(.title2)
                .bold()
        }
        .frame(height: 70)
        .padding(.horizontal, 110)
        .background(Color.representColor)
        .foregroundColor(Color.white)
        .cornerRadius(16)
    }
}
