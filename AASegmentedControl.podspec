Pod::Spec.new do |s|
s.name             = 'AASegmentedControl'
s.version          = '1.5'
s.summary          = 'AASegmentedControl is lightweight and easy-to-use customised segmented controls, written in Swift.'

s.description      = <<-DESC
AASegmentedControl is a lightweight and easy-to-use customised segmented controls designed in vertical or horizontal directions, written in Swift. It allows the replacement of UISegmentedControl in iOS.
DESC

s.homepage         = 'https://github.com/EngrAhsanAli/AASegmentedControl'
s.screenshots     = 'https://raw.githubusercontent.com/EngrAhsanAli/AASegmentedControl/master/Screenshots/AASegmentedControl.png'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Engr. Ahsan Ali' => 'hafiz.m.ahsan.ali@gmail.com' }
s.source           = { :git => 'https://github.com/EngrAhsanAli/AASegmentedControl.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'
s.swift_version = '5.0'

s.source_files = 'AASegmentedControl/Classes/**/*'

end

