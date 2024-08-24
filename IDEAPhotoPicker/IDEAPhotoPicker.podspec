Pod::Spec.new do |spec|
    spec.name               = "IDEAPhotoPicker"
    spec.version            = "3.3.1-IDEA"
    spec.summary            = "照片/视频选择器 - 支持LivePhoto、GIF图片选择、自定义编辑照片/视频、3DTouch预览、浏览网络图片/网络视频 功能 - Imitation weibo photo/image picker - support for LivePhoto, GIF image selection, 3DTouch preview, browse the web image function"
    spec.homepage           = "https://github.com/SilenceLove/HXPhotoPicker"
    spec.license            = { :type => "MIT", :file => "LICENSE" }
    spec.author             = { "SilenceLove" => "294005139@qq.com" }
    
    spec.swift_versions     = ['5.0']
    spec.platform               = :ios, "10.0"
    spec.ios.deployment_target  = "10.0"
    # spec.source             = { :git => "https://github.com/SilenceLove/HXPhotoPicker.git", :tag => "#{spec.version}" }
    spec.source             = { :path => "." }

    spec.framework          = 'UIKit','Photos','PhotosUI'
    spec.requires_arc       = true
#    spec.default_subspec    = 'Full'
    
    spec.ios.pod_target_xcconfig      = {
                                      'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.PhotoPicker',
                                      'ENABLE_BITCODE'            => 'NO',
                                      'SWIFT_VERSION'             => '5.0',
                                      'EMBEDDED_CONTENT_CONTAINS_SWIFT'       => 'NO',
                                      'ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES' => 'NO',
                                      'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
                                    }
    spec.osx.pod_target_xcconfig      = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.PhotoPicker-OSX' }
    spec.watchos.pod_target_xcconfig  = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.PhotoPicker-watchOS' }
    spec.tvos.pod_target_xcconfig     = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.idea.PhotoPicker-TV' }

    spec.pod_target_xcconfig          = {
      'GCC_PREPROCESSOR_DEFINITIONS'  => [
                                            ' MODULE=\"IDEAPhotoPicker\" ',
                                            ' BUNDLE=\"IDEAPhotoPicker\" ',
                                            ' FRAMEWORK=\"IDEAPhotoPicker\" '
                                          ]
                                    }

    spec.public_header_files  = 'HXPhotoPicker/**/*.h'
    spec.source_files         = "HXPhotoPicker/**/*.{h,m}"
    spec.resources            = "HXPhotoPicker/Resources/*.{bundle}"

end
