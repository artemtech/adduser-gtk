# Adduser-gtk

## Daftar Dependensi
- libgtk-3-dev
- valac
- gnome-common

Pasang terlebih dahulu paket diatas dengan perintah:
```bash
sudo apt install libgtk-3-dev valac gnome-common
```

## Build Binary
Build and running

```bash
$ ./autogen.sh
$ make
$ sudo make install
```

Jalankan hasil kompilasi dengan hak akses root 
```bash
$ sudo addusergtk
```

## Daftar Capaian
- [x] Prototipe tampilan
- [x] Fungsi shell `adduser`
- [x] Fungsi pembuat sandi
- [x] Fungsi mengatur nama komputer (Hostname) ke /etc/hostname
- [ ] Penyaring masukan yang dapat diterima di kolom "Hostname", "Username", dan "Password"
- [x] Tutup otomatis jika perintah berhasil dilakukan
