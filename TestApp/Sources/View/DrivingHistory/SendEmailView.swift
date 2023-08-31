//
//  SendEmailView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/31.
//

import SwiftUI
import MessageUI

struct SendEmailView: View {
    @State private var isShowingMailView = false
    @State private var isShowingAlert = false
    let drivingInfo: DrivingInfo
    
    var body: some View {
        VStack {
            Button("Send Email") {
                if MFMailComposeViewController.canSendMail() {
                    self.isShowingMailView.toggle()
                } else {
                    self.isShowingAlert.toggle()
                }
            }
            .sheet(isPresented: $isShowingMailView) {
                MailView(drivingInfo: drivingInfo, result: self.$isShowingMailView)
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Cannot Send Email"), message: Text("Your device could not send e-mail. Please check e-mail configuration and try again."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct SendEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SendEmailView(drivingInfo: DrivingInfo(id: "", date: "", purpose: "", totalDistance: 0, startAddress: "", startTime: "", endAddress: "", endTime: "", fuelFee: 0, tollFee: 0, depreciation: 0))
    }
}
