#!/bin/bash
# This script is designed to save a user's current page to a cookie
# then output the contents of the page the user is currently on.
# Team:
# Yujin Chung
# Jason Liu
# Minkyu Park
# Steven Tran
#
# How to run the sh file:
# ./cookiesfoobar.sh

# Create .json that includes both the page set to 1 and username set to foo
http --session=./foo.json "https://httpbin.org/cookies/set?page=1&username=foo"

# Getting the page number with jq to http in JSONPlaceholder
foo=$(jq --raw-output '.cookies.page.value//empty' foo.json)
http "jsonplaceholder.typicode.com/posts?_page=$foo&_limit=5"

# Change the page value of foo.json from 1 to 2
http --session=./foo.json "https://httpbin.org/cookies/set?page=2"

# Getting the page number with jq to http in JSONPlaceholder
foo=$(jq --raw-output '.cookies.page.value//empty' foo.json)
http "jsonplaceholder.typicode.com/posts?_page=$foo&_limit=5"

# Create a new .json file for username bar where page is set to 3
http --session=./bar.json "https://httpbin.org/cookies/set?page=3&username=bar"

# Using the jq command look into both files to see their page number
# foo.json should print out 2 while bar.json should print out 3
foo=$(jq --raw-output '.cookies.page.value//empty' foo.json)
bar=$(jq --raw-output '.cookies.page.value//empty' bar.json)
http "jsonplaceholder.typicode.com/posts?_page=$foo&_limit=5"
http "jsonplaceholder.typicode.com/posts?_page=$bar&_limit=5"

# Change bar's page number from 3 to 4
http --session=./bar.json "https://httpbin.org/cookies/set?page=4"

#viii. Once again check both files and see if they return the right page number
# foo.json should print out 2 while bar.json should print out 4
foo=$(jq --raw-output '.cookies.page.value//empty' foo.json)
bar=$(jq --raw-output '.cookies.page.value//empty' bar.json)
http "jsonplaceholder.typicode.com/posts?_page=$foo&_limit=5"
http "jsonplaceholder.typicode.com/posts?_page=$bar&_limit=5"
