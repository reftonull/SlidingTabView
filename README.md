# SlidingTabView

SlidingTabView was inspired by [Rishi Mody](https://www.threads.net/@rishimody?xmt=AQGz3EVpICKfdL7-hvjQY-yhsD62S_hHbuAxk6eX6WALUEo)'s app [Neuecast](https://apps.apple.com/us/app/neuecast/id6446780219).

To use it, simply install this package via SPM, or copy the files straight into your project.

While this is ready-to-use, I think the this serves best as an example of multiple SwiftUI techniques. 

Here are some highlights. 

## Variadic View
This package uses Variadic View to achieve an API that will seem quite similar to the SwiftUI TabView API. 

SwiftUI's Tab View:
```swift
@State var currentTab: Tab? = .new

enum Tab {
    case new
    case browse
    case subscribed
    case library
    case settings
}

var body: some View {
  TabView(selection: $currentTab) {
    Text("New")
      .tag(Tab.new)
      .tabIcon {
        Label("New", image: "clock.fill")
      }
  }

  SlidingTabView(selection: $currentTab) {
    Text("New")
      .tabTag(Tab.new)
      .tabInfo(TabInfo(name: "New", icon: "clock.fill"))
  }
}
```

This is done using Variadic View that you can learn about [here](https://movingparts.io/variadic-views-in-swiftui), and [here](https://chris.eidhof.nl/post/variadic-views/).

You can achieve a similar effect without using underscored APIs in iOS 18: [Group.init(subviews:transform:)](https://developer.apple.com/documentation/swiftui/group/init(subviews:transform:)).

## Matched Geometry Effect

To achieve animation of the capsule in the background, I used a matched geometry effect. It interpolates between the bounds of the removed capsule and the newly inserted capsule. 

You can learn about it more [here](https://swiftui-lab.com/matchedgeometryeffect-part1/).

## Gestures

There are two gestures in the tab view: a tap gesture, and a drag gesture. The tap gesture is simply added to each button within the tab view, and tapping on it sets the current tab to the one that was tapped on. 

The drag gesture is a little more interesting. It seems like a lot of work to do the math with using the currently open tab. However, the actual approach is a lot simpler: I just divide the available space by the number of tabs, which act as thresholds. 

For example, if I had a tab view with a width of 500 points and 5 tab items, each tab item would be allotted 100 points. When the user's gesture goes past 100, the next item is selected.

This is not very precise, but I have found it to work quite well in this case.

## Masks

I wanted it to look like the text was appearing from behind the icon. To do this I used a combination of a mask with a move transition. The text view moves into view from behind the icon. The mask looks like this: 

```swift
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
```

Where the mask has opacity 1, the view is completely visible, and where it has opacity 0, it disappears. This is how it appears to disappear behind the icon.

There's a few more intersting things in here, but I'll leave finding those as an exercise for the reader. 

Thanks for reading!
