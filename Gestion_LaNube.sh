#!/bin/bash
#Gestion de servicios

while true; do
echo "-------------------------------"
echo "-----------GESTION-------------"
echo "-----------LA NUBE-------------"
echo "-------------------------------"
echo "1.Crear un Servidor web Apache"
echo "2.Crear un Servidor MySQL"
echo "3.Crear un Servidor MongoDB"
echo "4.Crear una MV UbuntuServer"
echo "5.Listar Servicios Activos"
echo "6.Eliminar Servicio"
echo "7.Salir"
echo "-------------------------------"
echo "Elegir opcion: "
read op
echo "-------------------------------"
case $op in
1) echo "1. Crear nueva red: "
   echo "2. Usar red antigua: "
   echo "3. Atras: "
   read -p "Elegir opcion: " op2;
   echo "-------------------------------"
   case $op2 in
   1)
    echo "-------------------------------"
    docker network ls
    read -p "Nombre red: " nombreRed;
    docker network create -d bridge $nombreRed
    read -p "Nombre cliente: " nombreCliente;
    read -p "# Puerto servicio: " puerto;
    docker run --network $nombreRed -dit --name apache_$nombreCliente -p $puerto:80  httpd:latest
    docker ps 
    echo "Creado exitosamente"
    echo "-------------------------------";;
   2) 
    echo "-------------------------------"
    docker network ls
    read -p "Nombre red: " nombreRed;
    read -p "Nombre cliente: " nombreCliente;
    read -p "# Puerto servicio: " puerto;
    docker run --network $nombreRed -dit --name apache_$nombreCliente -p $puerto:80  httpd:latest
    docker ps
    echo "Creado exitosamente"
    echo "-------------------------------";;   
   3) ;;
   esac
;;
2) echo "1. Crear nueva red: "
   echo "2. Usar red antigua: "
   echo "3. Atras: "
   read -p "Elegir opcion: " op2;
   echo "-------------------------------"
   case $op2 in
   1)
    echo "-------------------------------"
    docker network ls
    read -p "Nombre red: " nombreRed;
    docker network create -d bridge $nombreRed
    read -p "Nombre cliente: " nombreCliente;
    read -p "# Puerto servicio MySQL: " puerto;
    read -p "# Puerto servicio PhPMyAdmin: " puerto2;
    docker run --name mysql_$nombreCliente --network $nombreRed -p $puerto:8080 -e MYSQL_ROOT_PASSWORD=Passw0rd -d mysql:latest
    docker run --name phpadmin_$nombreCliente --network $nombreRed -d --link mysql_$nombreCliente:db -p $puerto2:80 phpmyadmin
    docker ps 
    echo "Creado exitosamente"
    echo "-------------------------------";;
   2) 
    echo "-------------------------------"
    docker network ls
    read -p "Nombre red: " nombreRed;
    read -p "Nombre cliente: " nombreCliente;
    read -p "# Puerto servicio MySQL: " puerto;
    read -p "# Puerto servicio PhPMyAdmin: " puerto2;
    docker run --name mysql_$nombreCliente --network $nombreRed -p $puerto:8080 -e MYSQL_ROOT_PASSWORD=Passw0rd -d mysql:latest
    docker run --name phpadmin_$nombreCliente --network $nombreRed -d --link mysql_$nombreCliente:db -p $puerto2:80 phpmyadmin
    docker ps
    echo "Creado exitosamente"
    echo "-------------------------------";;   
   3) ;;
   esac
;;
3) echo "1. Crear nueva red: "
   echo "2. Usar red antigua: "
   echo "3. Atras: "
   read -p "Elegir opcion: " op2;
   echo "-------------------------------"
   case $op2 in
   1)
    echo "-------------------------------"
    docker network ls
    read -p "Nombre red: " nombreRed;
    docker network create -d bridge $nombreRed
    read -p "Nombre cliente: " nombreCliente;
    read -p "# Puerto servicio MongoDB: " puerto;
    read -p "# Puerto servicio Mongo Express: " puerto2;
    docker run --network $nombreRed --name mongo_$nombreCliente -p $puerto:27017 -d mongo:latest
    docker run --network $nombreRed --name mongoEXP_$nombreCliente -e ME_CONFIG_MONGODB_SERVER=mongo_$nombreCliente -p $puerto2:8081 -d mongo-express
    docker ps 
    echo "Creado exitosamente"
    echo "-------------------------------";;
   2) 
    echo "-------------------------------"
    docker network ls
    read -p "Nombre red: " nombreRed;
    read -p "Nombre cliente: " nombreCliente;
    read -p "# Puerto servicio MongoDB: " puerto;
    read -p "# Puerto servicio Mongo Express: " puerto2;
    docker run --network $nombreRed --name mongo_$nombreCliente -p $puerto:27017 -d mongo:latest
    docker run --network $nombreRed --name mongoEXP_$nombreCliente -e ME_CONFIG_MONGODB_SERVER=mongo_$nombreCliente -p $puerto2:8081 -d mongo-express
    docker ps
    echo "Creado exitosamente"
    echo "-------------------------------";;   
   3) ;;
   esac
;;
4) echo "1. Crear nueva red: "
   echo "2. Usar red antigua: "
   echo "3. Atras: "
   read -p "Elegir opcion: " op2;
   echo "-------------------------------"
   case $op2 in
   1)
    echo "-------------------------------"
    docker network ls
    read -p "Nombre red: " nombreRed;
    docker network create -d bridge $nombreRed
    read -p "Nombre cliente: " nombreCliente;
    read -p "# Puerto servicio: " puerto;
    docker run -d -p $puerto:22 --name vm_$nombreCliente --network $nombreRed rastasheep/ubuntu-sshd:18.04
    docker ps 
    echo "Creado exitosamente"
    echo "-------------------------------";;
   2) 
    echo "-------------------------------"
    docker network ls
    read -p "Nombre red: " nombreRed;
    read -p "Nombre cliente: " nombreCliente;
    read -p "# Puerto servicio: " puerto;
    docker run -d -p $puerto:22 --name vm_$nombreCliente --network $nombreRed rastasheep/ubuntu-sshd:18.04
    docker ps
    echo "Creado exitosamente"
    echo "-------------------------------";;   
   3) ;;
   esac
;;
5) docker ps ;;
6) docker ps -a
   read -p "Nombre del contenedor: " nombreCont;
   docker stop $nombreCont
   docker rm $nombreCont
   docker ps -a
   echo "Eliminado correctamente"
   echo "-------------------------------";;
7) break ;;
esac
echo "-------------------------------"
done