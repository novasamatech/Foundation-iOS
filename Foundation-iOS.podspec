Pod::Spec.new do |s|
  s.name             = 'Foundation-iOS'
  s.version          = '1.1.1'
  s.summary          = 'Implementation of commonly used algorithms to avoid boilerplate code.'

  s.description      = 'Library contains implementation of commonly used algorithms to reduce duplicated and boilerplate code.'

  s.homepage         = 'https://github.com/novasamatech/Foundation-iOS'
  s.license          = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author           = { 'Ruslan Rezin' => 'ruslan@novawallet.io' }
  s.source           = { :git => 'https://github.com/novasamatech/Foundation-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'

  s.swift_version = '5.0'

  s.frameworks = 'UIKit'

  s.subspec 'Localization' do |lc|
      lc.dependency 'Keystore-iOS', '~> 1.0.0'
      lc.source_files = 'Foundation-iOS/Classes/Localization/**/*'
  end

  s.subspec 'Timer' do |tm|
      tm.dependency 'Foundation-iOS/NotificationHandlers'
      tm.source_files = 'Foundation-iOS/Classes/Timer/**/*'
  end

  s.subspec 'NotificationHandlers' do |nh|
      nh.source_files = 'Foundation-iOS/Classes/NotificationHandlers/**/*'
  end

  s.subspec 'QueryProcessing' do |qp|
      qp.source_files = 'Foundation-iOS/Classes/QueryProcessing/**/*'
  end

  s.subspec 'DateProcessing' do |dp|
      dp.dependency 'Foundation-iOS/Localization'
      dp.source_files = 'Foundation-iOS/Classes/DateProcessing/**/*'
  end

  s.subspec 'NumberProcessing' do |np|
      np.source_files = 'Foundation-iOS/Classes/NumberProcessing/**/*'
  end

  s.subspec 'ViewModel' do |vm|
      vm.source_files = 'Foundation-iOS/Classes/ViewModel/**/*'
  end
  
  s.subspec 'SecureSession' do |ss|
      ss.source_files = 'Foundation-iOS/Classes/SecureSession/**/*'
  end
  
  s.subspec 'WalletMigration' do |wm|
      wm.dependency 'Foundation-iOS/SecureSession'
      wm.source_files = 'Foundation-iOS/Classes/WalletMigration/**/*'
  end

  s.test_spec do |ts|
      ts.source_files = 'Tests/**/*.swift'
      ts.dependency 'Cuckoo'
  end

end
