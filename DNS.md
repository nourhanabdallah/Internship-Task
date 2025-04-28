1.  Verify DNS Resolution:
* `   cat /etc/resolv.conf` :

  
 ![image](https://github.com/user-attachments/assets/437cee1a-6007-4a21-ab87-388feb42a1e4)

![image](https://github.com/user-attachments/assets/4f074554-6022-442e-a402-dd76c22f5ea9)
  
![image](https://github.com/user-attachments/assets/489cee8c-67dc-4303-8da4-e5d7c7026637)

Expected behavior:

If dig using /etc/resolv.conf (internal DNS server) fails, but 8.8.8.8 also fails → DNS record missing.

If internal DNS fails but public DNS works → system DNS misconfigured.



`Both myDNS and google dns doesn't find it as its not really found public and if it is internal it would appear in mytDNS resolve.com`
* after adding internal domain locally :


![image](https://github.com/user-attachments/assets/7e83c94a-ca1a-4177-aabc-58a6947c6c21)

 


2.   Diagnose Service Reachability:
   
      `netstat -ltpn | grep 80`
     
     ` netstat -ltpn | grep 80`
     
     ` ps aux | grep webservice`

3.   Trace the Issue – List All Possible Causes


`DNS | Missing A record in DNS server`

`DNS | Wrong nameserver in /etc/resolv.conf`

`DNS | Internal DNS service (named) is DOWN`

`Network | Firewall blocking port 80/443`

`Network | IP address of the server changed`

`Network | Routing issue between clients and server`

`Service | Web service (Apache, Nginx) not running`

`Service | Web service bound to wrong IP`

`Local | Wrong entry in /etc/hosts overriding DNS`

4.  Propose and Apply Fixes



(A) Missing DNS Record
How to check: dig internal.example.com returns NXDOMAIN.

Fix: Add A record in DNS zone file.

Command to fix (if using BIND):

sudo nano /var/named/example.com.zone


internal  IN  A  192.168.204.10

sudo systemctl restart named
✅ Validate:

![image](https://github.com/user-attachments/assets/c5a15086-4a54-43c6-9a40-4b22e8c39d21)

(B) Wrong DNS Server in resolv.conf


![image](https://github.com/user-attachments/assets/bc4564db-8eb2-42ce-afd7-00346d327029)


(C) Firewall Blocking Port

stop firewall to check if passed ,then start again and set permission 

(D) Web Server Not Running

systemctl status httpd
systemctl status nginx


(E) Wrong /etc/hosts Entry

![image](https://github.com/user-attachments/assets/e168c75a-ba6c-4cda-a532-c24c2381d776)








       
