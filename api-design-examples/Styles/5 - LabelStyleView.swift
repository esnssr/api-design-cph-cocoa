//
//  LabelStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct LabelStyleView: View {
    var body: some View {
        Label("Label", systemImage: "heart")
            .labelStyle(.whatTheHellIsThis)
    }
}

extension LabelStyle where Self == WhatTheHellIsThis {
    static var whatTheHellIsThis: WhatTheHellIsThis { WhatTheHellIsThis() }
}

// there isn't much you can do with LabelStyle, other than controlling the spacing and
// position of the elements.
struct WhatTheHellIsThis: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.title
            configuration.icon
        }
        .blur(radius: 1)
    }
}

#Preview {
    LabelStyleView()
}
