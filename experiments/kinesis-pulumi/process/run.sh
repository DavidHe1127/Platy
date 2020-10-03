#!/bin/bash

OPERATION=$1

AWS_PROFILE=qq pulumi ${OPERATION} --logtostderr -v=9 2> out.txt
