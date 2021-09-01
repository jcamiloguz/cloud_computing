Vagrant.configure("2") do |config|
  config.vm.define :loadBalancer do |loadBalancer|
    loadBalancer.vm.box = "bento/ubuntu-20.04"
    loadBalancer.vm.network :private_network, ip: "192.168.100.2"
    loadBalancer.vm.hostname = "loadBalancer"
    loadBalancer.vm.synced_folder "shared/", "/shared/"
    loadBalancer.vm.provision "shell", path: "./loadBalancerScript.sh"
  end
  config.vm.define :servidor1 do |servidor1|
    servidor1.vm.box = "bento/ubuntu-20.04"
    servidor1.vm.network :private_network, ip: "192.168.100.3"
    servidor1.vm.hostname = "servidor1"
    servidor1.vm.synced_folder "shared/", "/shared/"
    servidor1.vm.provision "shell", path: "./serverScript.sh", :args => "web1 192.168.100.3 0"
  end
  config.vm.define :servidor2 do |servidor2|
    servidor2.vm.box = "bento/ubuntu-20.04"
    servidor2.vm.network :private_network, ip: "192.168.100.4"
    servidor2.vm.hostname = "servidor2"
    servidor2.vm.synced_folder "shared/", "/shared/"
    servidor2.vm.provision "shell", path: "./serverScript.sh", :args => "web2 192.168.100.4 0"
    end
  config.vm.define :backup1 do |backup1|
    backup1.vm.box = "bento/ubuntu-20.04"
    backup1.vm.network :private_network, ip: "192.168.100.5"
    backup1.vm.hostname = "backup1"
    backup1.vm.synced_folder "shared/", "/shared/"
    backup1.vm.provision "shell", path: "./serverScript.sh", :args => "webBackup1 192.168.100.5 0"
    end
  config.vm.define :backup2 do |backup2|
    backup2.vm.box = "bento/ubuntu-20.04"
    backup2.vm.network :private_network, ip: "192.168.100.6"
    backup2.vm.hostname = "backup2"
    backup2.vm.synced_folder "shared/", "/shared/"
    backup2.vm.provision "shell", path: "./serverScript.sh", :args => "webBackup2 192.168.100.6 1"
    end
  end