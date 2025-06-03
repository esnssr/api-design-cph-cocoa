//
//  ControlGroupStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct ControlGroupStyleView: View {
    var body: some View {
        VStack {
            ControlGroup("Controls", systemImage: "macwindow.and.cursorarrow") {
                Button {
                    print("Cut")
                } label: {
                    Label("Cut", systemImage: "scissors")
                }

                Button {
                    print("Copy")
                } label: {
                    Label("Copy", systemImage: "doc.on.doc")
                }

                Button {
                    print("Paste")
                } label: {
                    Label("Paste", systemImage: "doc.on.clipboard")
                }
            }
            .controlGroupStyle(.coolio)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.fill)
    }
}

extension ControlGroupStyle where Self == CoolioControlGroupStyle {
    static var coolio: CoolioControlGroupStyle { CoolioControlGroupStyle() }
}

struct CoolioControlGroupStyle: ControlGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            /*
             i decided to hide the label here, but we should make sure to give users the
             option to show/hide the label
             */
//            configuration.label
            HStack(spacing: 16) {
                ForEach(subviews: configuration.content) { subview in
                    subview
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(.white, in: .rect(cornerRadius: 12))
                        .compositingGroup()
                        .shadow(color: .black.opacity(0.2), radius: 0, y: 3)
                        .fontDesign(.rounded)
                        .fontWeight(.medium)
                }
            }
        }
    }
}

#Preview {
    ControlGroupStyleView()
}
