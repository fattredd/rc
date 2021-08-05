#!/bin/bash

value=`cat test.txt`
echo $value

((value++))
echo $value > test.txt
