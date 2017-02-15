# adduser-gtk

## Daftar Dependensi
- libgtk-3-dev
- valac

compile dengan library gtk+3.0 dan posix dalam folder gui

```bash
valac --pkg gtk+3.0 --pkg posix inputuser.vala
```

## Daftar Capaian
- [x] Prototipe tampilan
- [x] Fungsi shell `adduser`
- [x] Fungsi pembuat sandi
- [ ] Fungsi mengatur nama komputer (Hostname) ke /etc/hostname
- [ ] Penyaring masukan yang dapat diterima di kolom "Hostname", "Username", dan "Password"
- [ ] Tutup otomatis jika perintah berhasil dilakukan
