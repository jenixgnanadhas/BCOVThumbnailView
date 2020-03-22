Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "BCOVThumbnailView"
s.summary = "This Shows a Thumbnail in Your Player"
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Jenix Gnanadhas" => "Jenix_Gnanadhas@Infosys.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/jenixgnanadhas/BCOVThumbnailView"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/jenixgnanadhas/BCOVThumbnailView.git", 
             :tag => "#{s.version}" }

# 7
s.framework = "UIKit"
s.dependency 'Brightcove-Player-Core/dynamic'
s.dependency 'Kingfisher', '~> 5.0'

# 8
s.source_files = "BCOVThumbnailView/**/*.{swift}"

# 9
#s.resources = "BCOVThumbnailView/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "4.2"

end