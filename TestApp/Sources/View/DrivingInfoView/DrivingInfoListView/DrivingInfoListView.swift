//
//  DrivingInfoListView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/29.
//

import SwiftUI

struct DrivingInfoListView: View {
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
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
                SelectionBlockView()
                    .padding(.bottom, 5)
                ScrollView {
                    ForEach(drivingInfoViewModel.drivingInfos) { info in
                        
                        NavigationLink {
                            DrivingInfoView(drivingInfoViewModel: drivingInfoViewModel, drivingInfo: info)
                        } label: {
                            CardView(drivingInfoViewModel: drivingInfoViewModel, drivingInfo: info)
                            
                        }
                        .padding(.bottom, 5)
                    }
                }
                .foregroundColor(.black)
            }
        }
        .task {
            await drivingInfoViewModel.fetchDrivingInfos()
        }
    }
}

//struct DrivingInfoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrivingInfoListView(drivingInfoViewModel: DrivingInfoViewModel())
//    }
//}
