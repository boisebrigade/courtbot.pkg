Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.network "private_network", type: "dhcp"

  config.vm.define "courtbot" do |courtbot|
    courtbot.vm.network "private_network", ip: "192.168.50.10"
    courtbot.vm.hostname = "courtbot"

    courtbot.vm.synced_folder "dist/", "/tmp/dist", type: "rsync"

    courtbot.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioner/courtbot-playbook.yml"
    end

    courtbot.vm.network "forwarded_port", guest: 4000, host: 4010
  end

  config.vm.define "postgres" do |psql|
    psql.vm.network "private_network", ip: "192.168.50.50"
    psql.vm.hostname = "postgres"

    psql.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioner/postgres-playbook.yml"
    end
  end
end
