
user=$USER
home=$HOME
urlUser=$home/.cntlm-data/data/user.txt
urlPass=$home/.cntlm-data/data/pass.txt
cntlmConf=/etc/cntlm.conf
varMsg=""


# Leyendo datos de usuario y contraseña

while read l; do
    echo "- " $l
done < $urlUser
echo "------------------------"
while read t; do
    echo "- " $t
done < $urlPass





# function msg(){
# 	yad --title="$1" --center \
# 	    --text-align="center" \
# 	    --image="/home/daironfo/.cntlm-data/icon/error.png" \
# 	    --geometry="400x100" \
# 	    --text="$2"\
# 	    --button="ok":0        		
# }
# # Función Buscar el usuario
# function indexOf(){
#     contIndexOf=0
#     while read lineaUser; do
#         contIndexOf=$((contIndexOf + 1))
#         if [[ "$lineaUser" == "$1" ]]; then
#             return $contIndexOf
#         fi
#     done < $urlUser
# }
# # Función saber Usuario activo
# function saberuser(){
#     cont=0
#     while read linea; do
#         cont=$((cont + 1))
#         if [[ $cont -eq 1 ]]; then
#         	msg "Active user" "active user on the server = $linea"
#         fi
#     done < $cntlmConf
# }
# # Añadir un nuevo usuario a los guardados
# function addUser(){
#     indexOf $1
#     index=$?
#     if [[ $index -eq 0 ]];
#     then
#         echo $1 >> $urlUser
#         echo $2 >> $urlPass
#     else
#         if [[ $3 -eq 0 ]];then
#         	echo ""
#         	else
#         	msg "Error ..." "El usuario ( $1 )ya esta registrado ..."   		
#         fi
#     fi
# }
# # Escribiendo las configuración de las credenciales
# function escribirUser(){
#     sudo service cntlm stop
#     sudo chmod 777 /etc/cntlm.conf
#     sudo echo "Username "  $1 > /etc/cntlm.conf
#     sudo echo "Domain  uci.cu ">> /etc/cntlm.conf
#     sudo echo "Password "  $2 >> /etc/cntlm.conf
#     sudo echo "Proxy 10.0.0.1:8080"  >> /etc/cntlm.conf
#     sudo echo "NoProxy localhost, 127.0.0.*, 10.*, 192.168.*,*uci.cu*" >> /etc/cntlm.conf
#     sudo echo "Listen 3128" >> /etc/cntlm.conf
#     sudo service cntlm start
#     msg "Usuario activo" "Se a iniciado al usuario $1 en cntlm ..."
# }
# function addTrue(){
# 	varMsg=""
# 	mesg=("T" "R" "U" "E" "|")
#     m=""
#     for j in ${mesg[*]}; do
#         m="$m$j"
#     done
#     varMsg="$m$1|"
# }


# # -----------------------------------------------
# frmdata=$(yad --title="Cntlm UI" --center \
#     --image="/home/daironfo/.cntlm-data/icon/cntlm-icon_128x128.png" \
#     --text-align=center \
#     --text="Indicate the username and password for the cntlm server,/n or more options ..."\
#     --form  \
#         --field "Username" \
#         --field="Password" \
#     --button="Authenticate user":0 --button="Obsion":1 \
#     --button="More options":2 --button="Cancelar":999)
# ans=$?
#     frmaddr=$(echo $frmdata | awk 'BEGIN {FS="|" } { print $1 }')
#     frmname=$(echo $frmdata | awk 'BEGIN {FS="|" } { print $2 }')
# case $ans in
# 0)
# 	addUser $frmaddr $frmname 0
#     escribirUser $frmaddr $frmname;;
# 1)
# # Obsiones de a realizar el service
# 	confOptions=$(yad --title="Options Confg" \
#         --image="/home/daironfo/.cntlm-data/icon/128x128.png" \
#         --text-align=center \
#         --text="Seleccione la obsion a realizar ..." \
#         --button="Start":1 --button="Stop":2 \
#         --button="Restart":3 --button="Cancelar":4)
# 	confOptions=$?
#     case $confOptions in
#         1)sudo service cntlm start
# 			msg "service cntlm" "Se a iniciado correctamente el servicio cntlm ...";;
#         2)sudo service cntlm stop
# 			msg "service cntlm" "Se a detenito correctamente el servicio cntlm ...";;
#         3)sudo service cntlm restart
# 			msg "service cntlm" "Se a reinicido correctamente el servicio cntlm ...";;
#     esac;;    
# 2)
#     MoreOptions=$(yad --title="Mas obsiones" \
#         --image="/home/daironfo/.cntlm-data/icon/128x128.png" \
#         --text-align=center \
#         --text="Selecione la obsion de a realizar" \
#         --button="Active user":0 --button="User new":1 \
#         --button="Delete user":2 --button="Save user":3 \
#         --button="Cancelar":4)
#     mo=$?
#     case $mo in
#         0)saberuser;;
#         1)
#             frmnewuser=$(yad --title="Inserte las credenciales" \
#             	--image="/home/daironfo/.cntlm-data/icon/logo.png" \
#             	--text-align=center \
#             	--form  \
#                 	--field "New Username" \
#                 	--field="New Password")
#             newuser=$(echo $frmnewuser | awk 'BEGIN {FS="|" } { print $1 }')
#             newpass=$(echo $frmnewuser | awk 'BEGIN {FS="|" } { print $2 }')
#             addUser $newuser $newpass;;
#         2)
# 			delete_cont=0
#             delete_mas=""
#             for i in ${uaserArray[*]}; do
#                 delete_cont=$((delete_cont + 1))
#                 delete_mas="$delete_mas $delete_cont $i"    
#             done
#             oDelete=$(yad --list \
#                  --title="Delete User List" --geometry="400x400" --image="/home/daironfo/.cntlm-data/icon/error.png" \
#                  --button=Delete:0 --button=Cancelar:1 \
#                  --center --text="Select a user from the Delete User List ... " \
#                  --radiolist --column="" --column="user list" \
#                  $delete_mas)
#             c=0
#             echo "" > $urlUser 
#             echo "" > $urlPass
#             for i in ${uaserArray[*]}; do
#             	addTrue "${uaserArray[c]}"
#             	if [[ $varMsg == ${oDelete} ]]; then
#                     msg "User eliminado" "Se a eliminado el usuario guardado : ${uaserArray[c]} ..."
#                 else
#                 	echo ${uaserArray[c]} >> $urlUser 
#                 	echo ${userPss[c]} >> $urlPass 
#             	fi
#             	c=$((c + 1))
#             done;;
#         3)
#             cont=0
#             listUser=""
#             for i in ${uaserArray[*]}; do
#                 cont=$((cont + 1))
#                 listUser="$listUser $cont $i"    
#             done
#             componente=$(yad --list --title="Saved User List" \
#                  --geometry="400x400" --center \
#                  --image="/home/daironfo/.cntlm-data/icon/150x200.png" \
#                  --button=Authenticate:0 --button=Cancelar:1 \
#                  --text="Select a user from the Saved User List ... " \
#                  --radiolist \
#                  --column="" \
#                  --column="user list" \
#                  $listUser)

#             ans=$?
#             if [ $ans -eq 0 ]
#             then
#                 c=0
#                 for x in ${uaserArray[*]}; do
#                 	addTrue "${uaserArray[c]}"
#                 	m=$varMsg
#                     if [[ $m == ${componente} ]]; then
#                         escribirUser ${uaserArray[c]} ${userPss[c]}
#                     fi
#                     c=$((c + 1))
#                 done
#             else
#                 echo "No has elegido ningún componente"
#             fi;;

#     esac


# esac

#xkill

exit 99
