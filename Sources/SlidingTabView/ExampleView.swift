//
//  ExampleView.swift
//  SlidingTabView
//
//  Created by Laksh Chakraborty on 8/27/24.
//

import SwiftUI

struct ExampleView: View {
    @State var currentTab: Tab? = .new

    enum Tab {
        case new
        case browse
        case subscribed
        case library
        case settings
    }

    var body: some View {
        SlidingTabView(selection: $currentTab) {
            Text("New")
                .tabTag(Tab.new)
                .tabInfo(TabInfo(name: "New", icon: "clock.fill"))
            Text("Browse")
                .tabTag(Tab.browse)
                .tabInfo(TabInfo(name: "Browse", icon: "magnifyingglass"))
            Text("Subscribed")
                .tabTag(Tab.subscribed)
                .tabInfo(TabInfo(name: "Subscribed", icon: "square.grid.2x2.fill"))
            Text("Library")
                .tabTag(Tab.library)
                .tabInfo(TabInfo(name: "Library", icon: "bookmark.fill"))
            Text("Settings")
                .tabTag(Tab.settings)
                .tabInfo(TabInfo(name: "Settings", icon: "chart.bar.fill"))
        }
    }
}

#Preview {
    ExampleView()
}
