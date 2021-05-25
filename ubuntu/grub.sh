sudo sed -i 's%^GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"$%GRUB_CMDLINE_LINUX_DEFAULT=""%' /etc/default/grub
sudo update-grub2
