//
//  DrivingHistoryView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import SwiftUI

struct DrivingHistoryView: View {
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    var body: some View {
        VStack {
            HStack(alignment: .bottom){
                Text("운행기록 전송")
                    .font(.title2)
                    .bold()
                Spacer()
                //TODO: filter
            }
            .padding()
            Spacer()
            LazyVStack{
                ForEach(drivingInfoViewModel.drivingInfosAll) { info in
                    Text("\(info.date) 운행기록")
                }
            }
            Spacer()
            SendEmailView(drivingInfo: DrivingInfo(id: "", date: "", purpose: "", totalDistance: 0, startAddress: "", startTime: "", endAddress: "", endTime: "", fuelFee: 0, tollFee: 0, depreciation: 0))
        }
        .task {
            drivingInfoViewModel.drivingInfosAll
        }

    }
}

struct DrivingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingHistoryView(drivingInfoViewModel: DrivingInfoViewModel())
    }
}
