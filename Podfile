# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GLITMDB' do
  use_frameworks!
  use_frameworks!
  inhibit_all_warnings!

  def user_interface
    pod 'SkeletonView', :git => 'https://github.com/Juanpe/SkeletonView', :tag => '1.8.2'
    pod 'IQKeyboardManagerSwift', '~> 6.5.6'
    pod 'NVActivityIndicatorView'
  end

  def utilities
    pod 'RxSwift', '~> 5.1.3'
    pod 'RxCocoa', '~> 5.1.3'
    pod 'RxBlocking', '~> 5.1.3'
    pod 'Swinject', '2.8.0'
    pod 'Kingfisher', '~> 6.3.1'
  end
  
  def unit_test_dependencies
    pod 'Swinject', '2.8.0'
    pod 'Cuckoo', '1.7.1'
    pod 'RxSwift', '~> 5.1.3'
    pod 'RxCocoa', '~> 5.1.3'
    pod 'RxBlocking', '~> 5.1.3'
  end
  user_interface
  utilities

  # Pods for GLITMDB

  target 'GLITMDBTests' do
    inherit! :search_paths
    # Pods for testing
    unit_test_dependencies
  end

  target 'GLITMDBUITests' do
    # Pods for testing
    unit_test_dependencies
  end

end
