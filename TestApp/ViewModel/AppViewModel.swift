//
//  AppViewModel.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import Foundation

enum Tab {
    case one, two, three
}

class AppViewModel: ObservableObject {
    @Published var selectedTab: Tab
    
    init(selectedTab: Tab = .one) {
        self.selectedTab = selectedTab
    }
}
