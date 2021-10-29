#
# Be sure to run `pod lib lint KGFlutter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FlutterSDKRelease'
  s.version          = '0.1.0'
  s.summary          = 'this is a very strong test demo'
  s.authors          = 'test'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/motinle/FlutterSDK.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.source           = { :git => 'https://github.com/motinle/FlutterSDK.git', :branch => 'master' }


  s.ios.deployment_target = '9.0'

#  s.source_files = 'KGFlutter/Classes/**/*'
   s.ios.vendored_frameworks = 'build/ios/Release-iphoneos/*.framework','build/ios/Release-iphoneos/*/*.framework'
end
