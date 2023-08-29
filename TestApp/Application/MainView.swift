////
////  MainView.swift
////  TestApp
////
////  Created by 추현호 on 2023/08/26.
////
//
//import SwiftUI
//import CoreLocation
//
///*
// let decimalPlaces = String(x).split(separator: ".")
// let power = pow(10.0, Double(decimalPlaces[1].count))
// let intValue = Int(x * power)
// */
//
//
//struct MainView: View {
//    
//    init() {
//        UITabBar.appearance().backgroundColor = UIColor(Color.white)
//    }
//    
//    @StateObject private var coordinator: Coordinator = Coordinator.shared
//    @EnvironmentObject var viewModel: MainViewModel
//    
//    var body: some View {
//        
//        if viewModel.active {
//            
////            let decimalPlaces = String(x).split(separator: ".")
////            let power = pow(10.0, Double(decimalPlaces[1].count))
////            let intValue = Int(x * power)
//            
//            NavView(active: $viewModel.active,
//                    startDest: "현재 위치",
////                    startX: CGFloat(coordinator.userLocation.1),
////                    startY: CGFloat(coordinator.userLocation.0),
//                    startX: 321286,
//                    startY: 533707,
//                    //                    startX: CGFloat(location.coordinate.longitude),
//                    //                    startY: CGFloat(location.coordinate.latitude),
//                    endDest: "도착 위치",
////                    endX: CGFloat(coordinator.destination.1),
////                    endY: CGFloat(coordinator.destination.0))
//                    endX: 321525,
//                    endY: 532951)
//                    
//            
//            .ignoresSafeArea()
//            .onAppear {
//                coordinator.checkIfLocationServicesIsEnabled()
//                print("현재위치: \(coordinator.userLocation),\n 도착위치: \(coordinator.destination)")
//                print("도착위치(CGFloat): \(CGFloat(coordinator.destination.0)), \(CGFloat(coordinator.destination.1)))")
//            }
//        } else {
//            MapView()
//        }
//        
//        //        if let location = viewModel.currentLocation {
//        //            NavView(active: $viewModel.active,
//        //                    startDest: "현재 위치",
//        //                    startX: 321286,
//        //                    startY: 533707,
//        ////                    startX: CGFloat(location.coordinate.longitude),
//        ////                    startY: CGFloat(location.coordinate.latitude),
//        //                    endDest: "도착 위치",
//        //                    endX: 321525,
//        //                    endY: 532951)
//        //            .ignoresSafeArea()
//        //            .onAppear{
//        //                print(viewModel.currentLocation)
//        //            }
//        //        } else {
//        //            Text("위치 정보를 가져오는 중...")
//        //                .ignoresSafeArea()
//        //        }
//        
//    }
//}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
