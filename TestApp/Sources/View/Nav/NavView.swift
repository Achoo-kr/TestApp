//
//  NavView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import SwiftUI

struct NavView: UIViewControllerRepresentable {
    
    @Binding var active: Bool
    let startDest: String
    let startX, startY: CGFloat
    let endDest: String
    let endX, endY: CGFloat
    
    func activate(_ value: Bool) {
        self.active = value
    }
    
    func makeUIViewController(context: Context) -> NavVC {
        let vc = NavVC()
        vc.startNavigate(withStartDest: startDest,
                         startX: startX,
                         startY: startY,
                         endDest: endDest,
                         endX: endX,
                         endY: endY,
                         activate: activate)
        return vc
    }

    func updateUIViewController(_ uiViewController: NavVC, context: Context) {
    }
}
