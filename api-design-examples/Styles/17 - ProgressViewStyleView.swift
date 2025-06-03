//
//  ProgressViewStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-03.
//

import SwiftUI

struct ProgressViewStyleView: View {

    @State private var progress: Double = 0.5

    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(.circle)
                .frame(width: 80, height: 80)

            Divider()
            Slider(value: $progress)
        }
        .padding()
    }
}

extension ProgressViewStyle where Self == CircleProgressViewStyle {
    static var circle: CircleProgressViewStyle { CircleProgressViewStyle() }
}

struct CircleProgressViewStyle: ProgressViewStyle {

    let width: CGFloat

    init(width: CGFloat = 4) {
        self.width = width
    }

    public func makeBody(configuration: Configuration) -> some View {
        /*
         progress view style gives you access to the labels as well
         */
        ZStack {
            Circle()
                .stroke(
                    .gray,
                    lineWidth: width
                )

            Circle()
                .trim(from: 0, to: configuration.fractionCompleted ?? 0)
                .stroke(
                    .green,
                    style: StrokeStyle(
                        lineWidth: width,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))

            if let label = configuration.label {
                label
            }
        }
    }
}


#Preview {
    ProgressViewStyleView()
}
