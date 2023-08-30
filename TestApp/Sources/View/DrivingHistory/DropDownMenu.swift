//
//  DropDownMenu.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import SwiftUI

struct DropDownMenu: View {
    let menus: [String]
    @Binding var selection: String
    @State var isSelecting: Bool = false
    var body: some View {
        Menu {
            ForEach(self.menus, id: \.self) { string in
                Button(string) {
                    selection = string
                    isSelecting = true
                }
            }
        } label: {
            HStack{
                if selection == "" {
                    Text("미선택")
                }else{
                    Text("\(selection)")
                }
                Spacer()
                Image("DropDownImage")
                .rotationEffect(.degrees( isSelecting ? -180 : 0))
            }
            .foregroundColor(.primary)
        }
        .onTapGesture {
            isSelecting = false
        }
    }
}

struct DropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropDownMenu(menus: ["출장", "출퇴근", "몰라"], selection: Binding.constant("출장"))
    }
}
