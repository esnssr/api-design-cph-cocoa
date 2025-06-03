//
//  GroupBoxStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct GroupBoxStyleView: View {
    var body: some View {
        GroupBox(label: Label("User Info", systemImage: "person.circle")) {
            Text("Name: Jane Doe")
            Text("Email: jane@example.com")
            Text("Member since: 2021")
        }
        .padding()
        .groupBoxStyle(.primary)
    }
}

// MARK: - PrimaryGroupBoxStyle
extension GroupBoxStyle where Self == PrimaryGroupBoxStyle {
    static var primary: PrimaryGroupBoxStyle { PrimaryGroupBoxStyle() }
}

struct PrimaryGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.label
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.secondary)

            VStack(spacing: 8) {
                ForEach(subviews: configuration.content) { subview in
                    subview
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .background(.fill.quaternary, in: .rect(cornerRadius: 16))
        }
    }
}

#Preview {
    GroupBoxStyleView()
}
