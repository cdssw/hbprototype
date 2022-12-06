//
//  ImageSlider.swift
//  Hb
//
//  Created by 최대완 on 2022/11/23.
//

import SwiftUI

struct ImageSlider: View {
    @State var index = 0
    private let images = [Constant.IMAGE_SERVER + "avatar/2022-11-23/b74fd2f1-d7fe-409b-92af-67f9fa94c688.jpg", Constant.IMAGE_SERVER + "avatar/2022-11-23/b74fd2f1-d7fe-409b-92af-67f9fa94c688.jpg"]
    
    @State private var page = 0
    @State private var bounce: Bool = false
    
    var body: some View {
        ImageSliderModifier(index: $index.animation(), maxIndex: images.count - 1) {
            ForEach(self.images, id: \.self) { image in
                AsyncImage(url: URL(string: image)) { img in
                    img.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Text("")
                }
            }
        }
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        ImageSlider()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
