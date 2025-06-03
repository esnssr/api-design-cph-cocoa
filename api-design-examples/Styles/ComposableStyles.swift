//
//  ComposableStyles.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-03.
//

import SwiftUI
/*
 see https://movingparts.io/composable-styles-in-swiftui
 and https://movingparts.io/styling-components-in-swiftui
 */

struct ComposableStyles: View {
    var body: some View {
        VStack(spacing: 24) {
            Button("Composable Button") {

            }
            .buttonStyle(.filled.borderedLine(.red, width: 4).shaped(.capsule))
            .tint(.green)

            ProgressView(value: 0.5)
                .progressViewStyle(.linearProminent.tint(.orange))
        }
        .padding()
    }
}

// MARK: - FilledButtonStyle
extension PrimitiveButtonStyle where Self == FilledButtonStyle {
    static var filled: FilledButtonStyle { FilledButtonStyle() }
}

struct FilledButtonStyle: PrimitiveButtonStyle {

    @Environment(\.filledButtonColor) var buttonColor

    func makeBody(configuration: Configuration) -> some View {
        Button {

        } label: {
            configuration.label
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
        }
        .buttonStyle(.borderedProminent)
    }
}

// MARK: - ButtonBorderShapeStyle
struct ButtonBorderShapeStyleModifier: ViewModifier {

    var buttonShape: ButtonBorderShape = .buttonBorder

    func body(content: Content) -> some View {
        content
            .buttonBorderShape(buttonShape)
    }
}

public extension PrimitiveButtonStyle {
    func shaped(_ shape: ButtonBorderShape) -> some PrimitiveButtonStyle {
        modifier(ButtonBorderShapeStyleModifier(buttonShape: shape))
    }
}

// MARK: - BorderedLineButtonStyle
struct BorderedLineButtonStyleModifier: ViewModifier {

    var color: Color = .black
    var width: CGFloat = 1

    func body(content: Content) -> some View {
        content
            .overlay {
                AnyShape(.buttonBorder)
                    .stroke(color, lineWidth: 2, antialiased: true)
            }
    }
}

public extension PrimitiveButtonStyle {
    var borderedLine: some PrimitiveButtonStyle {
        modifier(BorderedLineButtonStyleModifier())
    }

    func borderedLine(_ color: Color, width: CGFloat = 1) -> some PrimitiveButtonStyle {
        modifier(BorderedLineButtonStyleModifier(color: color, width: width))
    }
}

// MARK: - ModifiedStyle
extension ModifiedStyle: PrimitiveButtonStyle where Style: PrimitiveButtonStyle {
    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        Button(configuration)
            .buttonStyle(style)
            .modifier(modifier)
    }
}

extension PrimitiveButtonStyle {
    func modifier(_ modifier: some ViewModifier) -> some PrimitiveButtonStyle {
        ModifiedStyle(style: self, modifier: modifier)
    }
}

struct ModifiedStyle<Style, Modifier: ViewModifier>: DynamicProperty {
    var style: Style
    var modifier: Modifier
}

private struct FilledButtonColorEnvironmentKey: EnvironmentKey {
    static let defaultValue: Color = .blue
}

private extension EnvironmentValues {
    var filledButtonColor: Color {
        get { self[FilledButtonColorEnvironmentKey.self] }
        set { self[FilledButtonColorEnvironmentKey.self] = newValue }
    }
}


// MARK: - Progress View
struct ProgressViewStyleTintModifier: ViewModifier {

    let tint: Color

    func body(content: Content) -> some View {
        content
            .environment(\.progressViewTint, tint)
    }
}

public extension ProgressViewStyle {
    func tint(_ color: Color) -> some ProgressViewStyle {
        modifier(ProgressViewStyleTintModifier(tint: color))
    }
}


extension ProgressViewStyle where Self == LinearProminentProgressViewStyle {
    static var linearProminent: LinearProminentProgressViewStyle { LinearProminentProgressViewStyle() }
}

struct LinearProminentProgressViewStyle: ProgressViewStyle {

    @Environment(\.progressViewTint) var color

    public func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.fill.tertiary)

            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 10)
                    .fill(color)
                    .frame(width: geo.size.width / (1 / (configuration.fractionCompleted ?? 1)))
            }
        }
        .frame(height: 30)
    }
}

struct ProgressViewStyleTintColorEnvironmentKey: EnvironmentKey {
    static let defaultValue: Color = .yellow
}

extension EnvironmentValues {
    fileprivate var progressViewTint: Color {
        get { self[ProgressViewStyleTintColorEnvironmentKey.self] }
        set { self[ProgressViewStyleTintColorEnvironmentKey.self] = newValue }
    }
}

extension ModifiedStyle: ProgressViewStyle where Style: ProgressViewStyle {
    func makeBody(configuration: ProgressViewStyleConfiguration) -> some View {
        ProgressView(configuration)
            .progressViewStyle(style)
            .modifier(modifier)
    }
}

private extension ProgressViewStyle {
    func modifier(_ modifier: some ViewModifier) -> some ProgressViewStyle {
        ModifiedStyle(style: self, modifier: modifier)
    }
}


#Preview {
    ComposableStyles()
}
