//
//  VariadicTraits.swift
//  SlidingTabView
//
//  Created by Laksh Chakraborty on 8/27/24.
//

import SwiftUI

struct TabTag: _ViewTraitKey {
    static let defaultValue: AnyHashable? = Optional<Int>.none
}

extension View {
    func tabTag<Value: Hashable>(_ value: Value) -> some View {
        _trait(TabTag.self, value)
    }
}

struct TabInfo: Hashable {
    var icon: String
    var name: String
}

struct TabItemTag: _ViewTraitKey {
    static let defaultValue: TabInfo? = nil
}

extension View {
    func tabInfo(_ info: TabInfo) -> some View {
        _trait(TabItemTag.self, info)
    }
}
