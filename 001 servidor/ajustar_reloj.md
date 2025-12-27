#!/bin/bash
# Configuración de hora estándar

echo "Configurando RTC en UTC..."
timedatectl set-local-rtc 0

timedatectl set-timezone America/Argentina/Buenos_Aires


echo "Activando sincronización NTP..."
timedatectl set-ntp true

echo "Instalando y activando Chrony..."
dnf install -y chrony
systemctl enable --now chronyd

echo "Verificando estado..."
timedatectl status
