Pod::Spec.new do |spec|
  spec.name         = "IDEANavigationBar"
  spec.version      = "1.0.0"
  spec.summary      = "IDEANavigationBar"
  spec.description  = "IDEANavigationBar"
  spec.homepage     = "https://github.com/miniwing"
  spec.license      = "MIT"
  spec.author       = { "Harry" => "miniwing.hz@gmail.com" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :path => "." }
  
  spec.ios.pod_target_xcconfig     = {
                                    'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEANavigationBar',
                                    'ENABLE_BITCODE'            => 'NO',
                                    'SWIFT_VERSION'             => '5.0',
                                    'EMBEDDED_CONTENT_CONTAINS_SWIFT'       => 'NO',
                                    'ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES' => 'NO',
                                    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
                                  }
  spec.osx.pod_target_xcconfig     = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEANavigationBar' }
  spec.watchos.pod_target_xcconfig = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEANavigationBar-watchOS' }
  spec.tvos.pod_target_xcconfig    = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.IDEANavigationBar' }

#  spec.dependency 'AFNetworking'
#  spec.dependency 'RegexKitLite'
#  spec.dependency 'YYKit'

spec.public_header_files   = 'IDEANavigationBar/**/*.h'
spec.source_files          = 'IDEANavigationBar/**/*.{h,m}'
  
#  spec.resource                   = "HXPhotoPicker/HXPhotoPicker.bundle"
  
   pch_app_kit = <<-EOS
   
#ifdef DEBUG
#  ifndef LogDebug
#     define LogDebug(x)            NSLog  x
#  endif /* LogDebug */
#else
#  define LogDebug(x)
#endif

  EOS
  spec.prefix_header_contents = pch_app_kit
      
end
