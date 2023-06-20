# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Movies' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  use_modular_headers!
  inhibit_all_warnings!


  # Pods for Movies
  pod 'Alamofire'
  pod 'PromisedFuture', '1.0.1'
  pod 'SDWebImageSwiftUI'

end

# Post install dependency configuration.
post_install do |installer|
  # Build configuration
  installer.pods_project.build_configurations.each do |config|

    # Turn on Whole Module Optimization for Release
    # This results in longer build time but it optimizes generic functions in separate files.
    if config.name == 'Release'
      config.build_settings['SWIFT_COMPILATION_MODE'] = 'wholemodule'
    end

    # Enable Localization analyzer for all pods
    config.build_settings['CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED'] = 'YES'
    config.build_settings['CLANG_ANALYZER_LOCALIZABILITY_EMPTY_CONTEXT'] = 'YES'
  end

  # Enabling Base Internationalization
  installer.pods_project.root_object.known_regions = ['Base', 'en']

  # This will ensure localized resources are placed in "en.lproj" directories instead of deprecated "English.lproj" directories.
  installer.pods_project.root_object.development_region = 'en'
end

