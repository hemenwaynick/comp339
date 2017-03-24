#!/bin/bash
for i in `seq 1 1000`;
do
    curl http://localhost:3000/posts/2
done
