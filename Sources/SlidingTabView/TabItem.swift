//
//  TabItem.swift
//  SlidingTabView
//
//  Created by Laksh Chakraborty on 8/27/24.
//

import SwiftUI

struct TabItem: View {
    let buttonHeight: CGFloat = 16

    var namespace: Namespace.ID

    var icon: String
    var name: String
    var isCollapsed: Bool

    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: icon)
                .font(.footnote)
                .bold()
                .fontDesign(.rounded)
                .frame(height: buttonHeight)
            VStack {
                if !isCollapsed {
                    Text(name)
                        .font(.caption)
                        .bold()
                        .textCase(.uppercase)
                        .padding(.leading, 6)
                        .transition(
                            .opacity.combined(with: .move(edge: .leading))
                        )
                }
            }
            .frame(height: buttonHeight)
            .padding(.trailing, 11)
            .mask(alignment: .leading) {
                HStack(spacing: 0) {
                    LinearGradient(
                        colors: [.black.opacity(0), .black.opacity(1)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: 6)
                    Color.black
                }
            }
        }
        .foregroundStyle(.secondary)
        .frame(height: buttonHeight)
        .padding(.vertical, 9)
        .padding(.leading, 11)
        .background {
            if !isCollapsed {
                Capsule()
                    .fill(.quinary)
                    .matchedGeometryEffect(id: "capsule", in: namespace)
            }
        }
        .contentShape(.rect)
        .animation(.snappy(duration: 0.3, extraBounce: 0.1), value: isCollapsed)
    }
}
