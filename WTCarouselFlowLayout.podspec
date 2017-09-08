Pod::Spec.new do |s|
  s.name             = 'WTCarouselFlowLayout'
  s.version          = '0.2.0'
  s.summary          = 'To use collectView show carousel list.'

  s.description      = 'WTCarouselFlowLayout one kind of collectView layout to show carousel list.'

  s.homepage         = 'https://github.com/wusuowei/WTCarouselFlowLayout'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wentianen' => '1206860151@qq.com' }
  s.source           = { :git => 'https://github.com/wusuowei/WTCarouselFlowLayout.git', :tag => s.version.to_s }
  s.social_media_url = 'http://www.jianshu.com/u/d83ef9913d22'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WTCarouselFlowLayout/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WTCarouselFlowLayout' => ['WTCarouselFlowLayout/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
