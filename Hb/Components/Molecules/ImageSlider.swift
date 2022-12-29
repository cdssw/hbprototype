//
//  ImageSlider.swift
//  Hb
//
//  Created by 최대완 on 2022/11/23.
//

import SwiftUI

struct ImageSlider: View {
    @State var index = 0
    @ObservedObject var fileViewModel: FileViewModel
    
    var body: some View {
        ImageSliderModifier(index: $index.animation(), maxIndex: fileViewModel.fileList.count - 1) {
            ForEach(fileViewModel.fileList, id: \.self) { image in
                let path = Constant.IMAGE_SERVER + image.path + "/" + image.chgFileNm
                AsyncImage(url: URL(string: path)) { img in
                    img.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
            }
        }
        .animation(.default, value: UUID())
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        ImageSlider(fileViewModel: FileViewModel())
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
