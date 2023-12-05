require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "builder-amazon-pay-integration"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "11.0" }
  s.source       = { :git => "https://github.com/metehanakbaba/builder-amazon-pay-integration.git", :tag => "main" }

  s.source_files = "ios/**/*.{h,m,mm,swift}"

  s.dependency "React"
  s.dependency "PayFortSDK"

end
