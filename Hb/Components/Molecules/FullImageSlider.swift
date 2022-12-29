//
//  FullImageSlider.swift
//  Hb
//
//  Created by 최대완 on 2022/12/22.
//

import SwiftUI

struct FullImageSlider: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var fileViewModel: FileViewModel
    @State var currentAmount: CGFloat = 0
    @State private var page = 0
    @State var offset: CGFloat = 0
    
    @State private var scale: CGFloat = 0
    @State private var lastScale: CGFloat = 1
    @State private var zoomOffset: CGSize = .zero
    @State private var zooming: Bool = false
    
    var body: some View {
        ZStack {
            TabView(selection: $page) {
                ForEach(0..<fileViewModel.fileList.count, id: \.self) { index in
                    let path = Constant.IMAGE_SERVER + fileViewModel.fileList[index].path + "/" + fileViewModel.fileList[index].chgFileNm
                    AsyncImage(url: URL(string: path)) { img in
                        img.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Color.black
                    }
                    .tag(index)
                    .scaleEffect(scale + lastScale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                self.zooming = true
                                scale = value - 1
                            }
                            .onEnded { value in
                                self.zooming = false
                                if value < 1 {
                                    withAnimation(.spring()) {
                                        scale = 0
                                        lastScale = 1
                                    }
                                } else {
                                    lastScale += scale
                                    scale = 0
                                }
                            }
                    )
                    .overlay(
                        GeometryReader { proxy -> Color in
                            let minX = proxy.frame(in: .global).minX
                            DispatchQueue.main.async {
                                withAnimation(.default) {
                                    self.offset = -minX
                                }
                            }
                            return Color.clear
                        }
                            .frame(width: 0, height: 0)
                        , alignment: .leading
                    )
                }
            }
            .onChange(of: page, perform: { newValue in
                withAnimation(.spring()) {
                    scale = 0
                    lastScale = 1
                }
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
            .background(Color.black)
            .overlay(
                // 움직이는 index현재 위치를 잡아서 indicator를 표시한다.
                VStack {
                    Spacer()
                    HStack(spacing: 8) {
                        ForEach(0..<fileViewModel.fileList.count, id:\.self) { index in
                            ZStack {
                                Capsule()
                                    .foregroundColor(getCurrentPageIndex() == index ? .white : .gray.opacity(0.3))
                                    .frame(width: 8, height: 8)
                            }
                        }
                    }
                }
            )
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(20)
                    }
                }
                Spacer()
            }
            .offset(zoomOffset)
            .onChange(of: scale) { newValue in
                if zooming {
                    withAnimation(.spring()) {
                        zoomOffset = CGSize(width: 0, height: -300)
                    }
                } else {
                    withAnimation(.spring()) {
                        zoomOffset = .zero
                    }
                }
            }
        }
    }
    
    func getCurrentPageIndex() -> Int {
        let index = Int(round(Double(offset / getScreenWidth())))
        return index
    }
}

extension View {
    func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
}

struct FullImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        FullImageSlider(fileViewModel: FileViewModel())
    }
}
