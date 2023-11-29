$TTL 86400
@ IN SOA ns1.teste.com. admin.teste.com. (
    2023112801 ; Serial
    3600       ; Refresh
    1800       ; Retry
    604800     ; Expire
    86400      ; Minimum
)

@            IN   NS   ns1.teste.com.

ns1          IN   A    192.168.56.10
www          IN   A    192.168.56.20
