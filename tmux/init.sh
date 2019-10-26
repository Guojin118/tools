#!/bin/bash
# 该脚本用于开机初始化tmux服务

#setup catalog working environment
  tmux new -s catalog -d # 后台创建一个名称为init的会话
  tmux rename-window -t "catalog:1" python3 # 重命名init会话的第一个窗口名称为service
  tmux send -t "catalog:python3" "cd ~; source catalog/bin/activate" Enter # 切换到指定目录并运行python服务

  # create django window
  tmux neww -a -n django -t catalog # neww means new window
  tmux send -t "catalog:django" 'cd ~; source catalog/bin/activate; cd ~/work/data_catalog/; python manage.py runserver 0.0.0.0:3000' Enter 
  # create webpack window
  tmux neww -a -n webpack -t catalog # neww means new window
  tmux send -t "catalog:webpack" "cd ~/work/data_catalog/; ./node_modules/.bin/webpack --config webpack.config.js --watch" Enter # 运行weinre调试工具

  # create elasticsearch window
  tmux neww -a -n es -t catalog # neww means new window
  tmux send -t "catalog:es" "cd ~/elasticsearch/elasticsearch-7.4.0/bin/; ./elasticsearch" Enter # 运行weinre调试工具
  # create new panel kibana
  tmux split-window -t "catalog:es" # 默认上下分屏
  tmux send -t "catalog:es" "cd ~/elasticsearch/kibana/bin; ./kibana" Enter 

  # create home window
  tmux neww -a -n home -t catalog # neww means new window
  tmux send -t "catalog:home" "cd ~/; " Enter #
  # create new panel kibana
  tmux split-window -t "catalog:home" # 默认上下分屏
  tmux send -t "catalog:home" "cd ~/work/data_catalog/" Enter 

  # create home window
  #tmux neww -a -n shadowsock -t catalog # neww means new window
  #tmux send -t "catalog:shadowsock" "sslocal -c /etc/shadowsocks.json" Enter #

  
  #attach to catalog session
  #tmux at -t catalog


