
管理端口标签

查看端口标签
    semanage port –l
添加端口
    semanage port -a -t port_label-p tcp|udp PORT
    semanage port -a -t http_port_t -p tcp 9527
删除端口
    semanage port -d -t port_label-p tcp|udp PORT
    semanage port -d -t http_port_t -p tcp 9527
修改
    semanage port -m -t port_label-p tcp|udp PORT
    semanage port -m -t http_port_t-p tcp9527

