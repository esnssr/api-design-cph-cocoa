//
//  ListStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct ListStyleView: View {
    let fruits = ["Apple", "Banana", "Cherry", "Mango", "Orange"]

    var body: some View {
        NavigationView {
            List(fruits, id: \.self) { fruit in
                Text(fruit)
            }
            .navigationTitle("Fruits")
            .listStyle(.plain)
        }
    }
}

// ListStyle is one of the styles that we can't use. as you can see my dear
// and poor iOS developer, Apple doesn't allow us to build custom styles with this one.
// confirming to the style protocol will result in the compiler *trying* to satisfy the conformance, but we get a loooot of private and undocumented APIs.
// i will leave it as an exercise for you, dear reader, to try and hack those.
// if you ever do, please get in touch with me, i would love to know how those APIs work :)

// ❗uncomment to let hell break loose 

//struct CustomListStyle: ListStyle {
//    public static func _makeView<SelectionValue>(value: _GraphValue<_ListValue<CustomListStyle, SelectionValue>>, inputs: _ViewInputs) -> _ViewOutputs where SelectionValue : Hashable {
//
//    }
//
//    public static func _makeViewList<SelectionValue>(value: _GraphValue<_ListValue<CustomListStyle, SelectionValue>>, inputs: _ViewListInputs) -> _ViewListOutputs where SelectionValue : Hashable {
//    }
//}

#Preview {
    ListStyleView()
}
