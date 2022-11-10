//
//  JoinStep1View.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/11.
//

import SwiftUI

struct JoinStep1View: View {
    @State private var checkedAll: Bool = false
    @State private var checked1: Bool = false // 서비스약관
    @State private var checked2: Bool = false // 개인정보
    @State private var checked3: Bool = false // 추가정보
    @State private var disabled: Bool = true
    
    var body: some View {
        VStack {
            Spacer().frame(height: 100)
            HStack {
                Text("서비스\n이용약관에 동의해주세요.")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(0x797979))
                    .padding(25)
                Spacer()
            }
            HStack {
                Button(action: {
                    self.checkedAll.toggle()
                    if self.checkedAll {
                        self.checked1 = true
                        self.checked2 = true
                        self.checked3 = true
                    } else {
                        self.checked1 = false
                        self.checked2 = false
                        self.checked3 = false
                    }
                    self.disabled = self.checked1 && self.checked2 ? false : true
                }, label: {
                    HStack {
                        Image(systemName: checkedAll ? "checkmark.square.fill" : "square")
                            .resizable()
                            .foregroundColor(Color(0xFF2D55))
                            .frame(width: 20, height: 20)
                        Text("모두 동의합니다.")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(0x797979))
                    }
                })
                    .buttonStyle(PlainButtonStyle())
                
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 5, trailing: 25))
            HStack {
                Spacer().frame(width: 35)
                Text("전체동의는 필수 및 선택 정보에 대한 동의도 포함되어 있으며, 개별적으로도 동의를 선택하실 수 있습니다.\n선택항목에 대한 동의를 거부하시는 경우에도 서비스 이용이 가능합니다.")
                    .font(.caption)
                    .foregroundColor(Color(0x797979))
                Spacer().frame(width: 16)
            }
            .padding(.bottom, 10)
            Rectangle()
                .frame(width: .infinity, height: 1)
                .foregroundColor(Color(0xAFAFAF))
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 16))
            Group {
                HStack {
                    Button(action: {
                        self.checked1.toggle()
                        self.disabled = self.checked1 && self.checked2 ? false : true
                    }, label: {
                        HStack {
                            Image(systemName: checked1 ? "checkmark.square.fill" : "square")
                                .resizable()
                                .foregroundColor(Color(0x797979))
                                .frame(width: 20, height: 20)
                            Text("[필수] 서비스 약관")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color(0x797979))
                        }
                    })
                        .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundColor(Color(0x797979))
                }
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 10, trailing: 25))
                HStack {
                    Button(action: {
                        self.checked2.toggle()
                        self.disabled = self.checked1 && self.checked2 ? false : true
                    }, label: {
                        HStack {
                            Image(systemName: checked2 ? "checkmark.square.fill" : "square")
                                .resizable()
                                .foregroundColor(Color(0x797979))
                                .frame(width: 20, height: 20)
                            Text("[필수] 개인정보 수집 및 이용 동의")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color(0x797979))
                        }
                    })
                        .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundColor(Color(0x797979))
                }
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 10, trailing: 25))
                HStack {
                    Button(action: {
                        self.checked3.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: checked3 ? "checkmark.square.fill" : "square")
                                .resizable()
                                .foregroundColor(Color(0x797979))
                                .frame(width: 20, height: 20)
                            Text("[선택] 추가 정보 수집")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color(0x797979))
                        }
                    })
                        .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundColor(Color(0x797979))
                }
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
            }
            Spacer()
            Button(action: {
            }, label: {
                NavigationLink(destination: JoinStep2View()) {
                    Text("동의")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, minHeight: 60)
                }
            })
                .buttonStyle(disabled ? HbButtonStyleFill(bgColor: Color.gray) : HbButtonStyleFill())
                .disabled(disabled)
            
            Spacer().frame(height: 100)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: HbBackButton())
        .navigationBarTitle("회원가입")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct JoinStep1View_Previews: PreviewProvider {
    static var previews: some View {
        JoinStep1View()
    }
}
