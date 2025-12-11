#!/bin/bash
generate_key() {
  local static1=$1
  local static2=$2
  local rand1=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
  local rand2=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
  local rand3=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
  echo "${rand1}${static1}${rand2}${static2}${rand3}"
}

key1=$(generate_key "Xk4mPv9Q" "rW7nBz3J")
key2=$(generate_key "Hf6yLc2T" "dS8xKg5V")
key3=$(generate_key "Nq1wRj7M" "pU4bYe9A")
key4=$(generate_key "Zv3tDh8C" "mF6sXl2G")
key5=$(generate_key "Ew5rNp1K" "jB9cQy4H")
key6=$(generate_key "Lx7gTz3W" "vD2mSf8R")
key7=$(generate_key "Yb4kJn6P" "qA9wCe1U")
key8=$(generate_key "Gt8vMx2L" "hK5rZd7N")
key9=$(generate_key "Fs3pYc9B" "tJ6nWq4X")
key10=$(generate_key "Rd1mHv7E" "aP8bLk3S")

echo "KEY1: $key1" > web_page/src/admin/key1.txt
echo "KEY2: $key2" > web_page/src/login/key2.txt
echo "KEY3: $key3" > web_page/src/credentials/key3.txt
echo "Disallow: /ftp KEY4: $key4" > web_page/src/robots.txt
echo "KEY5: $key5" > ssh_machine/vm1/key5.txt
echo "KEY6: $key6" > ssh_machine/vm2/key6.txt
echo "KEY7: $key7" > ssh_machine/vm3/key7.txt
echo "KEY8: $key8" > ssh_machine/vm1/key8.txt
echo "KEY9: $key9" > ssh_machine/vm2/key9.txt
echo "KEY10: $key10" > ssh_machine/vm3/key10.txt

# rm -r setupctc.sh fetchipctc.sh
# Print the key to the console
docker compose down
docker compose up --build -d
