//
//  TestNavigationView.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/29.
//

import SwiftUI

struct TestNavigationView: View {
    
    @StateObject private var coordinator: Coordinator = Coordinator.shared
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        if viewModel.active {
            NavView(startDest: coordinator.currentAddress[1],
                    startX: coordinator.userLocation.1,
                    startY: coordinator.userLocation.0,
                    startAddress: coordinator.currentAddress[1],
                    endAddress: coordinator.address,
                    endDest: coordinator.address,
                    endX: coordinator.destination.1,
                    endY: coordinator.destination.0)
            .edgesIgnoringSafeArea(.all)
        } else {
            MapView()
        }
    }
}

struct TestNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TestNavigationView()
    }
}
