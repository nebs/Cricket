# Cricket

[![Version](https://img.shields.io/cocoapods/v/Cricket.svg?style=flat)](http://cocoapods.org/pods/Cricket)
[![License](https://img.shields.io/cocoapods/l/Cricket.svg?style=flat)](http://cocoapods.org/pods/Cricket)
[![Platform](https://img.shields.io/cocoapods/p/Cricket.svg?style=flat)](http://cocoapods.org/pods/Cricket)

## About

Cricket is an Swift iOS library for reporting bugs or sending feedback from within your app.

## Basic Usage

```swift
// Configure a handler
Cricket.handler = CricketEmailHandler(emailAddress: "bugs@example.com", subjectPrefix: "[iOS]", defaultSubject: "Cricket bug report")

// Show Cricket
Cricket.show()
```

One convenient way of using Cricket is to show it when the user shakes their phone.

For example, in your view controller:

```swift
override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
  if motion == .motionShake {
    Cricket.show()
  }
}
```

## Handlers

Cricket relies on handlers to submit the data. A handler is any class that conforms to the `CricketHandler` protocol. Included in this project is a convenient `CricketEmailHandler` class which will use the built-in email client for sending the feedback.

You can of course build your own handlers, for example if you wanted to report the feedback directly to your server via an API.

Simply assign your handler to Cricket before showing it, like so: `Cricket.handler = MyCoolHandler()`

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 9.3

## Installation

Cricket is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Cricket'
```

## Author

Nebojsa Petrovic, nebspetrovic@gmail.com

## License

Cricket is available under the MIT license. See the LICENSE file for more info.
