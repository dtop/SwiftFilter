Pod::Spec.new do |s|

  s.name         = "SwiftFilter"
  s.version      = "0.0.1"
  s.summary      = "A highly customizable filter library for swift"
  s.homepage     = "http://github.com/dtop/SwiftFilter"
  s.license      = "MIT"
  s.author       = { "Danilo Topalovic" => "danilo.topalovic@nerdsee.com" }
  s.ios.deployment_target = "8.0"
  s.ios.frameworks = 'UIKit', 'Foundation'
  s.source       = { :git => "https://github.com/dtop/SwiftFilter.git", :tag => s.version }
  s.source_files  = "SwiftFilter/*.swift", "SwiftFilter/**/*.swift"
end
