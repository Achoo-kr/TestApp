//
//  CustomSegmentedControl.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/29.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var preselectedIndex: Int
    var options: [String]
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                let isSelected = preselectedIndex == index
                VStack{
                    Text(options[index])
                        .fontWeight(isSelected ? .bold : .regular)
                        .foregroundColor(isSelected ? .representColor : .gray)
                    
                    Rectangle()
                        .frame(height: isSelected ? 4 : 2)
                        .foregroundColor(isSelected ? .representColor : .gray)
                }
                .onTapGesture {
                    preselectedIndex = index
                }
            }
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

struct CustomSegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        CustomSegmentedControl(preselectedIndex: Binding.constant(0), options: ["다운로드", "저장된 파일"])
    }
}
