//
//  SelectionBlockView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/19.
//

import SwiftUI

struct SelectionBlockView: View {
    @Binding var selectedMonth: Int
    @Binding var selectedYear: Int
    let currentYear = Calendar.current.component(.year, from: Date())
    let currentMonth = Calendar.current.component(.month, from: Date())
    @State private var showDatePicker = false
    let totalTrip: Int
    let totalKM: Int
    let totalFee: Int
    
    let formatter = NumberFormatter()

    var body: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .cornerRadius(16)
                .foregroundColor(.representColor)
            
            HStack {
                Spacer()
                VStack {
                    Text(formatter.string(from: NSNumber(value: selectedYear)) ?? "")
                        .foregroundColor(.white)
                        .padding(.bottom, 1)
                    HStack {
                        Button {
                            if selectedMonth > 1 {
                                selectedMonth -= 1
                            }
                        } label: {
                            Image(systemName: "arrowtriangle.left.fill")
                                .foregroundColor(.lightGray)
                                .frame(width: 8)
                        }
                        
                        Button {
                            showDatePicker = true
                        } label: {
                            Text("\(selectedMonth)월")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 8)
                        
                        Button {
                            if selectedMonth < 12 {
                                selectedMonth += 1
                            }
                        } label: {
                            Image(systemName: "arrowtriangle.right.fill")
                                .foregroundColor(.lightGray)
                                .frame(width: 8)
                        }
                    }
                }
                Spacer()
                Rectangle()
                    .frame(width: 1, height: 60)
                    .foregroundColor(.gray)
                    .padding(.leading)
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text("운행기록")
                        Text("운행거리")
                        Text("총 비용")
                    }
                    .foregroundColor(.lightGray)
                    .padding(.trailing)
                    VStack(alignment: .leading) {
                        Text("\(totalTrip)")
                        Text("\(totalKM)")
                        Text("\(totalFee)")
                    }.foregroundColor(.white)
                }
                .padding(.leading, 8)
                Spacer()
            }
        }
        .frame(height: 100)
        .padding()
        .sheet(isPresented: $showDatePicker) {
            VStack{
                CustomDatePicker(selectedMonth: $selectedMonth, selectedYear: $selectedYear)

                    Button {
                        showDatePicker = false
                    } label: {
                        Text("닫기")
                    }

            }
            .presentationDetents([
                .fraction(0.2), // 임의 비율
            ])
            // DragIndicatior 비활성화
            .presentationDragIndicator(.hidden)
            // 인터랙션 비활성화
            .interactiveDismissDisabled()
        }
    }
}

struct SelectionBlockView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionBlockView(selectedMonth: Binding.constant(10), selectedYear: Binding.constant(2023), totalTrip: 10, totalKM: 2000,totalFee: 15000)
    }
}


struct CustomDatePicker: View {
    @Binding var selectedMonth: Int
    @Binding var selectedYear: Int
    
    let currentYear = Calendar.current.component(.year, from: Date())
    
    var body: some View {
        HStack {
            Picker("Year", selection: $selectedYear) {
                ForEach(currentYear - 10..<currentYear + 1) { year in
                    Text(String(year)).tag(year)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Picker("Month", selection: $selectedMonth) {
                ForEach(1..<13) { month in
                    Text(String(month)).tag(month)
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
        
    }
}
