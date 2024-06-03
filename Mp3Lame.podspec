
Pod::Spec.new do |s|
  s.name             = 'Mp3Lame'
  s.version          = '3.100'
  s.summary          = 'A short description of Mp3Lame.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = "https://github.com/chaichai9323/#{s.name}"
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chaichai9323' => 'chailintao@laien.io' }
  s.source           = { :git => "https://github.com/chaichai9323/#{s.name}.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.static_framework = true
  
  s.ios.deployment_target = '13.0'

  source_dir = "lame-#{s.version}"

  puts source_dir
  
  s.source_files = "#{source_dir}/libmp3lame/*.{h,c}", "#{source_dir}/mpglib/*.{h,c}", "#{source_dir}/include/lame.h", "#{source_dir}/config.h"
  
  s.public_header_files = "#{source_dir}/config.h", "#{source_dir}/include/lame.h"
  # s.frameworks = 'UIKit', 'MapKit'

  s.pod_target_xcconfig = {
    'GCC_PREPROCESSOR_DEFINITIONS' => 'HAVE_CONFIG_H'
  }
end
