#!/bin/bash

# login dockerhub & push the image 
docker login -u $DOCKERHUBUSER -p $DOCKERHUBPSW
docker tag muthu:$BUILD_NUMBER muthummkdh/nginx:$BUILD_NUMBER
docker push muthummkdh/nginx:$BUILD_NUMBER
