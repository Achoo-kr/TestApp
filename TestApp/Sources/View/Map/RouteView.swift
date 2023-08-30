//
//  RouteView.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/31.
//

import SwiftUI

struct RouteView: View {
    @State var draw: Bool = false   //뷰의 appear 상태를 전달하기 위한 변수.
    var body: some View {
        ZStack {
            KakaoMapView(draw: $draw)
                .onAppear(perform: {
                    self.draw = true
                    KakaoMapCoordinator.shared.addViews()
                })
                .onDisappear(perform: {
                    self.draw = false
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Button("이동") {
                KakaoMapCoordinator.shared.moveCamera()
            }
        }
        
    }
}

struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView()
    }
}
