//
//  NavigationSplitStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-03.
//

import SwiftUI

struct NavigationSplitStyleView: View {

    var body: some View {
        NavigationSplitView {
            Text("Sidebar")
        } content: {
            Text("Content")
        } detail: {
            Text("Detail")
        }
        .navigationSplitViewStyle(CustomNavigationSplitViewStyle())
    }
}

struct CustomNavigationSplitViewStyle: NavigationSplitViewStyle {

    // i wonder why we have to use AnyView 🤔😝
    typealias Body = AnyView

    func makeBody(configuration: Configuration) -> AnyView {
        /*
         Configuration doesn't give us any properties to work with or build
         custom styles. but we have the object, and looking at it, we can see
         a lot of the internal APIs Apple uses to build NavigationSplitViewStyles.
         sadly, we can't use them, but feel free to poke more around it :)

         *BE A REBEL*

        ▿ NavigationSplitViewStyleConfiguration
               - sidebar : SwiftUI.NavigationSplitViewStyleConfiguration.Sidebar()
               - content : SwiftUI.NavigationSplitViewStyleConfiguration.Content()
               - detail : SwiftUI.NavigationSplitViewStyleConfiguration.Detail()
               ▿ visibility : CompositeNavigationSplitViewVisibility
                 ▿ readWrite : Binding<AnyNavigationSplitVisibility>
                   ▿ transaction : Transaction
                     ▿ plist : []
                       - elements : nil
                   ▿ location : <LocationBox<ScopedLocation>: 0x600000c68bd0>
                   ▿ _value : unbound
                     - kind : SwiftUI.AnyNavigationSplitVisibility.Kind.threeUnboundColumns
                 - readOnly : nil
               - columnCount : 3
               ▿ preferredCompactColumn : Binding<NavigationSplitViewColumn>
                 ▿ transaction : Transaction
                   ▿ plist : []
                     - elements : nil
                 ▿ location : <LocationBox<ScopedLocation>: 0x600000c68a20>
                 ▿ _value : NavigationSplitViewColumn
                   - tag : SwiftUI.NavigationSplitViewColumn.Tag.sidebar
         */
        debugPrint(configuration)
        return AnyView(
            Text("Split View")
        )
    }
}

#Preview {
    NavigationSplitStyleView()
}
