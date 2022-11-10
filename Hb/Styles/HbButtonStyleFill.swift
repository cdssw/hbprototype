//
//  DefaultButtonStyle.swift
//  Hb
//
//  Created by DaeWan Choi on 2022/03/05.
//

import SwiftUI

extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}

struct HbButtonStyleFill: ButtonStyle {
    var bgColor: Color = Color(0x000000)
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 60)
            .font(.headline)
            .foregroundColor(Color(0xFFFFFF))
            .background(configuration.isPressed ? Color.gray : bgColor)
            .cornerRadius(6.0)
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
    }
}

struct HbButtonStyleOutline: ButtonStyle {
    var fgColor: Color = Color(0x797979)
    var pressColor: Color = Color(0xAFAFAF)
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 60)
            .font(.headline)
            .foregroundColor(configuration.isPressed ? pressColor : fgColor)
            .background(Color(0xFFFFFF))
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
            .cornerRadius(6.0)
            .overlay {
                RoundedRectangle(cornerRadius: 6.0)
                    .stroke(configuration.isPressed ? pressColor : fgColor)
                    .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
            }
    }
}

struct Hb2ButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 60)
            .font(.headline)
            .foregroundColor(Color(0xFFFFFF))
            .background(configuration.isPressed ? Color.gray : Color(0x079FFE))
            .cornerRadius(6.0)
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
    }
}

struct CustomButtonStyle: View {
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.showingAlert = true
            }) {
                Text("Button")
            }
            .alert(isPresented: $showingAlert) {
                //Alert(title: Text("Title"), message: Text("This is a Alert"), dismissButton: .default(Text("OK")))
                Alert(title: Text("Title"), message: Text("This is a Alert"), primaryButton: .destructive(Text("OK")), secondaryButton: .cancel())
            }
            .buttonStyle(HbButtonStyleFill())
            
            Button(action: {
                self.showingAlert = true
            }) {
                Text("Button")
            }
            .alert(isPresented: $showingAlert) {
                //Alert(title: Text("Title"), message: Text("This is a Alert"), dismissButton: .default(Text("OK")))
                Alert(title: Text("Title"), message: Text("This is a Alert"), primaryButton: .destructive(Text("OK")), secondaryButton: .cancel())
            }
            .buttonStyle(Hb2ButtonStyle())
            
            Button(action: {
                
            }) {
                Text("Button")
            }
            .buttonStyle(HbButtonStyleFill())
            
            Button(action: {
                
            }) {
                Text("Button")
            }
            .buttonStyle(HbButtonStyleOutline())
        }
    }
}

struct CustomButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonStyle()
    }
}
