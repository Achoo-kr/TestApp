//
//  NavView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import SwiftUI

struct NavView: UIViewControllerRepresentable {
    
    let startDest: String
    let startX, startY: Double
    let startAddress, endAddress: String
    let endDest: String
    let endX, endY: Double
    
    func makeUIViewController(context: Context) -> NavVC {
        let vc = NavVC()
        
        vc.startNavigate(withStartDest: startDest,
                         startX: startX,
                         startY: startY,
                         startAddress: startAddress,
                         endDest: endDest,
                         endX: endX,
                         endY: endY,
                         endAddress: endAddress)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: NavVC, context: Context) {
    }
}

//final class NaviCoordinator: NSObject, ObservableObject {
//
//}
