//
//  HeaderView.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/12.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            HStack {
                Menu {
                    Button("삼성동", action: {})
                    Button("병점동", action: {})
                    Button("김량장동", action: {})
                } label: {
                    Label {
                        Text("삼성동")
                            .fontWeight(.bold)
                    } icon: {
                        Image(systemName: "chevron.down")
                            .font(Font.system(.body).bold())
                    }
                    .labelStyle(LabelStyleOnRight())
                    .foregroundColor(Color(0x797979))
                }
                Spacer()
                Image(systemName: "magnifyingglass")
                    .font(Font.system(.body).bold())
                    .foregroundColor(Color(0x797979))
                Image(systemName: "bell")
                    .font(Font.system(.body).bold())
                    .foregroundColor(Color(0x797979))
            }
            .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
            Divider()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
