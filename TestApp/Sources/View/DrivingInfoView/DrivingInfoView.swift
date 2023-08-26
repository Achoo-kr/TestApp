//
//  DrivingInfoView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/19.
//

import SwiftUI

struct DrivingInfoView: View {
    var body: some View {
        VStack{
            VStack(alignment: .leading) {
                HStack {
                    Text("2023.08.18(금)")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding(.vertical)
                HStack {
                    Text("운행 목적")
                        .foregroundColor(.representColor)
                    
                    Text("출장")
                    Spacer()
                    Button {
                        //
                    } label: {
                        Image("DropDownImage")
                    }
                }
                Divider()
                HStack {
                    Text("차량 선택")
                        .foregroundColor(.representColor)
                    
                    Text("[법인]360노9959")
                    Spacer()
                    Button {
                        //
                    } label: {
                        Image("DropDownImage")
                    }
                }
                Divider()
                HStack(alignment: .top) {
                    Text("운행정보")
                        .foregroundColor(.representColor)
                        .padding(.trailing, 5)
                    
                    VStack(alignment: .leading) {
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
                            VStack{
                                
                            }
                        }
                        .padding(.bottom, 5)
                        
                        // 지도 들어갈 공간
                        ZStack(alignment: .bottom) {
//                            Rectangle()
//                                .cornerRadius(10)
//                                .frame(width: 300)
//
//                            Color.white.opacity(0.0)
//                                .frame(width: 300, height: 50)
//                                .background(.ultraThinMaterial)
//
//                            HStack {
//                                Image(systemName: "car.circle.fill")
//                                    .font(.subheadline)
//                                    .foregroundColor(.representColor)
//                                Text("총 운행 100km")
//                                    .font(.subheadline)
//                                    .padding(.trailing, 5)
//                                Image(systemName: "wonsign.circle.fill")
//                                    .font(.subheadline)
//                                    .foregroundColor(.representColor)
//                                Text("총 비용 3000원")
//                                    .font(.subheadline)
//                            }
//                            .padding()
                            
                        }
                        .frame(width: 100, height: 100)
                        .background(Color.gray)
                        .cornerRadius(15)
                    }
                }
                Divider()
                HStack(alignment: .top) {
                    Text("메모")
                        .foregroundColor(.representColor)
                        .padding(.trailing, 30)
                    HStack{
                        Button {
                            //
                        } label: {
                            VStack(alignment: .leading){
                                Image(systemName: "mappin.and.ellipse")
                                    .resizable()
                                    .frame(width: 20, height: 23)
                                    .foregroundColor(.black)
                                HStack {
                                    Text("통행료")
                                    Image(systemName: "square.and.pencil")
                                }
                                .foregroundColor(.gray)
                                Text("3,000원")
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer()
                        Button {
                            //
                        } label: {
                            VStack(alignment: .leading){
                                Image(systemName: "fuelpump")
                                    .resizable()
                                    .frame(width: 20, height: 23)
                                    .foregroundColor(.black)
                                HStack {
                                    Text("유류비")
                                    Image(systemName: "square.and.pencil")
                                }
                                .foregroundColor(.gray)
                                Text("3,000원")
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer()
                        Button {
                            //
                        } label: {
                            VStack(alignment: .leading){
                                Image(systemName: "arrow.counterclockwise.circle.fill")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                                    .foregroundColor(.black)
                                HStack {
                                    Text("감가상각")
                                    Image(systemName: "square.and.pencil")
                                }
                                .foregroundColor(.gray)
                                Text("0원")
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                
            }
            .padding()
            //버튼 나중에 뿌려주는 식으로
            CustomButton(action: {
                print("첫 번째 버튼이 눌렸습니다.")
            }) {
                Text("첫 번째 버튼")
            }
            .padding(.vertical)
        }
    }
}

struct DrivingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingInfoView()
    }
}
