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
        Text(text)
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .frame(width: 200, height: 100)
            .background(Color.blue)
            .cornerRadius(10)
    }
}

struct ShortcutScrollView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
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
