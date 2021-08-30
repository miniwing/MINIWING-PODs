Pod::Spec.new do |s|
  s.name        = "ollvm"
  s.version     = "12.x"
  s.summary     = "ollvm library"
  s.homepage    = "https://www.github.com/miniwing"
  s.license     = "MIT"
  s.author      = { "Harry" => "miniwing.hz@gmail.com" }
  
  s.ios.deployment_target   = '10.0'
  s.source                  = { :path => "." }
  s.ios.vendored_libraries = 'libclang_rt.ios.a'
#  s.ios.libraries           = 'z'

end
