# Table of Contents

- [AASegmentedControl](#section-id-4)
  - [Description](#section-id-10)
  - [Demonstration](#section-id-16)
  - [Requirements](#section-id-26)
- [Installation](#section-id-32)
  - [CocoaPods](#section-id-37)
  - [Carthage](#section-id-63)
  - [Manual Installation](#section-id-82)
- [Getting Started](#section-id-87)
  - [Create object of segmented control](#section-id-90)
  - [Set view object as segmented control](#section-id-104)
  - [Customise the segmented control](#section-id-112)
  - [Set properties and usage](#section-id-132)
  - [Properties with description](#section-id-150)
- [Contributions & License](#section-id-156)


<div id='section-id-4'/>

#AASegmentedControl

[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CocoaPods](https://img.shields.io/cocoapods/v/AASegmentedControl.svg)](http://cocoadocs.org/docsets/AASegmentedControl) [![License MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](https://github.com/Carthage/Carthage) [![Build Status](https://travis-ci.org/EngrAhsanAli/AASegmentedControl.svg?branch=master)](https://travis-ci.org/EngrAhsanAli/AASegmentedControl) 
![License MIT](https://img.shields.io/github/license/mashape/apistatus.svg) [![CocoaPods](https://img.shields.io/cocoapods/p/AASegmentedControl.svg)]()


<div id='section-id-10'/>

##Description

AASegmentedControl is lightweight and easy-to-use customised segmented controls designed in vertical or horizontal directions, written in Swift. It allows the replacement of `UISegmentedControl` in iOS.

<div id='section-id-16'/>

##Demonstration



![](https://github.com/EngrAhsanAli/AASegmentedControl/blob/master/Screenshots/demo.gif)


To run the example project, clone the repo, and run `pod install` from the Example directory first.


<div id='section-id-26'/>

##Requirements

- iOS 8.0+
- Xcode 8.0+
- Swift 3+

<div id='section-id-32'/>

# Installation

`AASegmentedControl` can be installed using CocoaPods, Carthage, or manually.


<div id='section-id-37'/>

##CocoaPods

`AASegmentedControl` is available through [CocoaPods](http://cocoapods.org). To install CocoaPods, run:

`$ gem install cocoapods`

Then create a Podfile with the following contents:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
pod 'AASegmentedControl'
end

```

Finally, run the following command to install it:
```
$ pod install
```



<div id='section-id-63'/>

##Carthage

To install Carthage, run (using Homebrew):
```
$ brew update
$ brew install carthage
```
Then add the following line to your Cartfile:

```
github "EngrAhsanAli/AASegmentedControl" 
```

Then import the library in all files where you use it:
```ruby
import AASegmentedControl
```


<div id='section-id-82'/>

##Manual Installation

If you prefer not to use either of the above mentioned dependency managers, you can integrate `AASegmentedControl` into your project manually by adding the files contained in the Classes folder to your project.


<div id='section-id-87'/>

#Getting Started
----------

<div id='section-id-90'/>

##Create object of segmented control

Drag `UIView` object from the *Object Library* into your `UIViewController` in storyboard.

![](https://github.com/EngrAhsanAli/AASegmentedControl/blob/master/Screenshots/Step1.png)

<div id='section-id-104'/>

##Set view object as segmented control

Set the view's class to `AASegmentedControl` in the *Identity Inspector*.
Make sure the module property is also set to  `AASegmentedControl`.

![](https://github.com/EngrAhsanAli/AASegmentedControl/blob/master/Screenshots/Step2.png)

<div id='section-id-112'/>

##Customise the segmented control

You can customise the rating bar appearance in the *Attributes Inspector.* 

> Note: If storyboard does not show the stars click *Refresh All Views* from the *Editor menu*.

![](https://github.com/EngrAhsanAli/AASegmentedControl/blob/master/Screenshots/Step3.png)

<div id='section-id-132'/>

##Set properties and usage

You can set following properties in `viewDidLoad` method in your view controller.

**Usage**:
```
segmentControl.itemNames = // String array for titles
segmentControl.font = // Your font
segmentControl.selectedIndex = // Default selected index

// Add listener and observe changes!
segmentControl.addTarget(self, action: #selector(self.segmentValueChanged(_:)), for: .valueChanged)


func segmentValueChanged(_ sender: AASegmentedControl) {

// sender.selectedIndex is the selected index

}
```

> Note that you can select or get the selected index by `selectedIndex` property.

<div id='section-id-150'/>

##Properties with description

You can use following properties: 

|  Properties	    |  Types	| Description		    				   |
|-------------------|-----------|------------------------------------------|
| `itemNames`       | `[String]`| array of item names 					   |
| `font`            | `UIFont`  | font for items with size			       |
| `selectedIndex`   | `Int`     | selected index of item   				   |			   
| `allowDamping`    | `Bool`    | allow dampling animation for active view |
| `activeUnderline` | `Bool`    | active underline or rectangle view	   |
| `isHorizontal`    | `Bool`    | horizontal or vertical direction		   |
| `borderRadius`    | `CGFloat` | border radius			   				   |
| `borderWidth`     | `CGFloat` | border width 			 				   |
| `borderColor`     | `UIColor` | border color							   |
| `activeColor`     | `UIColor` | active item text color				   |
| `unactiveColor`   | `UIColor` | unactive item text color				   |
| `activeBG`        | `UIColor` | active item background color			   |

<div id='section-id-156'/>

#Contributions & License

`AASegmentedControl` is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.

Pull requests are welcome! The best contributions will consist of substitutions or configurations for classes/methods known to block the main thread during a typical app lifecycle.

I would love to know if you are using `AASegmentedControl` in your app, send an email to [Engr. Ahsan Ali](mailto:hafiz.m.ahsan.ali@gmail.com)

