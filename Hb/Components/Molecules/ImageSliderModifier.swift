//
//  ImageSlider.swift
//  Hb
//
//  Created by 최대완 on 2022/12/06.
//

import SwiftUI

struct ImageSliderModifier<Content: View>: View {
    @Binding var index: Int
    let maxIndex: Int
    let content: () -> Content
    
    @State private var dragging = false
    @GestureState private var dragOffset: CGSize = .zero
    
    init(index: Binding<Int>, maxIndex: Int, @ViewBuilder content: @escaping () -> Content) {
        self._index = index
        self.maxIndex = maxIndex
        self.content = content
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        self.content()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                }
                .content.offset(x: self.offset(in: geometry), y: 0)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // drag가 발생하면 dragging변수를 설정
                            self.dragging = true
                        }
                        .onEnded { value in
                            // end 이벤트가 발생한 가로사이즈 위치를 가져옴
                            let predictedEndOffset = -CGFloat(self.index) * geometry.size.width + value.predictedEndTranslation.width
                            // end 이벤트가 발생한 위치를 기준으로 가로화면을 나눠서 몇번째 인덱스인지 가져옴
                            let predictedIndex = Int(round(predictedEndOffset / -geometry.size.width))
                            // 최종 index를 설정
                            self.index = self.clampedIndex(from: predictedIndex)
                            withAnimation(.easeOut) {
                                self.dragging = false
                            }
                        }
                        .updating($dragOffset) { value, state, transaction in
                            // drag가 변하면 GestureState변수인 dragOffset에 값을 설정
                            state = CGSize(width: -CGFloat(self.index) * geometry.size.width + value.translation.width, height: value.translation.height)
                        }
                )
            }
            .clipped()
            PageControl(index: $index, maxIndex: maxIndex)
        }
    }
    
    // dragging 변수가 set 될때마다 호출됨
    func offset(in geometry: GeometryProxy) -> CGFloat {
        if self.dragging {
            // offset값을 최소 0부터 최대 이미지갯수 * 화면가로사이즈값으로 제한하면서 offset width 값을 리턴
            return max(min(self.dragOffset.width, 0), -CGFloat(self.maxIndex) * geometry.size.width)
        } else {
            // dragging 중이 아닌 경우에는 현재 index기준으로 화면가로사이즈 위치값 리턴
            return -CGFloat(self.index) * geometry.size.width
        }
    }
    
    // 최소 0과 maxIndex 사이의 index를 리턴
    func clampedIndex(from predictedIndex: Int) -> Int {
        let newIndex = min(max(predictedIndex, self.index - 1), self.index + 1)
        guard newIndex >= 0 else { return 0 }
        guard newIndex <= maxIndex else { return maxIndex }
        return newIndex
    }
}

struct PageControl: View {
    @Binding var index: Int
    let maxIndex: Int

    var body: some View {
        HStack {
            Spacer()
            ForEach(0...maxIndex, id: \.self) { index in
                Circle()
                    .fill(index == self.index ? Color.white : Color.white.opacity(0.2))
                    .frame(width: 8, height: 8)
            }
            Spacer()
        }
        .padding(15)
    }
}
