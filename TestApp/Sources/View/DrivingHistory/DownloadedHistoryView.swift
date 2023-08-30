//
//  DownloadedHistoryView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import SwiftUI

struct DownloadedHistoryView: View {
    var body: some View {
        VStack{
            DownloadedHistoryRow()
            DownloadedHistoryRow()
            DownloadedHistoryRow()
        }
        
        CustomButton {
            //
        } content: {
            Text("전송")
        }
    }
}

struct DownloadedHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadedHistoryView()
    }
}
