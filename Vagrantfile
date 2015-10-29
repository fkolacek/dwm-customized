# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.provider :libvirt do |libvirt|
    libvirt.socket = "/var/run/libvirt/libvirt-sock"
  end

  config.vm.define :vm1 do |vm1|
    vm1.vm.box = "fedora-22-workstation-x86_64"
    vm1.vm.provision :shell, path: "bootstrap.sh"
    vm1.vm.synced_folder './', '/vagrant', type: 'rsync'

    vm1.vm.provider :libvirt do |domain|
      domain.driver = "kvm"
      domain.video_type = "vga"
      domain.graphics_port = 5901
      domain.graphics_ip = '0.0.0.0'
    end
  end
end
