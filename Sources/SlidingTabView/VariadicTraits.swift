//
//  VariadicTraits.swift
//  SlidingTabView
//
//  Created by Laksh Chakraborty on 8/27/24.
//

import SwiftUI

public struct TabTag: _ViewTraitKey {
    public static let defaultValue: AnyHashable? = Optional<Int>.none
}

extension View {
    public func tabTag<Value: Hashable>(_ value: Value) -> some View {
        _trait(TabTag.self, value)
    }
}

public struct TabInfo: Hashable {
    var icon: String
    var name: String

    public init(icon: String, name: String) {
        self.icon = icon
        self.name = name
    }
}

public struct TabItemTag: _ViewTraitKey {
    public static let defaultValue: TabInfo? = nil
}

extension View {
    public func tabInfo(_ info: TabInfo) -> some View {
        _trait(TabItemTag.self, info)
    }
}
