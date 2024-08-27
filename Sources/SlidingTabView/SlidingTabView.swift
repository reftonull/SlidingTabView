//
//  SlidingTabView.swift
//  SlidingTabBar
//
//  Created by Laksh Chakraborty on 8/25/24.
//

import SwiftUI

public struct SlidingTabView<Selection: Hashable, Content: View>: View {
    @Binding var selection: Selection?
    @ViewBuilder var content: Content

    @Namespace var capsule

    public var body: some View {
        content.variadic { children in
            let tabInfos = children.compactMap { child in
                return child[TabItemTag.self]
            }

            let tabTags = children.compactMap { child in
                return child[TabTag.self].flatMap { $0 as? Selection }
            }

            VStack(spacing: 0) {
                ForEach(children) { child in
                    let tag: Selection? = child[TabTag.self].flatMap { $0 as? Selection }
                    let isSelected = tag == selection

                    if isSelected {
                        child
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }

                Divider()

                SlidingTabViewContainer(
                    capsuleNamespace: capsule,
                    tabs: tabInfos,
                    tabTags: tabTags,
                    currentTab: $selection
                )
            }
        }
    }
}

private struct SlidingTabViewContainer<Selection: Hashable>: View {
    var capsuleNamespace: Namespace.ID
    var tabs: [TabInfo]
    var tabTags: [Selection]
    @Binding var currentTab: Selection?

    @State private var width: CGFloat = 1

    func isCurrentTabLeading(tab: Selection) -> Bool {
        guard let currentTab,
              let currentTabIndex = tabTags.firstIndex(of: currentTab),
              let tabIndex = tabTags.firstIndex(of: tab) else {
            return false
        }

        return currentTabIndex - tabIndex == -1
    }

    func isCurrentTabTrailing(tab: Selection) -> Bool {
        guard let currentTab,
              let currentTabIndex = tabTags.firstIndex(of: currentTab),
              let tabIndex = tabTags.firstIndex(of: tab) else {
            return false
        }

        return currentTabIndex - tabIndex == 1
    }

    var body: some View {
        HStack(spacing:  0) {
            ForEach(Array(zip(tabs, tabTags)), id: \.1) { tab, tag in
                    TabItem(
                        namespace: capsuleNamespace,
                        icon: tab.icon,
                        name: tab.name,
                        isCollapsed: tag != currentTab
                    )
                    .padding(.top, 14)
                    .padding(.horizontal, tag != currentTab ? 10 : 0)
                    .padding(.leading, isCurrentTabLeading(tab: tag) ? 10 : 0)
                    .padding(.trailing, isCurrentTabTrailing(tab: tag) ? 10 : 0)
                    .contentShape(.rect)
                    .onTapGesture {
                        currentTab = tag
                    }
            }
        }
        .animation(.snappy(duration: 0.3, extraBounce: 0.1), value: currentTab)
        .sensoryFeedback(.impact(weight: .light), trigger: currentTab)
        .gesture(
            DragGesture(minimumDistance: 1, coordinateSpace: .local)
                .onChanged { value in
                    let portion = value.location.x / width
                    let index = Int(portion * CGFloat(tabs.count))
                    let clampedIndex = clamp(index, min: 0, max: tabs.count - 1)
                    Task {
                        currentTab = tabTags[clampedIndex]
                    }
                }
        )
        .onGeometryChange(for: CGFloat.self) { proxy in
            proxy.size.width
        } action: { width in
            self.width = width
        }
    }
}

