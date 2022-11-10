//
//  CustomTextFieldStyle.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/06.
//

import SwiftUI

struct HbTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.callout)
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color(0xBDBDBD), lineWidth: 1))
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
        
    }
}

struct CustomTextFieldStyle: View {
    @State private var text = ""
    var body: some View {
        TextField("", text: $text)
            .textFieldStyle(HbTextFieldStyle())
    }
}

struct CustomTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldStyle()
    }
}
