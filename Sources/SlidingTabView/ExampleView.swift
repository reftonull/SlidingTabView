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
                .tabInfo(TabInfo(icon: "clock.fill", name: "New"))
            Text("Browse")
                .tabTag(Tab.browse)
                .tabInfo(TabInfo(icon: "magnifyingglass", name: "Browse"))
            Text("Subscribed")
                .tabTag(Tab.subscribed)
                .tabInfo(TabInfo(icon: "square.grid.2x2.fill", name: "Subscribed"))
            Text("Library")
                .tabTag(Tab.library)
                .tabInfo(TabInfo(icon: "bookmark.fill", name: "Library"))
            Text("Settings")
                .tabTag(Tab.settings)
                .tabInfo(TabInfo(icon: "chart.bar.fill", name: "Settings"))
        }
    }
}

#Preview {
    ExampleView()
}
