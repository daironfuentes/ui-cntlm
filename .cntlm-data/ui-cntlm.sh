#!/bin/bash
# ----------------------------------------
# Cntlm UI
# Todos los derechos reservados.
# Copirait
# vercion v.1.3

# Variable globales
user=$USER
home=$HOME
urlUser=$home/.cntlm-data/data/user.txt
urlPass=$home/.cntlm-data/data/pass.txt
cntlmConf=/etc/cntlm.conf
activeUser=$(awk 'NR==1' /etc/cntlm.conf | awk '{print $2}')
listUser=""
# Imagenes
icon32="$home/.cntlm-data/icon/32x32.png"
icon64="$home/.cntlm-data/icon/64x64.png"
icon128="$home/.cntlm-data/icon/128x128.png"
iconCntlm="$home/.cntlm-data/icon/cntlm-icon_128x128.png"
icon150="$home/.cntlm-data/icon/150x200.png"
iconError="$home/.cntlm-data/icon/error.png"

# Leyendo datos de usuario y contraseña
m=""
while read l; do
    m="$m $l"
done < $urlUser
uaserArray=($m)
t=""
while read lt; do
    t="$t $lt"
done < $urlPass
userPss=($t)

cont=0
    for i in ${uaserArray[*]}; do
        cont=$((cont + 1))
        listUser="$listUser $cont $i"    
    done

# Función Mostrar un mensaje
function msg(){
	yad --title="$1" --center --text-align="center" --image="$iconError"\
	 --geometry="400x100" --text="$2" --button="ok":0
}
# Función Buscar el usuario
function indexOf(){
    contIndexOf=0
    while read lineaUser; do
        contIndexOf=$((contIndexOf + 1))
        if [[ "$lineaUser" == "$1" ]]; then
            return $contIndexOf
        fi
    done < $urlUser
}

# Añadir un nuevo usuario a los guardados
function addUser(){
    indexOf $1
    index=$?
    if [[ $index -eq 0 ]];
    then
        echo $1 >> $urlUser
        echo $2 >> $urlPass
    else
        if [[ $3 -eq 0 ]];then
        	echo ""
        	else
        	msg "Error ..." "El usuario ( $1 )ya esta registrado ..."
        fi
    fi
}
# Escribiendo las configuración de las credenciales
function escribirUser(){
    sudo service cntlm stop
    sudo chmod 777 /etc/cntlm.conf
    sudo echo "Username "  $1 > /etc/cntlm.conf
    sudo echo "Domain  uci.cu ">> /etc/cntlm.conf
    sudo echo "Password "  $2 >> /etc/cntlm.conf
    sudo echo "Proxy 10.0.0.1:8080"  >> /etc/cntlm.conf
    sudo echo "NoProxy localhost, 127.0.0.*, 10.*, 192.168.*,*uci.cu*" >> /etc/cntlm.conf
    sudo echo "Listen 3128" >> /etc/cntlm.conf
    sudo service cntlm start
    msg "Usuario activo" "Se a iniciado al usuario $1 en cntlm ..."
}

# -----------------------------------------------
frmdata=$(yad --title="Cntlm UI" --center --image=$iconCntlm --text-align=center \
    --text="Indicate the username and password, or more options ... ( 127.0.0.1:3128 )"\
    --form --field="Username" --field="Password":H --field="Save user":CHK \
    --button="Authenticate user":0 --button="More options":2 --button="Cancelar":999)
ans=$?
    frmaddr=$(echo $frmdata | awk 'BEGIN {FS="|" } { print $1 }')
    frmname=$(echo $frmdata | awk 'BEGIN {FS="|" } { print $2 }')
    frmsave=$(echo $frmdata | awk 'BEGIN {FS="|" } { print $3 }')
case $ans in
0)
	if [[ $frmsave == "TRUE" ]]; then
		addUser $frmaddr $frmname 1
	fi
    escribirUser $frmaddr $frmname;;
2)
    fromMoreOptions=$(yad --title="Mas obsiones" --image="$iconCntlm" --text-align=center \
        --text="(( $activeUser )) Select obsiones" \
	    --form --field="start":CHK --field="restart":CHK --field="stop":CHK \
        --button="ok":0 --button="Delete":2 --button="Save":3 --button="Cancelar":4)
    est=$?
	    frmS=$(echo $fromMoreOptions | awk 'BEGIN {FS="|" } { print $1 }')
	    frmR=$(echo $fromMoreOptions | awk 'BEGIN {FS="|" } { print $2 }')
	    frmP=$(echo $fromMoreOptions | awk 'BEGIN {FS="|" } { print $3 }')
    case $est in
        0)
			if [[ $frmS == "TRUE" ]]; then
				sudo service cntlm start
				msg "service cntlm" "se a iniciado el servicio"
			fi
			if [[ $frmR == "TRUE" ]]; then
				sudo service cntlm restart
				msg "service cntlm" "se a registrado el servicio"
			fi
			if [[ $frmP == "TRUE" ]]; then
				sudo service cntlm stop
				msg "service cntlm" "se a detenido el servicio"
			fi;;
        2)
            fromDelete=$(yad --list --title="Delete User List" --geometry="400x400" --image=$iconError \
                 --center --text="(( $activeUser )) Select a user from the Delete User List ... " \
                 --button=Delete:0 --button=Cancelar:1 \
                 --radiolist --column="" --column="user list" $listUser)
    		temp=$(echo $fromDelete | awk 'BEGIN {FS="|" } { print $2 }')
            c=0
            echo "" > $urlUser 
            echo "" > $urlPass
            for x in ${uaserArray[*]}; do
            	if [[ $temp == $x ]]; then
                    msg "User eliminado" "Se a eliminado el usuario guardado : ${uaserArray[c]} ..."
                else
                	echo ${uaserArray[c]} >> $urlUser 
                	echo ${userPss[c]} >> $urlPass 
            	fi
            	c=$((c + 1))
            done;;
        3)
            fromListUser=$(yad --list --title="Saved User List" --geometry="400x400" --center \
                 --image=$icon150 --text="(( $activeUser )) Select a user from the Saved User List ..." \
                 --button=Authenticate:0 --button=Cancelar:9 \
                 --radiolist --column="" --column="user list" $listUser)
            ans=$?
    		temp=$(echo $fromListUser | awk 'BEGIN {FS="|" } { print $2 }')
            c=0
            	for x in ${uaserArray[*]}; do
                    if [[ $x == $temp ]]; then
                        escribirUser ${uaserArray[c]} ${userPss[c]}
                    fi
                    c=$((c + 1))
                done;;
    esac;;
esac
#xkill
exit 99
