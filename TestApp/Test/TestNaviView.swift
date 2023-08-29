////
////  TestNaviView.swift
////  TestApp
////
////  Created by 강창현 on 2023/08/29.
////
//
//import SwiftUI
//import KNSDKBundle
//
//struct TestNaviView: View {
//    @State private var destinationLatitude: Double = 37.5665
//    @State private var destinationLongitude: Double = 126.9780
//
//    var body: some View {
//        VStack {
//            NavigationView(latitude: $destinationLatitude, longitude: $destinationLongitude)
//            
//            Button("Start Navigation") {
//                startNavigationToDestination()
//            }
//            .padding()
//        }
//    }
//    
//    func startNavigationToDestination() {
//        // Check if KakaoNavi app is installed
//        guard KakaoNavi.shared.isKakaoNaviInstalled() else {
//            // Handle the case where KakaoNavi app is not installed
//            return
//        }
//        
//        // Create a destination coordinate
//        let destination = KNVLocation(name: "Destination", x: destinationLongitude, y: destinationLatitude)
//        
//        // Set up the navigation options
//        let options = KNVOptions()
//        options.routeInfo?.startX = "" // Current location X-coordinate
//        options.routeInfo?.startY = "" // Current location Y-coordinate
//        options.routeInfo?.endX = "\(destination.x)"
//        options.routeInfo?.endY = "\(destination.y)"
//        
//        // Open KakaoNavi app for navigation
//        KakaoNavi.shared.share(destination: destination, options: options)
//    }
//}
//
//struct NavigationView: View {
//    @Binding var latitude: Double
//    @Binding var longitude: Double
//
//    var body: some View {
//        // Display a map with the destination marker
//        Map(coordinateRegion: .constant(
//                .init(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
//                      span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//            )
//        )
//        .frame(height: 300)
//    }
//}
//struct TestNaviView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestNaviView()
//    }
//}
