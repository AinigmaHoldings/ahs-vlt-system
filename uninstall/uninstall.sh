#!/bin/bash

# Detener y eliminar todos los contenedores
docker container stop $(docker container ls -aq)
docker container rm $(docker container ls -aq)

# Eliminar todas las imágenes
docker image rm $(docker image ls -q)

# Eliminar todos los volúmenes
docker volume rm $(docker volume ls -q)

# Eliminar todas las redes
docker network rm $(docker network ls -q)

# Desinstalar Docker
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Eliminar directorios de configuración y datos de Docker
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

# Eliminar repositorio de Docker y claves GPG
sudo rm /etc/apt/sources.list.d/docker.list
sudo rm /etc/apt/keyrings/docker.gpg

# Limpiar los paquetes innecesarios
sudo apt-get autoremove -y
sudo apt-get clean

echo "Docker ha sido desinstalado completamente."

#!/bin/bash

# Eliminar la carpeta /home/${USER}/vlt/
rm -rf /home/${USER}/vlt/

# Confirmar la eliminación
if [ ! -d /home/${USER}/vlt/ ]; then
    echo "La carpeta /home/${USER}/vlt/ ha sido eliminada."
else
    echo "No se pudo eliminar la carpeta /home/${USER}/vlt/."
fi

#!/bin/bash

#!/bin/bash

# Deshabilitar el servicio vlt.service
sudo systemctl disable vlt.service

# Detener el servicio vlt.service si está corriendo
sudo systemctl stop vlt.service

# Eliminar el archivo del servicio vlt.service
sudo rm /etc/systemd/system/vlt.service

# Recargar el daemon de systemd para aplicar los cambios
sudo systemctl daemon-reload

# Confirmar que el servicio ha sido eliminado
if [ ! -f /etc/systemd/system/vlt.service ]; then
    echo "El servicio vlt.service ha sido deshabilitado y eliminado."
else
    echo "No se pudo eliminar el servicio vlt.service."
fi

# Eliminar los archivos de autostart
rm -f /home/${USER}/.config/autostart/xhostdocker.desktop
rm -f /home/${USER}/.config/autostart/printenvlocal.desktop

# Confirmar que los archivos han sido eliminados
if [ ! -f /home/${USER}/.config/autostart/xhostdocker.desktop ] && [ ! -f /home/${USER}/.config/autostart/printenvlocal.desktop ]; then
    echo "Los archivos de autostart han sido eliminados."
else
    echo "No se pudieron eliminar los archivos de autostart."
fi


