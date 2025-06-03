//
//  MenuStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct MenuStyleView: View {

    @State private var animateBounce = false

    @State private var selectedColor: Color = .red
    let colors: [Color] = [
        .red,
        .orange,
        .yellow,
        .green,
        .mint,
        .teal,
        .cyan,
        .blue,
        .indigo
    ]

    var body: some View {
        VStack(spacing: 20) {
            Menu {
                ForEach(colors, id: \.self) { color in
                    Button {
                        selectedColor = color
                    } label: {
                        Label {
                            Text(String(String(describing: color)).capitalized)
                        } icon: {
                            Image(systemName: color == selectedColor ? "circle.dashed.inset.fill" : "circle.fill")
                                .foregroundStyle(color, .primary, .secondary)
                        }
                    }
                }
            } label: {
                Label {
                    Text("Color")
                } icon: {
                    Image(systemName: "circle.dashed.inset.fill")
                        .foregroundStyle(selectedColor, .primary, .secondary)
                }
            }
            .menuStyle(.borderedProminent)
            .animation(.default.delay(0.05), value: selectedColor)
            .scaleEffect(animateBounce ? 1.04 : 1.0)
            .animation(.smooth.delay(0.05), value: animateBounce)
        }
        .padding()
        .onChange(of: selectedColor) { _, _ in
            // we _could_ abstract all this logic into its own
            // modifier where we can animate on a value change,
            // but i am too lazy to do it :)
            // but hey! maybe you could do that, free country, who am i to judge? 🤷🏼‍♂️
            withAnimation(completionCriteria: .logicallyComplete) {
                animateBounce = true
            } completion: {
                animateBounce = false
            }
        }
    }
}



// MARK: - BorderedProminentMenuStyle
extension MenuStyle where Self == BorderedProminentMenuStyle {
    static var borderedProminent: BorderedProminentMenuStyle { BorderedProminentMenuStyle() }
}

public struct BorderedProminentMenuStyle: MenuStyle {
    public func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .buttonStyle(MenuButtonStyle())
    }
}

// MARK: - MenuButtonStyle
struct MenuButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(.fill.secondary)
            .clipShape(.capsule)
            .font(.title2.weight(.medium))
            .fontDesign(.rounded)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(
                .easeOut(duration: 0.2).delay(configuration.isPressed ? 0 : 0.05),
                value: configuration.isPressed
            )
            .saturation(isEnabled ? 1 : 0)
            .opacity(isEnabled ? 1 : 0.4)
    }
}

#Preview {
    MenuStyleView()
}
