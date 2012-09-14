Vagrant::Config.run do |config|
  config.vm.box       = 'precise32'
  config.vm.box_url   = 'http://files.vagrantup.com/precise32.box'
  config.vm.host_name = 'qs-dev-box'

  (8183..8200).each do |port|
    config.vm.forward_port port, port
  end

  config.vm.provision :puppet,
    :manifests_path => 'puppet/manifests',
    :module_path    => 'puppet/modules'

  config.ssh.forward_agent = true
end
