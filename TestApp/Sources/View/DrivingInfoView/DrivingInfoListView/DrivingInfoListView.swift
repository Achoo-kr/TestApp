//
//  DrivingInfoListView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/29.
//

import SwiftUI

struct DrivingInfoListView: View {
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    @State var month: Int
    @State var year: Int
    var body: some View {
        NavigationStack {
            VStack{
                HStack(alignment: .center){
                    Text("운행내역")
                        .font(.title2)
                        .bold()
                    Spacer()
                    //TODO: filter
                }
                .padding()
                SelectionBlockView(selectedMonth: $month, selectedYear: $year)
                    .padding(.bottom, 5)
                if drivingInfoViewModel.drivingInfos.isEmpty {
                    ZStack{
                        Color.gray.opacity(0.3)
                        Text("작성된 운행기록이 없습니다")
                            .foregroundColor(.gray)
                    }
                } else {
                    ScrollView {
                        LazyVStack{
                            ForEach(drivingInfoViewModel.drivingInfos) { info in
                                
                                NavigationLink {
                                    DrivingInfoView(drivingInfoViewModel: drivingInfoViewModel, drivingInfo: info)
                                } label: {
                                    CardView(drivingInfoViewModel: drivingInfoViewModel, drivingInfo: info)
                                    
                                }
                                .padding(.bottom, 5)
                            }
                        }
                    }
                    .foregroundColor(.black)
                }
            }
        }
        .task {
            await drivingInfoViewModel.fetchDrivingInfos(targetYear: String(year), targetMonth: String(month))
        }
        .onChange(of: month) { newMonth in
            Task{
                await drivingInfoViewModel.fetchDrivingInfos(targetYear: String(year), targetMonth: String(newMonth))
            }
        }
        .onChange(of: year) { newYear in
            Task{
                await drivingInfoViewModel.fetchDrivingInfos(targetYear: String(newYear), targetMonth: String(month))
            }
        }
    }
}

//struct DrivingInfoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrivingInfoListView(drivingInfoViewModel: DrivingInfoViewModel())
//    }
//}
