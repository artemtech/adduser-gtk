# adduser-gtk

## Daftar Dependensi
- libgtk-3-dev
- valac
pasang terlebih dahulu paket diatas dengan perintah:
```bash
sudo apt install libgtk-3-dev valac
```
lalu compile dengan library gtk+3.0 dan posix dalam folder gui

```bash
(gui)$ valac --pkg gtk+-3.0 --pkg posix input_user.vala
```

Jalankan hasil kompilasi dengan hak akses root 
```bash
(gui)$ sudo ./input_user
```

## Daftar Capaian
- [x] Prototipe tampilan
- [x] Fungsi shell `adduser`
- [x] Fungsi pembuat sandi
- [x] Fungsi mengatur nama komputer (Hostname) ke /etc/hostname
- [ ] Penyaring masukan yang dapat diterima di kolom "Hostname", "Username", dan "Password"
- [x] Tutup otomatis jika perintah berhasil dilakukan
