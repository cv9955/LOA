# VPN
## 🔐 Opciones de VPN en Linux

1. **OpenVPN (clásico y robusto)**
   - Muy usado en entornos empresariales.
   - Permite certificados, usuarios y contraseñas.
   - Compatible con Windows, Linux, macOS y móviles.

2. **WireGuard (moderno y rápido)**
   - Más simple que OpenVPN.
   - Configuración basada en claves públicas/privadas.
   - Muy eficiente en rendimiento.

3. **IPSec (con strongSwan)**
   - Estándar muy usado en routers/firewalls.
   - Más complejo de configurar, pero muy seguro.
   - Ideal si querés compatibilidad con clientes integrados en Windows/macOS.

---

## 🔧 Instalación de WireGuard

1. **Instalar paquetes necesarios**  
   ```bash
   sudo dnf install wireguard-tools
   ```

2. **Habilitar reenvío de paquetes en el kernel**  
   Edita `/etc/sysctl.conf` y agrega:
   No hay conflicto con la configuracion de Preinstall de oracle !!
   ```
   net.ipv4.ip_forward=1
   net.ipv6.conf.all.forwarding=1
   ```
   Aplica cambios:
   ```bash
   sudo sysctl -p
   ```

---

## 🔑 Generar claves

En el servidor:
```bash
wg genkey | tee server.key | wg pubkey > server.pub
```

En el cliente (ej. tu laptop):
```bash
wg genkey | tee client.key | wg pubkey > client.pub
```

---

## ⚙️ Configuración del servidor

Crea `/etc/wireguard/wg0.conf`:

```
[Interface]
Address = 10.8.0.1/24
ListenPort = 51820
PrivateKey = <contenido de server.key>

[Peer]
# Cliente 1
PublicKey = <contenido de client1.pub>
AllowedIPs = 10.8.0.2/32

[Peer]
# Cliente 2
PublicKey = <contenido de client2.pub>
AllowedIPs = 10.8.0.3/32

```





---

## ⚙️ Configuración del cliente

En tu laptop/PC crea `wg0.conf`:

```
[Interface]
Address = 10.8.0.2/24
PrivateKey = <contenido de client.key>
DNS = 1.1.1.1

[Peer]
PublicKey = <contenido de server.pub>
Endpoint = TU_IP_PUBLICA:51820
AllowedIPs = 0.0.0.0/0, ::/0
```

## para que no bloquee el trafico de red
```
AllowedIPs = 10.8.0.0/24, 192.168.2.0/24
```

## cliente WireGuard para windows
[WireGuard](https://www.wireguard.com/install/)
add empty tunnel

### abrir el puerto en firewalld

```bash
sudo firewall-cmd --add-port=51820/udp --permanent
sudo firewall-cmd --reload
```

### port forwarding En tu router:

Puerto externo: 51820/UDP

IP interna del servidor: 192.168.2.67

Puerto interno: 51820/UDP



---

## 🚀 Levantar la VPN

En el servidor:
```bash
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0
```

En el cliente:
```bash
sudo wg-quick up wg0
```
---

## Probar coneccion
```bash
sudo wg show
```
---

## 📂 Acceso a Samba vía VPN

Una vez conectado, tu cliente tendrá IP interna (ej. `10.8.0.2`). Podrás acceder al recurso Samba como si estuvieras en la LAN:

- En Windows:  
  ```
  \\10.8.0.1\Compartida
  ```
- En Linux:  
  ```bash
  smbclient //10.8.0.1/Compartida -U smbuser
  ```

---



# Error Conocido

# ❌ **“Error: Unknown device type / Protocol not supported”**  
Significa que **el kernel de Rocky Linux no tiene soporte para WireGuard**.  
Esto pasa MUY seguido en Rocky 8 si:

- No está cargado el módulo `wireguard`
- No está instalado el paquete `kmod-wireguard`
- Estás usando un kernel viejo sin soporte nativo
- Estás usando un kernel UEK (Oracle) que no trae WireGuard

---

# ✅ 1. Verificar si el módulo WireGuard existe
Ejecutá:

```bash
sudo modprobe wireguard
```

Si te devuelve:

```
modprobe: FATAL: Module wireguard not found
```

→ **No está instalado**.

---

# ✅ 2. Verificar el kernel que estás usando
```bash
uname -r
```

Tu kernel es el estándar de Rocky 8.10:
```
4.18.0-553.89.1.el8_10.x86_64
```

Ese kernel **no trae WireGuard integrado**, pero **sí es compatible** con el módulo externo que provee ELRepo.

---

# ✅ 1. Instalar el módulo WireGuard para tu kernel

WireGuard en Rocky 8 requiere **kmod-wireguard**, que viene desde ELRepo.

### **A) Instalar ELRepo**
```bash
sudo dnf install https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm
```

---

# ✅ 2. Cargar el módulo manualmente (opcional)
```bash
sudo modprobe wireguard
```

Si no devuelve nada → perfecto.

---

# ✅ 3. Reiniciar
```bash
sudo reboot
```

---

# ✅ 4. Probar de nuevo
```bash
sudo systemctl start wg-quick@wg0
sudo systemctl status wg-quick@wg0
```

Si todo está bien, ahora sí debería levantar la interfaz `wg0`.

---
