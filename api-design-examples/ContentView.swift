//
//  ContentView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

/*
 nice job, cursor. i wasn't gonna add this :)
 */
enum StyleView: String, CaseIterable, Identifiable {

    case formStyle = "Form Style"
    case listStyle = "List Style"
    case menuStyle = "Menu Style"
    case gaugeStyle = "Gauge Style"
    case labelStyle = "Label Style"
    case tableStyle = "Table Style"
    case buttonStyle = "Button Style"
    case pickerStyle = "Picker Style"
    case toggleStyle = "Toggle Style"
    case tabViewStyle = "Tab View Style"
    case groupBoxStyle = "Group Box Style"
    case indexStyle = "Index Style"
    case textFieldStyle = "Text Field Style"
    case datePickerStyle = "Date Picker Style"
    case textEditorStyle = "Text Editor Style"
    case controlGroupStyle = "Control Group Style"
    case progressViewStyle = "Progress View Style"
    case labeledContentStyle = "Labeled Content Style"
    case disclosureGroupStyle = "Disclosure Group Style"
    case navigationSplitStyle = "Navigation Split Style"
    case relationalFormatStyle = "Relational Format Style"
    case composableStyle = "Composable Style"
    
    var id: String { rawValue }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .formStyle:
            FormStyleView()
        case .listStyle:
            ListStyleView()
        case .menuStyle:
            MenuStyleView()
        case .gaugeStyle:
            GaugeStyleView()
        case .labelStyle:
            LabelStyleView()
        case .tableStyle:
            TableStyleView()
        case .buttonStyle:
            ButtonStyleView()
        case .pickerStyle:
            PickerStyleView()
        case .toggleStyle:
            ToggleStyleView()
        case .tabViewStyle:
            TabViewStyleView()
        case .groupBoxStyle:
            GroupBoxStyleView()
        case .indexStyle:
            IndexStyleView()
        case .textFieldStyle:
            TextFieldStyleView()
        case .datePickerStyle:
            DatePickerStyleView()
        case .textEditorStyle:
            TextEditorStyleView()
        case .controlGroupStyle:
            ControlGroupStyleView()
        case .progressViewStyle:
            ProgressViewStyleView()
        case .labeledContentStyle:
            LabeledContentStyleView()
        case .disclosureGroupStyle:
            DisclosureGroupStyleView()
        case .navigationSplitStyle:
            NavigationSplitStyleView()
        case .relationalFormatStyle:
            RelationalFormatStyleView()
        case .composableStyle:
            ComposableStyles()
        }
    }
}

struct ContentView: View {
    
    @State private var selectedStyle: StyleView?
    
    var body: some View {
        NavigationStack {
            List(StyleView.allCases) { style in
                Button {
                    selectedStyle = style
                } label: {
                    Text(style.rawValue)
                }
            }
            .navigationTitle("SwiftUI Styles")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(item: $selectedStyle) { style in
                style.destination
            }
        }
    }
}

#Preview {
    ContentView()
}
