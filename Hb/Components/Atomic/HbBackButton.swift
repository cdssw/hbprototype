//
//  HbBackButton.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/11.
//

import SwiftUI

struct HbBackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   
    var imageYn: Bool = false
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.backward")
                .foregroundColor(imageYn ? .white : Color(0x797979))
        })
    }
}
