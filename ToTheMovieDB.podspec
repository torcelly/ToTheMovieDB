Pod::Spec.new do |s|
  s.name         = "ToTheMovieDB"
  s.version      = "0.0.1"
  s.summary      = "Simple swift wrapper to themoviedb.org."
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.description  = <<-DESC
			Simple swift wrapper to themoviedb.org
			(https://www.themoviedb.org/documentation/api)
                  DESC

  s.homepage         = "https://github.com/torcelly/ToTheMovieDB"
  # s.screenshots    = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.author           = { "Fernando Torcelly" => "fernando@torcelly.com" }
  s.social_media_url = "http://twitter.com/torcelly"
  s.source           = { :git => "https://github.com/torcelly/ToTheMovieDB.git", :tag => "#{s.version}" }

  s.platform         = :ios
  s.requires_arc     = true

  s.dependency 	     'Alamofire', '~> 4.5'
  s.dependency       'AlamofireObjectMapper', '~> 4.1'

  s.source_files     = 'Source/*.swift'
  s.frameworks       = 'UIKit'

  s.ios.deployment_target = '8.0'

end
