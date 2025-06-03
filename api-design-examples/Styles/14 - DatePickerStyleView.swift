//
//  DatePickerStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct DatePickerStyleView: View {
    
    @State private var selectedDate = Date.now

    var body: some View {
        DatePicker(
            "Select a date",
            selection: $selectedDate,
            displayedComponents: [.date]
        )
        .datePickerStyle(.primary)

        DatePicker(
            "Select a date",
            selection: $selectedDate,
            displayedComponents: [.date]
        )
        .datePickerStyle(.compact)
        .labelsHidden()
    }
}


extension DatePickerStyle where Self == PrimaryDatePickerStyle {
    static var primary: PrimaryDatePickerStyle { PrimaryDatePickerStyle() }
}

struct PrimaryDatePickerStyle: DatePickerStyle {

    @Environment(\.labelsVisibility) var labelsVisibility

    func makeBody(configuration: Configuration) -> some View {
        /*
         even though DatePickerStyleConfiguration gives us
         all the properties we need, it is still tricky to style
         the component, especially if we want to style the
         compact version of it.
         so we have to be a little bit hacky

         Note: you can of course use the properties as you want
         and come up with another style without any of the hacks i have here,
         but i was stubborn 😅 enough that i wanted to change the
         `.compact` version of the style to look a certain way.
         */
        HStack {
            if labelsVisibility == .visible {
                configuration.label
                Spacer()
            }
            DatePicker(
                selection: configuration.$selection,
                displayedComponents: configuration.displayedComponents
            ) {
                EmptyView()
            }
            /*
             if we completely hide the picker, the tap gesture will
             be disabled, and the date picker won't be shown. so we
             can hide as much of it as we can, which in this case is a very low
             value of opacity, but not quite hidden. the result is a
             date picker that is not visible...👇🏼
             Note: through trial and error (and a lot of anger 😒), i ended
             up with this value, which has the lowest opacity value possible without
             triggering the system to disable the gesture
             */
            .opacity(0.010111111111111)
            .labelsHidden()
            .datePickerStyle(.compact)
            /*
             we then just add whatever style we want as an overlay :)
             */
            .overlay {
                Text(configuration.selection, format: .dateTime.day().month().year())
                    .contentTransition(.numericText())
                    .minimumScaleFactor(0.9)
                    .font(.body.weight(.bold))
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(.black.gradient, in: .capsule)
                    /*
                     there is an ugly bug 🐞 with animations in text
                     with numericText. if you see it, well, tough luck...
                     if you can fix it, good for you :)
                     */
                    .animation(.smooth, value: configuration.selection)
                    /*
                     disable taps on the text to allow gesture to be on the
                     date picker
                     */
                    .allowsHitTesting(false)
            }
        }
    }
}

#Preview {
    DatePickerStyleView()
}
