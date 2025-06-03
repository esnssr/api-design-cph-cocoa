//
//  ButtonStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct ButtonStyleView: View {

    @State private var disabled = false

    var body: some View {
        VStack(spacing: 24) {
            Button("Pew Pew") {
                debugPrint("pew pew")
            }
            .buttonStyle(.primary)
            .disabled(disabled)

            Button("Beep Boop") {
                debugPrint("beep boop")
            }
            .buttonStyle(.primitivePrimary)
            .disabled(disabled)

            VStack {
                Divider()

                Toggle("Disable", isOn: $disabled)
            }
        }
        .padding()
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle { PrimaryButtonStyle() }
}

public struct PrimaryButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        /*
         with composable styles, we can extract some of the styling here
         into different styling modifiers
         */
        HStack {
            Spacer()
            configuration.label
            Spacer()
        }
        .saturation(isEnabled ? 1.0 : 0.0)
        .padding(.vertical, 21)
        .contentShape(.buttonBorder)
        .background(
            // Because black and white can't have different saturation values,
            // we fall back to gray-ish colors when the button is disabled
            Color(
                hue: 0,
                saturation: 0,
                brightness: isEnabled ? 0 : 0.3
            ).gradient
        )
        .foregroundStyle(
            // same here 👆🏼
            Color(
                hue: 0,
                saturation: 0.0,
                brightness: isEnabled ? 1.0 : 0.5
            )
        )
        .font(.body.weight(.semibold))
        .fontDesign(.rounded)
        .clipShape(.rect(cornerRadius: 21))
        .shadow(color: .black.opacity(isEnabled ? 0.2 : 0.0), radius: 8)
        .scaleEffect(configuration.isPressed ? 0.97 : 1)
        .animation(
            .easeOut(duration: 0.2).delay(configuration.isPressed ? 0 : 0.05),
            value: configuration.isPressed
        )
        .saturation(isEnabled ? 1 : 0)
        .animation(.easeInOut(duration: 0.2), value: isEnabled)
    }
}

public extension PrimitiveButtonStyle where Self == PrimaryPrimitiveButtonStyle {
    static var primitivePrimary: PrimaryPrimitiveButtonStyle { PrimaryPrimitiveButtonStyle() }
}

public struct PrimaryPrimitiveButtonStyle: PrimitiveButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        /*
         PrimitiveButtonStyle gives us different properties
         to work with. unlike ButtonStyle, it doesn't give us
         the `isPressed` state 😔
         so we can't do any interactions with it.
         */
        Button {
            configuration.trigger()
        } label: {
            configuration.label
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
        }
        .buttonStyle(.borderedProminent)
        .tint(.black)
        .font(.body.weight(.semibold))
        .fontDesign(.rounded)
        .controlSize(.large)
        .buttonBorderShape(.roundedRectangle(radius: 21))
        .animation(.easeInOut(duration: 0.1), value: isEnabled)
    }
}

#Preview {
    ButtonStyleView()
}
