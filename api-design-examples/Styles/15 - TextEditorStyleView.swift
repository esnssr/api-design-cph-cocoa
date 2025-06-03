//
//  TextEditorStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct TextEditorStyleView: View {
    
    @State private var text = "Here are 10 things you can do TODAY to turn your pee color into Hulk-Green...🧪 (And why everyone should do it)"

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextEditor(text: $text)
                .padding()
                .textEditorStyle(.notepad)
        }
        .padding()
    }
}


extension TextEditorStyle where Self == NotepadTextEditorStyle {
    static var notepad: NotepadTextEditorStyle { NotepadTextEditorStyle() }
}

struct NotepadTextEditorStyle: TextEditorStyle {

    // if you don't know why we are using AnyView, then i am very disappointed in you 😒
    typealias Body = AnyView

    func makeBody(configuration: Configuration) -> AnyView {

        /*
         TL;DR: even though TextEditorStyle gives us a public API like other styles,
         TextEditorStyleConfiguration doesn't have any properties.
         */


        /*
         this doesn't mean we shouldn't try to build our own style though :)

         Note: the following purely for fun (and out of boredom/curiosity)
         even though it is not directly related to the API design part, it does
         show us some interesting parts of Apple's internal API design.
         also, if you are not gonna expose your object's properties, maybe hide the object all together?
         so that silly people like me don't end up playing with it 😝

         if we inspect the configuration value, we get the following 👇🏼

         ▿ TextEditorStyleConfiguration
            ▿ text : Binding<String> // 👈🏼 well well well, look what we have here 👀
                ▿ transaction : Transaction
                    ▿ plist : []
                        - elements : nil
                ▿ location : <LocationBox<ScopedLocation>: 0x600000c06280>
                - _value : "beep boop"
            - selection : nil

         */

        // we can use reflection to get the text's binding value, and build a text editor to our style
        let mirror = Mirror(reflecting: configuration)
        var bindingValue: Binding<String>?
        for child in mirror.children {
            if let textValue = child.value as? Binding<String> {
                bindingValue = textValue
            }
        }

        if let bindingValue {
            return AnyView(
                TextEditor(text: bindingValue)
                    .scrollContentBackground(.hidden)
                    .lineSpacing(6)
                    .font(.body.weight(.medium))
                    .fontDesign(.serif)
                    .padding()
                    .background {
                        Rectangle()
                            .fill(.white)
                            .colorEffect(
                                // a shader, because we are classy like that
                                // also, why the hell not?
                                ShaderLibrary.randomNoise(
                                    .float(20)
                                )
                            )
                            .opacity(0.1)
                    }
                    .background {
                        Rectangle()
                            .fill(Color(hex: "FFF2D2").opacity(0.5))
                            .overlay {
                                VStack(spacing: 28) {
                                    ForEach(0...100, id: \.self) { _ in
                                        Divider()
                                    }
                                }
                            }
                    }
                    .clipShape(.rect(cornerRadius: 24))
                    .overlay {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(
                                Color(hex: "C8812F"),
                                style: .init(
                                    lineWidth: 4,
                                    lineCap: .round,
                                    lineJoin: .round,
                                    dash: [10, 10],
                                    dashPhase: 8
                                ),
                                antialiased: true
                            )
                    }
            )
        } else {
            return AnyView(
                Text("no binding value")
            )
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#") // skip #

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    TextEditorStyleView()
}
