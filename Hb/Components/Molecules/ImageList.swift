//
//  ImageList.swift
//  Hb
//
//  Created by 최대완 on 2022/11/23.
//

import SwiftUI

struct ImageList: View {
    var body: some View {
        NavigationView {
            List {
                ImageSlider()
                    .frame(height: 300)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .navigationBarTitle("Image Slider", displayMode: .large)
            }
        }
    }
}

struct ImageList_Previews: PreviewProvider {
    static var previews: some View {
        ImageList()
    }
}
