//
//  DisclosureGroupStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct DisclosureGroupStyleView: View {

    @State private var isExpanded = false
    @State private var disable = false

    var body: some View {
        VStack(spacing: 24) {
            VStack {
                Toggle("Disable", isOn: $disable)
                Divider()
            }

            DisclosureGroup("very important info", isExpanded: $isExpanded) {
                Text("don't believe whatever this guy is saying he has not idea what he is talking about.")
            }
            .disclosureGroupStyle(.prominent)
            .disabled(disable)

            Spacer()
        }
        .padding()
        .frame(width: 402, height: 350)
    }
}

extension DisclosureGroupStyle where Self == ProminentDisclosureGroupStyle {
    static var prominent: ProminentDisclosureGroupStyle { ProminentDisclosureGroupStyle() }
}

struct ProminentDisclosureGroupStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation(.snappy) {
                configuration.isExpanded.toggle()
            }
        } label: {
            VStack(spacing: 12) {
                HStack {
                    configuration.label
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: "arrow.down.circle.fill")
                        .rotationEffect(.degrees(configuration.isExpanded ? 180 : 0))
                }

                if configuration.isExpanded {
                    Capsule()
                        .fill(.gray)
                        .frame(height: 2)
                    configuration.content
                }
            }
        }
        .buttonStyle(DisclosureGroupButtonStyle())
    }
}

struct DisclosureGroupButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
        }
        .saturation(isEnabled ? 1.0 : 0.0)
        .padding(.vertical, 21)
        .padding(.horizontal, 16)
        .contentShape(.buttonBorder)
        .background(.black.gradient)
        .foregroundStyle(
            Color(
                hue: 0,
                saturation: 0.0,
                brightness: isEnabled ? 1.0 : 0.5
            )
        )
        .font(.body.weight(.semibold))
        .fontDesign(.rounded)
        .clipShape(.rect(cornerRadius: 21))
        .scaleEffect(configuration.isPressed ? 0.97 : 1)
        .animation(
            .easeOut(duration: 0.2).delay(configuration.isPressed ? 0 : 0.05),
            value: configuration.isPressed
        )
        .saturation(isEnabled ? 1 : 0)
        .animation(.easeInOut(duration: 0.2), value: isEnabled)
    }
}
#Preview {
    DisclosureGroupStyleView()
}
