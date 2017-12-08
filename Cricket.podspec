Pod::Spec.new do |s|
  s.name             = 'Cricket'
  s.version          = '0.1.3'
  s.summary          = 'Report bugs and feedback from within your app'
  s.description      = <<-DESC
  Cricket allows you to report bugs or submit feedback directly from within your
  app. Users can annotate a screenshot of your app and write a message. The
  message, screenshot and other app meta data are then submitted via email. You
  can also customize your own handlers if you don't want to use email.
                       DESC
  s.homepage         = 'https://github.com/nebs/Cricket'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nebojsa Petrovic' => 'nebspetrovic@gmail.com' }
  s.source           = { :git => 'https://github.com/nebs/Cricket.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/nebsp'
  s.ios.deployment_target = '8.0'
  s.source_files = 'Cricket/Classes/**/*'
  s.dependency 'SnapKit', '~> 3.1.2'
end
