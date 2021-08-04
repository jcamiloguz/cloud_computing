Vagrant.configure("2") do |config|
  config.vm.define :clienteUbuntu do |clienteUbuntu|
    clienteUbuntu.vm.box = "bento/ubuntu-20.04"
    clienteUbuntu.vm.network :private_network, ip: "192.168.100.2"
    clienteUbuntu.vm.hostname = "clienteUbuntu"
    clienteUbuntu.vm.provider :virtualbox do |vb|
      vb.gui = true
    end
  end
  config.vm.define :servidorUbuntu do |servidorUbuntu|
    servidorUbuntu.vm.box = "bento/ubuntu-20.04"
    servidorUbuntu.vm.network :private_network, ip: "192.168.100.3"
    servidorUbuntu.vm.hostname = "servidorUbuntu"
    servidorUbuntu.vm.provision :shell, path: "bootstrap.sh"
    servidorUbuntu.vm.network :forwarded_port, guest: 80, host: 4567
    servidorUbuntu.vm.synced_folder "shared/", "/shared/"
    servidorUbuntu.vm.provider :virtualbox do |vb|
      vb.gui = true
    end
  end
end