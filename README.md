## Atomic Tomcat Image

This is a Tomcat 8.5.20 image created using RHEL-Atomic image. 

You will need a subcribed RHEL box to build this. You can go to [https://developers.redhat.com/](https://developers.redhat.com/) and register yourself. Then download RHEL and use your credentials to get developer subscriptions.

**Step 1:** Clone this repository

**Step 2:** Docker Build
```
docker build -t veermuchandi/atomic-tomcat .
```
**Step 3:** Run the image
```
docker run -p 8080:8080 -i -t veermuchandi/atomic-tomcat
```

------------

### Run on Minishift/OpenShift

1. Create an app
```
oc new-app https://github.com/VeerMuchandi/atomic-tomcat --name=atomicps
```

2. A build should start. Check the build logs

```
oc logs -f atomicps-1-build
```

3. Once he build is complete and the resultant image is successfully pushed into internal registry, the application gets deployed. Now create a route
```
oc expose svc atomicps --port 8080
```
Find the URL and test.
