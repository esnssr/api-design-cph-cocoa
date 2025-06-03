//
//  ToggleStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI
struct ToggleStyleView: View {
    
    @State private var isOn = true

    var body: some View {
        VStack {
            Toggle("Binary Toggle", isOn: $isOn)
                .toggleStyle(.binary)

            Toggle("Normal Toggle", isOn: $isOn)
        }
        .padding()
    }
}

extension ToggleStyle where Self == BinaryToggleStyle {
    static var binary: BinaryToggleStyle { BinaryToggleStyle() }
}

struct BinaryToggleStyle: ToggleStyle {

    // we can use this value to control the label's visibility
    @Environment(\.labelsVisibility) var labelsVisibility

    func makeBody(configuration: Configuration) -> some View {
        // my initial idea was to recreate the same native toggle look,
        // but wit the knob having the binary text.
        // i didn't have time to do that :)
        HStack {
            configuration.label
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack {
                Text(configuration.isOn ? 1 : 0, format: .number)
                    .font(.body.weight(.semibold))
                    .monospaced()
                    .monospacedDigit()
                    .foregroundStyle(configuration.isOn ? .green : .red)
            }
            .padding(12)
            .background(.fill.quaternary, in: .circle)
            .contentTransition(.numericText())
            .animation(.smooth, value: configuration.isOn)
            .onTapGesture {
                configuration.isOn.toggle()
            }
            .frame(width: 44, height: 44)
        }
    }
}
#Preview {
    ToggleStyleView()
}
