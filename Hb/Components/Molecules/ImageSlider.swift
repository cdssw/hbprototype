//
//  ImageSlider.swift
//  Hb
//
//  Created by 최대완 on 2022/11/23.
//

import SwiftUI

struct ImageSlider: View {
    @State var index = 0
    @State private var page = 0
    @State private var bounce: Bool = false
    
    var images: [File]
    
    var body: some View {
        ImageSliderModifier(index: $index.animation(), maxIndex: images.count - 1) {
            ForEach(self.images, id: \.self) { image in
                let path = Constant.IMAGE_SERVER + image.path + "/" + image.chgFileNm
                AsyncImage(url: URL(string: path)) { img in
                    img.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
            }
        }
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        ImageSlider(images: [File.getDummy(), File.getDummy()])
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
