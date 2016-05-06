platform :ios, '8.0'
xcodeproj 'FastenTest'

inhibit_all_warnings!

def data_pods
  pod 'EasyMapping', '~> 0.15.3'
  pod 'UICKeyChainStore', '~> 2.1'
  pod 'SHEmailValidator', '~> 1.0'
end

def network_pods
  pod 'SocketRocket', '~> 0.5'
end

def ui_pods
  pod 'UIAlertView+Blocks'
  pod 'PureLayout'
end

target 'FastenTest' do
  data_pods
  network_pods
  ui_pods
end

target 'FastenTestTests' do
    data_pods
end

