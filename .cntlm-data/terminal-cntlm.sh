#! /bin/bash

clear
echo  "Hola bienbenido al asistente de Proxy cntlm ..."
echo  "ip/puerto 127.0.0.1/3128"
echo  "i -> Iniciar configuración"
echo  "s -> para detener el secicio"
echo  "r -> reiniciar cntlm"
echo  "c -> cancelar y salir"
echo  "_____________________________________"
echo  ""
read -p "Menu o el usuario a iniciar ... -> " us

case $us in
"i")	
	sudo service cntlm start
	echo cntlm iniciado con exito;;
"s")
	sudo service cntlm stop
	echo cntlm detenido con exito;;
"r")	
	sudo service cntlm restart
	echo se a reiniciado el servicio de cntlm;;
"c")
	echo ejecucion cancelada ...
	exit;;
*)
	read -p "Contaseña -> " pw
	touch cntlm.conf
	sudo chmod +x cntlm.conf
	echo "Username "  $us > cntlm.conf
    echo "Domain  uci.cu ">> cntlm.conf
    echo "Password "  $pw >> cntlm.conf
    echo "Proxy 10.0.0.1:8080"  >> cntlm.conf
    echo "NoProxy localhost, 127.0.0.*, 10.*, 192.168.*,*uci.cu*" >> cntlm.conf
    echo "Listen 3128" >> cntlm.conf

    mv cntlm.conf /etc
    sudo service cntlm restart
    clear
    echo ""
    echo "Se a iniciado (" $us " ) correctamente ..."
    echo "";;
esac
	exit
