//
//  Int+Clamp.swift
//  SlidingTabView
//
//  Created by Laksh Chakraborty on 8/27/24.
//

func clamp(_ value: Int, min: Int, max: Int) -> Int {
    return Swift.max(min, Swift.min(max, value))
}
