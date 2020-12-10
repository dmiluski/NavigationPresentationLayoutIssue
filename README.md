## Prerequisites

A `.netrc` file in your **home directory** (e.g. ~/username/.netrc) is also required to download `mapbox-navigation` > `v0.35`.

For the most [up to date directions click here](https://github.com/mapbox/mapbox-navigation-ios/#using-carthage)

## Initial Setup / Run

To get up and running several prerequisites and dependencies must be installed. To get fully setup run this single command.

`make init`

Then open `NavigationPresentationLayoutIssue.xcodeproj` in Xcode

## Reproduction Instructions

1. Run initial Setup steps
2. Insert YOUR mapbox token into the Info.plist
3. Run the app and `Show Navigation`. A short async fetch for direction will occur, please give a few seconds since this doesn't have async button feedback.
4. Upon dismiss, tap in the TextField and see it scroll off to the top of the screen. If in the simulator you may need to tap `Command + k` to bring the keyboard up

## Observations

I'm seeing several Constraint Breaks

> "<NSLayoutConstraint:0x600003c09b80 H:[UIButton:0x7fe5bc49ce40]-(8)-|   (active, names: '|':MapboxNavigation.NavigationMapView:0x7fe5bd530000 )>",
"<NSLayoutConstraint:0x600003cffbb0 MapboxNavigation.NavigationMapView:0x7fe5bd530000.trailing == MapboxNavigation.NavigationView:0x7fe5bc683490.trailing   (active)>",
"<NSLayoutConstraint:0x600003cff750 UIButton:0x7fe5bc49ce40.trailing == MapboxNavigation.NavigationView:0x7fe5bc683490.trailing - 10   (active)>"

If I use other UIViewController instances such as UIViewController instead of Mapbox NavigationViewController the textField behaves as would expect

## 📱 Gifs

| Presenting Mapbox NavigationViewController | Presenting Generic ViewController |
| --- | --- |
| ![withNavigationViewController](https://user-images.githubusercontent.com/5083390/101707686-91996800-3a40-11eb-9d1f-01ca351618da.gif) | ![withGenericViewController](https://user-images.githubusercontent.com/5083390/101707683-8fcfa480-3a40-11eb-9375-24d9f0851562.gif) |
| For some odd reason, when presenting the Nav View, the keyboard avoidance goes haywire | When using a basic UIViewController it seems to behave fine |
