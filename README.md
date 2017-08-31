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


