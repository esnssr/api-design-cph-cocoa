//
//  LabeledContentStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-03.
//

import SwiftUI

struct LabeledContentStyleView: View {
    var body: some View {
        Form {
            LabeledContent("Username", value: "janedoe")
            LabeledContent("Email", value: "jane@example.com")
            LabeledContent("Membership") {
                Text("Premium")
                    .foregroundColor(.green)
            }
            .labeledContentStyle(VeryWeirdStyleIDKWhatToDo())
        }
    }
}

/*
 be a rebel, find something creative to do with this style 🤷🏼‍♂️
 */
struct VeryWeirdStyleIDKWhatToDo: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
            configuration.content
        }
        .background(.red)
    }
}

#Preview {
    LabeledContentStyleView()
}
