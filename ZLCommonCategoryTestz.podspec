#
# Be sure to run `pod lib lint ZuJianHuaTest2.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZLCommonCategoryTestz'
  s.version          = '0.0.2'
  s.summary          = '日常category'

  s.description      = '日常开发中用到的category合集 方便demo创建时候不用拉文件'

  s.homepage         = 'https://github.com/longios/ZLCommonCategory'
  s.license          = "MIT"
  s.author           = { 'lq2' => 'wzl930623@163.com' }
  s.source           = { :git => 'https://github.com/longios/ZLCommonCategory.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZuJianHuaTest2/Classes/**/*'
  

  #s.resource_bundles = {
   # 'ZuJianHuaTest2' => ['ZuJianHuaTest2/Assets/*.png']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
