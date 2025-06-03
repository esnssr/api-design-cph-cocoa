//
//  TextFieldStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct TextFieldStyleView: View {

    @State private var name: String = ""
    @State private var disable = false

    var body: some View {
        VStack(spacing: 16) {
            TextField("Enter your name (or not idc 😒)", text: $name)
                .textFieldStyle(.form)
                .padding()
                .disabled(disable)
                .foregroundStyle(.background.tertiary)

            Toggle("Disable", isOn: $disable)
        }
        .padding()
    }
}

extension TextFieldStyle where Self == FormTextFieldStyle {
    static var form: FormTextFieldStyle { FormTextFieldStyle() }
}

struct FormTextFieldStyle: TextFieldStyle {

    // we use AnyView to erase the view type
    // and return "any view" we want in the body
    typealias _Body = AnyView

    @Environment(\.isEnabled) var isEnabled

    /*
     even though TextFieldStyle doesn't expose any public
     APIs or interface (check the protocol), conformance to it
     gives us this _body builder method to work with. it also gives us access
     to the configuration, which in this case is not like the
     other styles configuration? very weird but okaaay? 🤷🏼‍♂️
     */
    func _body(configuration: TextField<_Label>) -> AnyView {
        return AnyView(
            HStack {
                Image(
                    systemName: isEnabled
                    ? "checkmark.circle.fill"
                    : "questionmark.circle.fill"
                )
                .foregroundStyle(.green)
                .animation(.easeInOut(duration: 0.1), value: isEnabled)

                /*
                 body is basically the rendered SwiftUI text field,
                 so we can just use that and add our style around it :)
                 */
                configuration.body
                    .fontDesign(.rounded)
                    .foregroundStyle(isEnabled ? .primary : Color.gray)
            }
                .padding()
                .background(.fill.quaternary, in: .rect(cornerRadius: 16))
                .overlay {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(.gray, lineWidth: 0.5)
                }
                .saturation(isEnabled ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.1), value: isEnabled)
        )
    }
}

#Preview {
    TextFieldStyleView()
}
