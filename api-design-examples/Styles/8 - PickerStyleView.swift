//
//  PickerStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct PickerStyleView: View {
    
    @State private var selectedColor = "Red"

    let colors = ["Red", "Green", "Blue"]

    var body: some View {
        VStack {
            Text("Selected color: \(selectedColor)")
                .padding()

            Picker("Choose a color", selection: $selectedColor) {
                ForEach(colors, id: \.self) { color in
                    Text(color)
                }
            }
            .pickerStyle(.segmented)
            .padding()
        }
    }
}

// nothing to see here, go away 😒

//struct CustomPickerStyle: PickerStyle {
//    static func _makeView<SelectionValue>(value: _GraphValue<_PickerValue<CustomPickerStyle, SelectionValue>>, inputs: _ViewInputs) -> _ViewOutputs where SelectionValue : Hashable {
//
//    }
//
//    static func _makeViewList<SelectionValue>(value: _GraphValue<_PickerValue<CustomPickerStyle, SelectionValue>>, inputs: _ViewListInputs) -> _ViewListOutputs where SelectionValue : Hashable {
//
//    }
//}

#Preview {
    PickerStyleView()
}
