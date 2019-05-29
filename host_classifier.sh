#!/bin/bash

#assignment #3 ...rename to host_classifier.sh
#This script should accept one or more filenames as arguments
#The files will be stored in my home directory
# /home/ipa/corp.encore.tech/kevin.whelan/files/assignment3/*
#                                       ~/files/assignment3/*

#We will call the script and pass file(s) ...as Example:
#One File
#host_classifier.sh ~/files/assignment3/host_inventory2.txt
#One File with wildcard
#host_classifier.sh ~/files/assignment3/*2*
#All Files using wildcard only
#host_classifier.sh ~/files/assignment3/*

#This varible will be used to print the filenames without the directory

#####Initialize Variables#####
 prod_env_count=0
 dev_env_count=0
 other_env_count=0

 win_os_count=0
 lin_os_count=0
 other_os_count=0

#####Primary Script#####

#1stWhile
#The "1stWhile" loop shifts to each file input addressing the multiple files requirement.
while [ "$1" != "" ]
 do
 #prints the current filename excluding the path.  I'm sure there's a better way.
  echo =========================
  filename=$(echo $1 | cut --delimiter "/" --fields 8)
  echo "File =" $filename
  echo "Containing servers named:"
  echo =========================

  #2ndWhile
  #The "2ndWhile" we read and print each line of current file input from when we ran script ... 
  #... and then handle the various OS and Environment counts with "cases".

  while IFS= read -r line
   do
    echo "$line"

    #1stCase   
    #For each hostname you should classify the host by environment: 
    #Environment = Production
    #Environment = Development
    #Environment = Other (if it isn't Production or Development)
    #Keep a count of the total number of hosts for each environment type
    case "$line" in
     usoh4p*)
      prod_env_count=$((prod_env_count  + 1))
      ;;
     usoh4d*)
      dev_env_count=$((dev_env_count + 1))
      ;;
     *)
      other_env_count=$((other_env_count + 1))
      ;;
     esac

    #2ndCase
    #For each hostname you should classify the host by OS:
    #OS = Windows
    #OS = Linux
    #OS = Other (if it isn't windows or linux)
    #For each hostname you should classify the host by OS type
    case "$line" in
     usoh4?w*)
      win_os_count=$((win_os_count  + 1))
      ;;
     usoh4?l*)
      lin_os_count=$((lin_os_count + 1))
      ;;
     *)
      other_os_count=$((other_os_count + 1))
      ;;
     esac
  done < "$1"

shift
done

#####Results#####
#Print out the total counts for environment type and os type for this file in the following format
  echo ===Env Count All Files====
  echo "Prod  env Count =" $prod_env_count
  echo "Dev   env Count =" $dev_env_count
  echo "Other env Count =" $other_env_count
  echo ===OS  Count All Files====
  echo "Win   os  Count =" $win_os_count
  echo "Linux os  Count =" $lin_os_count
  echo "Other os  Count =" $other_os_count
