**rclone** es una herramienta muy potente para sincronizar Google Drive en Linux.

---

## 🔧 Instalación
1. **Instala rclone** desde tu gestor de paquetes:

     ```bash
     sudo dnf install rclone
     ```
   - O descarga el binario desde [rclone.org](https://rclone.org/downloads/).

---

## ⚙️ Configuración inicial
1. Ejecuta:
   ```bash
   rclone config
   ```
2. Te aparecerá un menú interactivo:
   - Elige **n** (new remote).
   - Ponle un nombre, por ejemplo: `gdrive`.
   - Selecciona el tipo de almacenamiento: escribe `drive`.
   - Te pedirá **client_id** y **client_secret** (puedes dejarlo vacío para usar los valores por defecto de rclone, aunque es mejor crear tus credenciales en la [Google Cloud Console](https://console.cloud.google.com/)).
   - Elige el modo de acceso: normalmente `full access`.
   - Cuando pregunte por “root_folder_id” y “service_account file”, deja vacío.
   - Luego te pedirá autorización: abre el enlace en tu navegador, inicia sesión en tu cuenta de Google y copia el código de verificación en la terminal.
   - Al final, confirma con `y` y guarda la configuración.

---

## 📂 Montar Google Drive como carpeta
Una vez configurado, puedes montar tu Drive en una carpeta local:

```bash
rclone mount gdrive: ~/GoogleDrive --vfs-cache-mode writes
```

- Esto crea la carpeta `~/GoogleDrive` con tus archivos de Drive.  
- Mientras el comando esté corriendo, puedes acceder a tus archivos como si fueran locales.  
- Para desmontar, basta con cerrar el proceso o usar `fusermount -u ~/GoogleDrive`.

---

## 🔄 Sincronización
Si prefieres sincronizar (copiar archivos entre tu PC y Drive):

- **Subir carpeta local a Drive:**
  ```bash
  rclone sync ~/MisArchivos gdrive:Backup
  ```
- **Descargar carpeta de Drive a tu PC:**
  ```bash
  rclone sync gdrive:Backup ~/MisArchivos
  ```

> ⚠️ `sync` hace que ambas carpetas sean idénticas (borra archivos que no estén en el origen).  
> Si quieres solo copiar sin borrar, usa `copy` en lugar de `sync`.

---

## 🛠️ Buenas prácticas
- Usa `--dry-run` primero para ver qué pasaría sin ejecutar cambios:
  ```bash
  rclone sync ~/MisArchivos gdrive:Backup --dry-run
  ```
- Activa logs para depuración:
  ```bash
  rclone sync ~/MisArchivos gdrive:Backup --log-file=rclone.log -v
  ```


## archivo configuracion
/root/.config/rclone/rclone.conf   ( copiado de /home/CAV/.config/rclone )


## sincronizar Backup RMAN
sudo rclone sync /mnt/fra/XE gdrive:VICKY_FRA -v

## sincronizar Disco S
sudo rclone sync /srv/samba/discoS/2026/2026 gdrive:DISCO_S -v
