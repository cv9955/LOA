# 🛠️ **Instalación correcta del driver RTL8188EUS en Rocky 8**

## 1. Instalar dependencias
```bash
sudo dnf install epel-release
sudo dnf install git gcc make kernel-devel-$(uname -r)
```

Verificá que el kernel-devel coincide con tu kernel:

```bash
rpm -q kernel-devel-$(uname -r)
```

---

## 2. Clonar el driver
```bash
git clone https://github.com/aircrack-ng/rtl8188eus.git
cd rtl8188eus
```

---

## 3. Compilar e instalar
```bash
sudo make
sudo make install
```

Esto compila el módulo `8188eu` y lo instala en `/lib/modules/.../kernel/drivers/net/wireless/`.

---

## 4. Blacklistear el módulo conflictivo del kernel
Rocky trae el módulo **r8188eu**, que interfiere.

```bash
echo "blacklist r8188eu" | sudo tee /etc/modprobe.d/realtek.conf
```

---

## 5. Recargar módulos
```bash
sudo modprobe -r r8188eu 2>/dev/null
sudo modprobe 8188eu
```

Si no deja descargarlo (porque está en uso), reiniciá:

```bash
sudo reboot
```

---

# 🔎 Verificar que cargó el driver correcto

```bash
lsmod | grep 8188
```

Deberías ver:

```
8188eu  <números>
```

Y tu interfaz WiFi debería aparecer:

```bash
nmcli device status
```

---

# Si querés, seguimos  
Pasame la salida de:

```bash
lsmod | grep 8188
```

y te confirmo si quedó cargado el módulo correcto o si hay que ajustar algo más.