//
//  ShortcutScrollView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/31.
//

import SwiftUI

struct CardButton: View {
    var text: String
    
    var body: some View {
        HStack{
            Image("MapMarker")
                .padding(.trailing, 8)
            Text("집")
                .bold()
                .font(.title2)
        }
        .foregroundColor(.black)
        .padding(.vertical , 25)
        .padding(.horizontal, 40)
        .background {
            Color.white
                .cornerRadius(18)
                .shadow(color: .black.opacity(0.24), radius: 8, x: 0, y: 4)
        }
    }
}

struct ShortcutScrollView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(0..<10) { index in
                    CardButton(text: "Card \(index)")
                        .onTapGesture {
                            print("Card \(index) tapped!")
                        }
                }
            }
            .padding()
        }
    }
}
struct ShortcutScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutScrollView()
    }
}
