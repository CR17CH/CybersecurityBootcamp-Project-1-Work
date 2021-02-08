---
 - name: Configure Elk VM with Docker
   hosts: ElkServers
   remote_user: RedAdmin
   become: true
   tasks:
     - name: Install docker.io
       apt:
          update_cache: yes
          name: docker.io
          state: present

     - name:
       apt:
          force_apt_get: yes
          name: python3-pip
          state: present

     - name: install Docker Python Module
       pip:
         name: docker
         state: present


     - name: Use more memory
       sysctl:
         name: vm.max_map_count
         value: "262144"
         state: present
         reload: yes

     - name: download and launch a docker elk container
       docker_container:
         name: elk
         image: sebp/elk:761
         state: started
         restart_policy: always
         published_ports:
           - 5601:5601
           - 9200:9200
           - 5044:5044

