//
//  TabViewStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct TabViewStyleView: View {
    var body: some View {
        TabView {
            Text("Home Screen")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            Text("Favorites")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }

            Text("Settings")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

// uncomment the style, I FUCKING DARE YOU ❗

//struct CustomTabViewStyle: TabViewStyle {
//    static func _makeView<SelectionValue>(value: _GraphValue<_TabViewValue<CustomTabViewStyle, SelectionValue>>, inputs: _ViewInputs) -> _ViewOutputs where SelectionValue : Hashable {
//
//    }
//
//    static func _makeViewList<SelectionValue>(value: _GraphValue<_TabViewValue<CustomTabViewStyle, SelectionValue>>, inputs: _ViewListInputs) -> _ViewListOutputs where SelectionValue : Hashable {
//
//    }
//}
#Preview {
    TabViewStyleView()
}
