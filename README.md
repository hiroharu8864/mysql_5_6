mysql Cookbook
==============
Install mysql5.6 RPM to Vegrant(CentOS 6.5)  

VagrantのCentOS 6.5環境にmysql5.6をインストールし、monitによる監視を行う。  
コミュニティクックブックとして、yum-epelを利用する。


Requirements
------------
$ vagrant box add base64 CentOS-6.5-x86_64-v20140110.box
```json
{
  "run_list":[
    "recipe[yum-epel]",
    "recipe[mysql::default]",
    "recipe[mysql::mysql]",
    "recipe[mysql::monit]"
  ]
}

```

コミュニティクックブックを活用する。  
$ berks vendor cookbooks

License and Authors
-------------------
Authors: Hiroharu Tanaka
