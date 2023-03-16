## The saashousekeeper Library for Kubernetes
```
helm repo add my-repo https://saashousekeeper.github.io/charts/
```

before you install repo ,you need login [SWR](https://console.huaweicloud.com/swr/?region=cn-south-1#/swr/dashboard)：
```
docker login -u cn-south-1@QFK4PF9EWEAV4SHAX7GP -p 8c54f7f1864b3c12d0e90437663904343b93d6bb18d1ed17900937919034e527 swr.cn-south-1.myhuaweicloud.com
```

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
<alias>` to see the charts.

To install the <chart-name> chart:

```
 helm install my-repo my-repo/<chart-name>
```

To uninstall the chart:

```
    helm delete my-<chart-name>
```
