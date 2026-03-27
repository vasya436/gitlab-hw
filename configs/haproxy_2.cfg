global
    log /dev/log	local0
    log /dev/log	local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 30s
    user haproxy
    group haproxy
    daemon

defaults
    log	global
    mode	http
    option	httplog
    option	dontlognull
    timeout connect 5000
    timeout client  50000
    timeout server  50000

listen stats
    bind :8888
    mode http
    stats enable
    stats uri /stats
    stats refresh 5s
    stats realm Haproxy\ Statistics

frontend http_in
    bind *:80
    acl is_example_local hdr(host) -i example.local
    use_backend weighted_backend if is_example_local
    default_backend default_backend

backend weighted_backend
    mode http
    balance roundrobin
    server server1 127.0.0.1:8001 weight 2 check
    server server2 127.0.0.1:8002 weight 3 check
    server server3 127.0.0.1:8003 weight 4 check

backend default_backend
    mode http
    http-request deny deny_status 403
