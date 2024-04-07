#!/bin/bash

echo pwd | $rol
function echoHeader(){
clear
	echo  "==============================="
	echo  "      Install Cntlm UI v.1.0"
	echo  "==============================="
	echo  ""
}
if [ $USER = "root" ]; then
	echo "Lo sentimos ejecute el archivo sin periso de root ..."
else
	home=$HOME
	echoHeader
	echo  "  i -> instalar y configurar ..."
	echo  "  r -> borrar config y ficheros"
	echo  "  c -> cancelar y salir"
	read -p ">> :" ops

	case $ops in
	"i")
		echoHeader
		sudo ./copi-environment.sh $home

		echo "Copiando archivos  ..."
		cp -R .cntlm-data/ $HOME

		echo "---------------------------------"
		echo ""
		echo "Desea instalar cntlm.deb y yad.deb"
		echo " (i) Se istalaran los paquetes necesarios ..."
			read -p " [y\n] >> :" varIsnt
			case $varIsnt in
			"y")
				sudo dpkg -i ./dpkg/cntlm.deb ./dpkg/yad.deb;;
			esac
			clear
		echoHeader




		echo "Desea Creando link de acceso bin"
		echo " (i) puede acceder con el comando ui-cntlm ..."
			read -p " [y\n] >> :" varBin
			case $varBin in
			"y")
				./create-bin.sh $home;;
			esac

		echo "---------------------------------"
		echo ""
		echo "Desea iniciar una cuenta de usuario ahora"
		echo " (i) si lo desea autentificarte automaticamente ..."
			read -p " [y\n] >> :" varUS
			case $varUS in
			"y")
				touch cntlm.conf
				read -p "usuario a iniciar ... -> " us
				read -p "Contaseña -> " pw
				echo "Username "  $us > cntlm.conf
			    echo "Domain  uci.cu ">> cntlm.conf
			    echo "Password "  $pw >> cntlm.conf
			    echo "Proxy 10.0.0.1:8080"  >> cntlm.conf
			    echo "NoProxy localhost, 127.0.0.*, 10.*, 192.168.*,*uci.cu*" >> cntlm.conf
			    echo "Listen 3128" >> cntlm.conf
			    sudo mv cntlm.conf /etc
			    sudo service cntlm start
			esac
		echo ""
		echo "Se a instalado y configurado correctamente ..."
		echo ""
			bash;;
		"r")
			sudo rm /bin/ui-cntlm
			rm -R $home/.cntlm-data
			bash
			;;
	esac
fi
exit






