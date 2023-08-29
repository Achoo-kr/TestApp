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
//            Text("내비 시작")
            KakoNavWrapper()
//            .edgesIgnoringSafeArea(.all)
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
