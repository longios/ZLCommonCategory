#
# Be sure to run `pod lib lint ZuJianHuaTest2.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZuJianHuaTest2'
  s.version          = '0.0.1'
  s.summary          = '日常 category'

  s.description      = "日常开发中用到的category 合集 方便demo创建时候不用拉文件"

  s.homepage         = 'https://github.com/longios/ZLCommonCategory'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lq2' => 'wzl930623@163.com' }
  s.source           = { :git => 'https://github.com/longios/ZLCommonCategory.git', :tag => 0.0.1 }

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZuJianHuaTest2/Classes/**/*'
  

  s.resource_bundles = {
    'ZuJianHuaTest2' => ['ZuJianHuaTest2/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
