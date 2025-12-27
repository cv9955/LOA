[cav@rocky8 ~]$ uname -r
4.18.0-553.89.1.el8_10.x86_64
5.4.302-1.el8.elrepo.x86_64

Vamos a instalar **kernel‑lt (5.4 LTS)** desde **ELRepo** en Rocky Linux 8 
motivo : no complilan los drivers para la placa wifi

---

# 🟦 1. Habilitar ELRepo

```bash
sudo dnf install https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm
```

Verificá que se agregó el repo:

```bash
dnf repolist | grep elrepo
```

---

# 🟦 2. Instalar el kernel‑lt (5.4 LTS)

```bash
sudo dnf --enablerepo=elrepo-kernel install kernel-lt kernel-lt-devel
```

Esto instala:

- `kernel-lt` → kernel 5.4 LTS  
- `kernel-lt-devel` → headers para compilar drivers (clave para tu WiFi)

No reemplaza tu kernel actual: simplemente agrega uno nuevo al GRUB.

---

# 🟦 3. Establecer el kernel‑lt como predeterminado

Listar entradas de GRUB:

```bash
sudo awk -F\' '/menuentry / {print $2}' /etc/grub2.cfg
```

El kernel‑lt suele quedar como **la primera entrada (índice 0)**.

Configurar GRUB para arrancar con la primera entrada:

```bash
sudo grub2-set-default 0
```

Regenerar configuración (solo por prolijidad):

```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

---

# 🟦 4. Reiniciar en el nuevo kernel

```bash
sudo reboot
```

Después del reinicio, verificá:

```bash
uname -r
```

Deberías ver algo como:

```
5.4.x-1.el8.elrepo.x86_64
```

---

# 🟦 5. Ahora sí podés compilar drivers modernos (incluido tu RTL8188EUS)

Con kernel 5.4, el driver de aircrack-ng **compila sin parches**.

---

# 🟦 6. ¿Querés que te deje ahora los comandos exactos para recompilar el driver WiFi sobre el kernel nuevo?

Decime y te lo dejo listo para copiar/pegar.