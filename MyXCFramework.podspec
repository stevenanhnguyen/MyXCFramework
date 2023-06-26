Pod::Spec.new do |spec|
  spec.name         = "MyXCFramework"
  spec.version      = "0.3"
  spec.summary      = "Framework for iOS and OS X."
  spec.description  = <<-DESC
    A description of your framework goes here.
  DESC
  spec.homepage     = "https://github.com/stevenanhnguyen/MyXCFramework"
  spec.authors      = { 'Anh Tú' => 'at.mrsteven@gmail.com' }
  spec.license      = "MIT"
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/stevenanhnguyen/MyXCFramework.git", :tag => spec.version }
  spec.vendored_frameworks = "MyXCFramework.xcframework"
  spec.swift_version = "5.0"
end
