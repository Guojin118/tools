Install the Command Line Client
If you prefer command line client, then you can install it on your Linux with the following command.

Debian
sudo apt-get install python-pip
sudo pip install shadowsocks
Ubuntu
Yes, you can use the above commands to install shadowsocks client on ubuntu. But it will install it under ~/.local/bin/ directory and it causes loads of trouble. So I suggest using su to become root first and then issue the following two commands.

apt-get install python-pip
pip install shadowsocks
Fedora/Centos
sudo yum install python-setuptools   or   sudo dnf install python-setuptools
sudo easy_install pip
sudo pip install shadowsocks
OpenSUSE
sudo zypper install python-pip
sudo pip install shadowsocks
Archlinux
sudo pacman -S python-pip
sudo pip install shadowsocks
As you can see the command of installing shadowsocks client is the same to the command of installing shadowsocks server, because the above command will install both the client and the server. You can verify this by looking at the installation script output

Downloading/unpacking shadowsocks
Downloading shadowsocks-2.8.2.tar.gz
Running setup.py (path:/tmp/pip-build-PQIgUg/shadowsocks/setup.py) egg_info for package shadowsocks

Installing collected packages: shadowsocks
Running setup.py install for shadowsocks

Installing sslocal script to /usr/local/bin
Installing ssserver script to /usr/local/bin
Successfully installed shadowsocks
Cleaning up...
sslocal is the client software and ssserver is the server software. On some Linux distros such as ubuntu, the shadowsocks client sslocal is installed under /usr/local/bin. On Others such as Arch sslocal is installed under /usr/bin/. Your can use whereis command to find the exact location.

user@debian:~$ whereis sslocal
sslocal: /usr/local/bin/sslocal
Create a Configuration File
we will create a configuration file under /etc/

sudo vi /etc/shadowsocks.json
Put the following text in the file. Replace server-ip with your actual IP and set a password.

{
"server":"server-ip",
"server_port":8000,
"local_address": "127.0.0.1",
"local_port":1080,
"password":"your-password",
"timeout":600,
"method":"aes-256-cfb"
}
Save and close the file. Next start the client using command line

sslocal -c /etc/shadowsocks.json
To run in the background
sudo sslocal -c /etc/shadowsocks.json -d start
Auto Start the Client on System Boot
Edit /etc/rc.local file

sudo vi /etc/rc.local
Put the following line above the exit 0 line:

sudo sslocal -c /etc/shadowsocks.json -d start
Save and close the file. Next time you start your computer, shadowsocks client will automatically start and connect to your shadowsocks server.

Check if It Works
After you rebooted your computer, enter the following command in terminal:

sudo systemctl status rc-local.service
If your sslocal command works then you will get this ouput:

● rc-local.service - /etc/rc.local Compatibility
Loaded: loaded (/etc/systemd/system/rc-local.service; enabled; vendor preset: enabled)
Active: active (running) since Fri 2015-11-27 03:19:25 CST; 2min 39s ago
Process: 881 ExecStart=/etc/rc.local start (code=exited, status=0/SUCCESS)
CGroup: /system.slice/rc-local.service
├─ 887 watch -n 60 su matrix -c ibam
└─1112 /usr/bin/python /usr/local/bin/sslocal -c /etc/shadowsocks....
As you can see from the last line, the sslocal command created a process whose pid is 1112 on my machine. It means shadowsocks client is running smoothly. And of course you can tell your browser to connect through your shadowsocks client to see if everything goes well.

If for some reason your /etc/rc.local script won’t run, then check the following post to find the solution.
