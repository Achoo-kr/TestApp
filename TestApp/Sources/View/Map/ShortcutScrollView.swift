//
//  ShortcutScrollView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/31.
//

import SwiftUI

struct CustomCardButton: View {
    var text: String
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageName)
                    .padding(.trailing, 8)
                Text(text)
                    .bold()
                    .font(.title2)
            }
            .foregroundColor(.black)
            .padding(.vertical , 20)
            .padding(.horizontal, 40)
        }
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
                    CustomCardButton(text: "집", imageName: "MapMarker", action: {
                        print("\(index) 버튼을 눌렀습니다.")
                    })
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
