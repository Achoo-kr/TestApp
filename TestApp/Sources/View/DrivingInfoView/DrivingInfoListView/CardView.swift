//
//  CardView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/19.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .cornerRadius(16)
                .foregroundColor(.paneColor)
            VStack(alignment: .leading) {
                HStack {
                    Text("2023.08.18(금)")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text("운행목적")
                        .foregroundColor(.lightGray)
                    Text("출장")
                        .foregroundColor(.representColor)
                }
                .padding(20)
                
                HStack(alignment: .top) {
                    VStack {
                        Text("00:00")
                            .font(.subheadline)
                            .padding(.bottom, 35)
                        Text("00:00")
                            .font(.subheadline)
                    }
                    VStack {
                        Image("DepartureDestination")
                    }
                    VStack(alignment: .leading) {
                        Text("출발지")
                            .foregroundColor(.lightGray)
                            .font(.subheadline)
                        Text("서울특별시 양천구 목동서로 133-2")
                            .font(.subheadline)
                            .padding(.bottom)
                        Text("도착지")
                            .foregroundColor(.lightGray)
                            .font(.subheadline)
                        Text("경기도 성남시 분당구 판교역로 152")
                            .font(.subheadline)
                    }
                }
                .padding(.bottom)
                .padding(.horizontal, 20)
                                
                HStack {
                    HStack {
                        Image(systemName: "car.circle.fill")
                        Text("총 운행 100km")
                            .padding(.trailing, 5)
                        Image(systemName: "wonsign.circle.fill")
                        Text("총 비용 3000원")
                    }
                    .padding()
                    .background {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(height: 38)
                            .cornerRadius(30)
                    }
                    .padding(.leading)
                    Spacer()
                    
                    NavigationLink {
                        DrivingInfoView()
                    } label: {
                        Image("ButtonLayer")
                            .padding(.trailing)
                    }

                }
                .padding(.bottom, 20)
            }
        }
        .frame(height: 214)
        .padding()
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
