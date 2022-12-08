//
//  CardView.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/04/05.
//

import SwiftUI

struct CardView: View {
    var meet: Meet
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .strokeBorder(Color(0xCBCBCB), lineWidth: 1)
            .frame(height: 130)
            .overlay(
                HStack(spacing: 0) {
                    if let img = meet.img {
                        AsyncImage(url: URL(string: img),
                                   transaction: .init(animation: .linear),
                                   content: view)
                        .frame(width: 123, height: 110)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .background(Color(0xD3D3D3))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        Text(meet.title)
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(Color(0x5B5656))
                        Text(meet.address.sgg)
                            .font(.caption)
                            .foregroundColor(Color(0x797979))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        HStack(spacing: 3) {
                            Image("watch")
                            Text("\(meet.term.startTm)~\(meet.term.endTm)")
                                .font(.caption)
                                .foregroundColor(Color(0x797979))
                            Text(Helper.util.decodeDetailDay(detailDay: meet.term.detailDay))
                                .font(.caption)
                                .foregroundColor(Color(0x00AF31))
                        }
                        HStack {
                            Text("￦ \(meet.cost)")
                                .font(.subheadline)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                .foregroundColor(Color(0x00AF31))
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(0x007728), lineWidth: 1)
                                        .frame(height: 26)
                                )
                            Spacer()
                            HStack(spacing: 3) {
                                Image("chat")
                                Text("\(meet.chatCnt)")
                                    .font(.subheadline)
                                    .foregroundColor(Color(0x797979))
                            }
                            HStack(spacing: 3) {
                                Image("add_account")
                                Text("\(meet.recruitment)")
                                    .font(.subheadline)
                                    .foregroundColor(Color(0x797979))
                            }
                        }
                        .padding(.trailing, 10)
                    }
                    .padding(.leading, 10)
                }
            )
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
    
    @ViewBuilder
        private func view(for phase: AsyncImagePhase) -> some View {
            switch phase {
            case .empty:
                Color.gray
                    .animation(.default)
            case .success(let image):
                image
                    .resizable()
            case .failure(let error):
                VStack(spacing: 16) {
                    Image(systemName: "xmark.octagon.fill")
                        .foregroundColor(.red)
                    Text(error.localizedDescription)
                        .multilineTextAlignment(.center)
                }
            @unknown default:
                Text("Unknown")
                    .foregroundColor(.gray)
            }
        }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(meet: Meet.getDummy())
    }
}
