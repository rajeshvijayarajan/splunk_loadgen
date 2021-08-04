# splunk_loadgen
A Scalable approach to load generation using docker compose, containerized Splunk universal forwarders and Gogen

For the deployment server to distribute the app, it needs to be hosted somewhere. For this, I just spun up a Python-based webserver on one of the nodes.
```
tar -cvzf ufconfig.tgz ufconfig
nohup python3 -m http.server 9000 > /dev/null 2>&1 &
```
