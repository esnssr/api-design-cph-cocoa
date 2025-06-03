//
//  GaugeStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct GaugeStyleView: View {

    @State private var progress: Double = 0.6

    var body: some View {
        VStack(spacing: 20) {
            Gauge(value: progress) {
                Text("Battery")
            } currentValueLabel: {
                Text("\(Int(progress * 100))%")
            } minimumValueLabel: {
                Text("0%")
            } maximumValueLabel: {
                Text("100%")
            }
            .gaugeStyle(.carSpeedometer)

            Slider(value: $progress, in: 0...1)
        }
        .padding()
    }
}

// MARK: - CarSpeedometerGaugeStyle
extension GaugeStyle where Self == CarSpeedometerGaugeStyle {
    static var carSpeedometer: CarSpeedometerGaugeStyle { CarSpeedometerGaugeStyle() }
}

// car speedometer style, because why the hell not??
struct CarSpeedometerGaugeStyle: GaugeStyle {
    // in this example, i am not using the labels or content in the
    // configuration, even though i passed them.
    // make sure to account for this. You can let the users' of the API control
    // content's and labels' visibility with some modifiers and environment values.
    func makeBody(configuration: Configuration) -> some View {
        let value = configuration.value
        let min = 0.0
        let max = 1.0
        let totalAngle = 135.0
        let startAngle = -totalAngle / 2
        let needleAngle = startAngle + (value - min) / (max - min) * totalAngle

        return ZStack {
            // Outer ring
            Circle()
                .trim(from: 0.55, to: 1)
                .stroke(.black, lineWidth: 4)
                .rotationEffect(.degrees(-8.5))

            // Speed labels
            ForEach(Array(stride(from: 0, through: 140, by: 20)), id: \.self) { speed in
                let fraction = Double(speed) / 140.0
                let tickAngle = Angle(degrees: startAngle + fraction * totalAngle)

                VStack {
                    Text("\(speed)")
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundColor(speed >= 120 ? .red : .black)
                        .rotationEffect(-tickAngle)
                        .offset(y: -100) // Increased spacing
                }
                .rotationEffect(tickAngle)
            }

            // Needle
            Rectangle()
                .fill(Color.red)
                .frame(width: 2, height: 70)
                .offset(y: -40)
                .rotationEffect(Angle(degrees: needleAngle))
                .animation(.easeInOut(duration: 0.2), value: value)

            // Center cap
            Circle()
                .fill(Color.black)
                .frame(width: 12, height: 12)
        }
        .frame(width: 230, height: 230)
    }
}

#Preview {
    GaugeStyleView()
}
