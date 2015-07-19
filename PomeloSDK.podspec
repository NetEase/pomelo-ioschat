Pod::Spec.new do |s|
  s.name             = "PomeloSDK"
  s.version          = "0.1.0"
  s.summary          = "NetEase Pomelo client For iOS. Fork by little2s."
  s.homepage         = "https://github.com/little2s/pomelo-ioschat"
  s.license          = "MIT"
  s.author           = { "little2s" => "duanyinglun@gmail.com" }
  s.source           = { :git => "https://github.com/little2s/pomelo-ioschat.git", :tag => s.version }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pomelo/**/*.{h.m}'
  s.public_header_files = 'Pomelo/**/*.h'

  s.dependency 'socket.IO', '0.5.2'
end
