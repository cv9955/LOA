## 📂 Configuración de Samba

1. **Instalar Samba (si no está instalado)**  
   ```bash
   sudo dnf install samba samba-common
   ```

2. **Editar configuración de Samba**  
   ```bash
   sudo nano /etc/samba/smb.conf
   ```
   Al final del archivo agrega:
   ```
   [Compartida]
       path = /srv/samba/share
       browseable = yes
       writable = yes
       guest ok = no
       valid users = usuario
   ```

3. **Crear usuario Samba**  
   ```bash
   sudo smbpasswd -a usuario
   ```

4. **Asegurar permisos en la carpeta**  
   ```bash
   sudo chown -R usuario:usuario /srv/samba/share
   sudo chmod -R 770 /srv/samba/share
   ```

5. **Habilitar y reiniciar servicios**  
   ```bash
   sudo systemctl enable smb nmb
   sudo systemctl restart smb nmb
   ```
