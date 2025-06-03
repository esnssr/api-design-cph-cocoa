//
//  RelationalFormatStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct RelationalFormatStyleView: View {

    @State private var value: Int = 50
    private let compareValue: Int = 40
    
    var body: some View {
        VStack(spacing: 20) {

            Text(value, format: .relational(compareValue))
                .monospaced()
                .font(.title.weight(.semibold))
                .fontDesign(.monospaced)
                .contentTransition(.numericText())
                .animation(.smooth, value: value)

            ControlGroup {
                Button {
                    value -= 1
                } label: {
                    Label("decrease", systemImage: "minus.circle.fill")
                }

                Button {
                    value += 1
                } label: {
                    Label("increase", systemImage: "plus.circle.fill")
                }
            }
            .buttonRepeatBehavior(.enabled)
            .controlGroupStyle(.coolio)
        }
        .padding()
    }
}

extension FormatStyle where Self == RelationalFormatStyle<IntegerFormatStyle<Int>> {
    static func relational(_ relationValue: Int) -> RelationalFormatStyle<IntegerFormatStyle<Int>> {
        RelationalFormatStyle(baseFormat: .number, relationalValue: relationValue)
    }

    static func relational(_ relationValue: Double) -> RelationalFormatStyle<IntegerFormatStyle<Int>> {
        RelationalFormatStyle(baseFormat: .number, relationalValue: Int(relationValue))
    }
}

struct RelationalFormatStyle<BaseFormat: FormatStyle>: FormatStyle where BaseFormat.FormatInput: Comparable,
                                                                         BaseFormat.FormatInput: Codable,
                                                                         BaseFormat.FormatInput: Hashable,
                                                                         BaseFormat.FormatOutput == String {

    private let baseFormat: BaseFormat
    private let relationalValue: BaseFormat.FormatInput

    internal init(baseFormat: BaseFormat, relationalValue: BaseFormat.FormatInput) {
        self.baseFormat = baseFormat
        self.relationalValue = relationalValue
    }

    func format(_ value: BaseFormat.FormatInput) -> BaseFormat.FormatOutput {
        let formattedValueOperator: String? = switch value {
        case let x where x < relationalValue: "<"
        case let x where x == relationalValue: "="
        case let x where x > relationalValue: ">"
        default: nil
        }

        let formattedValue: String
        if let formattedValueOperator {
            let formattedRelationalValue = baseFormat.format(relationalValue)
            let formattedBaseValue = baseFormat.format(value)

            formattedValue = [formattedBaseValue, formattedValueOperator, formattedRelationalValue].joined()
        } else {
            formattedValue = baseFormat.format(value)
        }

        return formattedValue
    }

    func locale(_ locale: Locale) -> Self {
        .init(baseFormat: baseFormat.locale(locale), relationalValue: relationalValue)
    }
}


#Preview {
    RelationalFormatStyleView()
}
