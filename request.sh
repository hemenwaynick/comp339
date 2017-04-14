#!/bin/bash
for i in `seq 1 1000`;
do
    curl 10.11.12.50:80/posts/2
done
