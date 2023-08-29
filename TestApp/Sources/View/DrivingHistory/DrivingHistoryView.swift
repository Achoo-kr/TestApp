//
//  DrivingHistoryView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import SwiftUI

struct DrivingHistoryView: View {
    @State private var selectedNum: Int = 0
    let options = ["다운로드","저장된 파일"]
    var body: some View {
        
        VStack {
            CustomSegmentedControl(preselectedIndex: $selectedNum, options: options)
            
            if selectedNum == 0 {
                DownloadHistoryView()
            } else if selectedNum == 1 {
                DownloadedHistoryView()
            }
            
            Spacer()
        }
    }
}

struct DrivingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingHistoryView()
    }
}
