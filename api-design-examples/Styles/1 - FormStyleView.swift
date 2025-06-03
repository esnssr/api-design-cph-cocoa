//
//  FormStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct FormStyleView: View {

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var notificationsEnabled: Bool = true
    @State private var selectedColor: Color = .blue
    @State private var birthDate: Date = Date.now

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Preferences")) {
                    VStack(spacing: 4) {
                        Toggle("Enable Notifications", isOn: $notificationsEnabled)

                        Text("Receive weekly updates")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    ColorPicker("Favorite Color", selection: $selectedColor)

                    DatePicker("Birth Date", selection: $birthDate, displayedComponents: .date)
                }

                Button {
                    debugPrint("Name: \(name), Email: \(email)")
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
            }
            .formStyle(.settings)
            .navigationTitle("Settings")
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
        }
    }
}

// MARK: - Settings Form Style
public extension FormStyle where Self == SettingsFormStyle {
    static var settings: SettingsFormStyle { SettingsFormStyle() }
}

public struct SettingsFormStyle: FormStyle {
    public func makeBody(configuration: Configuration) -> some View {
        ScrollView {
            VStack {
                ForEach(sections: configuration.content) { section in
                    let hasFooter = !section.footer.isEmpty
                    if !section.header.isEmpty {
                        section.header
                            .font(.headline.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.secondary)
                            .padding(.leading, 12)
                    }

                    VStack(spacing: 0) {
                        Group(subviews: section.content) { subViews in
                            let lastViewId = subViews.last?.id
                            ForEach(subviews: subViews) { subView in
                                subView
                                    .fontWeight(.medium)

                                if subView.id != lastViewId {
                                    Divider()
                                        .padding(.vertical)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(.fill.quaternary, in: .rect(cornerRadius: 16))
                    .padding(.bottom, !hasFooter ? 16 : 0)

                    if hasFooter {
                        section.footer
                    }
                }
            }
            .padding(.horizontal)
            .tint(.pink)
        }
    }
}


// MARK: - Preview
#Preview {
    FormStyleView()
}
