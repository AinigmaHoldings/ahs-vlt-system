# Usar una imagen base de Ubuntu
FROM ubuntu:20.04

# Evitar interacción al instalar paquetes
ENV DEBIAN_FRONTEND=noninteractive
ENV LOBBY_URL=https://www.google.com

# Actualizar el sistema e instalar dependencias
RUN apt-get update && apt-get install -y \
    firefox \
    x11-apps \
    mesa-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Crear un usuario no root
RUN useradd -ms /bin/bash firefoxuser

# Cambiar a usuario no root
USER firefoxuser
WORKDIR /home/firefoxuser

# Configurar Firefox para habilitar WebGL (opcional)
# Puedes ajustar estos parámetros en el perfil de usuario si es necesario

# Comando para ejecutar Firefox
CMD firefox --kiosk  $LOBBY_URL