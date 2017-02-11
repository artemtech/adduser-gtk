#!/bin/bash
set -e
echo "================================================================="
echo "		Selamat Datang di mesin Blankon baru Anda!"
echo "=================================================================="
echo "Silahkan isikan informasi berikut untuk memulai menggunakan Blankon"
sleep 1
echo -n "Nama Komputer : "
read namaKomputer
sleep 1
echo -n "Username : "
read userEntry
sleep 1
echo -n "Password : "
read -s passEntry
sleep 1
echo 
echo "Mohon tunggu beberapa saat .."
echo "$namaKomputer" > /etc/hostname
echo "done" >> /tmp/buatbaru
sleep 1
adduser --quiet --disabled-password --shell /bin/bash --home /home/$userEntry --gecos "$userEntry" $userEntry
echo "done" >> /tmp/buatbaru
sleep 2
echo "$userEntry:$passEntry" | chpasswd
sleep 1
echo "done" >> /tmp/buatbaru
sleep 2
echo "==> Selesai <=="
