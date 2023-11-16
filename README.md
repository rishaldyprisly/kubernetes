### Boilerplate / Monitoring Stack
- This tools are prepared by @rishaldy7
- This file runs on Docker Compose V3 or newer versions
- This file will creates docker stack to monitor single or multiple servers / nodes.
- The purpose of this file is to make your DevOps tasks easier and faster.
- This file can be executed directly from terminal or Portainer

# Inside Boiler Plate

![Alt text](relative%20monitoring-stack/boilerplate.png?raw=true "Boilerplate")




###Prometheus

> Prometheus is log manager that used as main log collector or manager. All of running instances log must be sent to Prometheus before you can visualize or monitor the status of the instance with Grafana or any other softwares


###CAdvisor

> CAdvisor or Container Advisor is a small tool that collect all of instance health status. CAdvisor will store all of the instance anomaly which the data must be used to conduct audits, monitoring, and more. The instance health that will be colected such as:
1.  When the containers are consuming almost all of allocated CPU or memory.
2. When the containers are experiencing traffic spike / concurrent anomaly
3. When the contiainers is being killed by humans or by the Orchestrator like Kubernetes or by the Docker Engine itself

###Grafana
> Grafana is a tool to visualize all of the log and instances health status in real time. Please note that Grafana needs Prometheus to work. Once Prometheus is up, you can grab all of the data collected by Prometheus to be visualized in Grafana

###Node Exporter
> Node Exporter is a tool to export every log in the main server / host / nodes. Almost the same as CAdvisot, Node Exporter will grab any essentials data like Kernel Status, CPU consumption, Swap Memory

###Ports
|        Tools        | Node Ports  | Continer Ports  | Volumes |
| :-----------:|:----------:|:------------:|:-----:|
| Prometheus      |      9090      |        9090        | Isolated |
| CAdvisor          |      8080      |        8080        | Host/ReadOnly
| Node Exporter  |       9100      |         9100        | Host/ReadOnly
| Grafana           |      3000       |        3000        | Isolated |

If you are preparing a server / node from scratch, you may chose different ports as well, please consult or read more about port alocation depending on specific tools / software you will use as well.


###Other Configuration

####Node

File location: `/etc/prometheus/prometheus.yml`

```yml
global:
  scrape_interval: 15s
  #This scrape_interval tells Prometheus to always scrap the data every 15 seconds

scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
	  #Prometheus can also scrape its own log

  - job_name: 'node_exporter'
    scrape_interval: 5s
    static_configs:
      - targets: ['node_exporter:9100']
        labels:
          alias: "node_exporter"
		  #Grab data collected by Node Exporter

  - job_name: 'cadvisor'
    scrape_interval: 5s
    static_configs:
      - targets: ['cadvisor:8080']
        labels:
          alias: "cadvisor"
		  #Grab data collected by CAdvisor
```

###Things To Consider

> Until now, Prometheus, CAdvisor, and Node Exporter don't have an authentication method to visit their web application interface, please use the BoilerPlate if only you know what you're doing

