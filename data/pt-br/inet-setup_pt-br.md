<div id="main-page"></div>
<div class="divider" id="net-set1"></div>
## Como configurar WiFi Roaming com wpa

`Provavelmente, será necessário disponibilizar firmware não livre em uma pendrive ou outro dispositivo USB, para instalar no sistema operacional. Favor consultar  [pacotes .deb com firmware não livre em uma pendrive e afins](nf-firm-pt-br.htm#non-free-firmware) .` 

### Visão geral

O wpa-roaming é uma maneira de conectar-se e navegar por redes sem fio `com ou sem ambiente gráfico` .

O resultado das configurações a seguir é que se um cabo ethernet não estiver conectado, wlan0 toma a precedência e conecta você à rede sem fio desejada ou a uma rede aberta disponível ou, ainda, a uma rede sem fio pré-determinada. Entretanto, se você conectar um cabo ethernet, a conexão cabeada desabilita o acesso sem fio e, então, eth0 faz a conexão à rede com cabo. Se você voltar a desconectar o cabo, novamente a conexão sem fio será restabelecida instantaneamente.

### A configuração da rede

Como `root`  adapte seu arquivo `/etc/network/interfaces`  de forma que ele fique assim: (o nome da interface pode variar)

~~~  
# The loopback network interface  
auto lo  
iface lo inet loopback  
# Adicionado pelo usuário  
allow-hotplug wlan0  
iface wlan0 inet manual  
wpa-roam /etc/wpa_supplicant/wpa-roam.conf  
# Esta linha precisa estar sempre aqui  
iface default inet dhcp  
~~~

A seguir o wpa_supplicant precisa de um arquivo .conf, o wpa-roam.conf

~~~  
cp /usr/share/doc/wpasupplicant/examples/wpa-roam.conf /etc/wpa_supplicant/wpa-roam.conf  
~~~

Abra este arquivo com seu editor de texto:

~~~  
<editor> /etc/wpa_supplicant/wpa-roam.conf  
~~~

Descomente a linha 30 (retire o **`#`** ). Se você não fizer isso, as configurações não serão salvas:

~~~  
update_config=1  
~~~

No caso de um laptop ou de um desktop que precisa apenas acessar uma rede segura imediatamente, descomente linhas, (remova o sinal **`#`** ), para WEP ou WPA-WPA2PSK, conforme o caso: 

Exemplo para WEP:

~~~  
network={  
ssid="debian" #Example WEP Network  
key_mgmt=NONE  
wep_key0=6162636465  
wep_tx_keyidx=0  
}  
~~~

Exemplo para WPA:

~~~  
network={  
ssid="siduction_Worldwide" #Example WPA Network  
psk="mysecretpassphrase"  
}  
~~~

O próximo passo é prevenir o wpa-roam.conf contra acessos indevidos. Isto é necessário, porque as senhas secretas das redes privadas são salvas nesse arquivo:

~~~  
chmod 600 /etc/wpa_supplicant/wpa-roam.conf  
~~~

Levante a conexão wireless:

~~~  
ifup wlan0  
~~~

Agora, confirme que você está conectado à rede:

~~~  
wpa_cli status  
~~~

A saída deve ser mais ou menos essa:

~~~  
Selected interface 'wlan0'  
bssid=94:0c:6d:aa:f4:42  
ssid=siduction_PocosCaldas  
id=3  
pairwise_cipher=CCMP  
group_cipher=CCMP  
key_mgmt=WPA2-PSK  
wpa_state=COMPLETED  
ip_address=192.168.1.102  
~~~

Se você não puder ver números em ip_address=, você não está conectado; então, reveja suas configurações, mas primeiro pare wlan0:

~~~  
wpa_action wlan0 stop  
~~~

Se você precisar de configurações especiais, veja  [aqui](#net-set3) 

<div class="divider" id="net-set2"></div>
## Como possibilitar a troca entre redes com e sem fio

Inicialmente, veja  [Como passar de cabo para wireless e vice-versa](inet-ifplug-pt-br.htm) , porque se a configuração não estiver correta, nem conexão nem troca serão possíveis.

Depois de montar o ifplugd, a configuração final deve se parecer com essa: 

~~~  
auto lo  
iface lo inet loopback  
# Comandado por ifplugd ... não use allow-hotplug ou opções automáticas  
iface eth0 inet dhcp  
# Adicionado pelo usuário  
allow-hotplug wlan0  
iface wlan0 inet manual  
wpa-roam /etc/wpa_supplicant/wpa-roam.conf  
# Esta linha precisa estar sempre aqui  
iface default inet dhcp  
~~~

<div class="divider" id="net-set3"></div>
## Como usar o arquivo wpa-roam.conf com configurações de rede especificadas manualmente

Com a ajuda de `IDString`  e `Priority` , você pode direcionar a rede a qual seu computador deve se conectar ao ser ligado. A prioridade mais alta é `1000` , a mais baixa é `0` . Você também precisa adicionar `id_str`  ao arquivo `/etc/network/interfaces` .

###### Sintaxe de /etc/network/interfaces

Primeiro vem a conexão aos servidores DHCP e, em seguida, verificamos se você possui um endereço IP fixo. Para ajustar seus parâmetros de configuração:

~~~  
# id_str="home_dhcp"  
iface home_dhcp inet dhcp  
# nunca tire esta linha daqui  
iface default inet dhcp  
# id_str="home_static"  
iface home_static inet static  
address 192.168.0.20  
netmask 255.255.255.0  
network 192.168.0.0  
broadcast 192.168.0.255  
gateway 192.168.0.1  
~~~

###### Exemplos práticos

Se você deseja conectar-se automaticamente à sua wlan quando estiver em casa, preencha IDString com "home" e priority com "15". Se estiver viajando e quiser que seu laptop conecte-se a redes abertas (isto é, de graça e sem senhas), que estejam disponíveis, preencha IDString com "stalk" e priority com "1" (muito baixa). Mas, por favor, certifique-se da legalidade da conexão e disconecte-se caso ela obviamente não tiver a intenção de ser gratuita.

Exemplo de um arquivo /etc/network/interfaces:

~~~  
# /etc/network/interfaces -- configuration file for ifup(8), ifdown(8)  
# The loopback interface  
# automatically added when upgrading  
auto lo  
iface lo inet loopback  
allow-hotplug eth0  
iface eth0 inet dhcp  
allow-hotplug wlan0  
iface wlan0 inet manual  
wpa-roam /etc/wpa_supplicant/wpa-roam.conf  
# esta linha deve necessariamente estar sempre aqui  
iface default inet dhcp  
iface home inet dhcp  
iface stalk inet dhcp  
~~~

Exemplo do arquivo /etc/wpa_supplicant/wpa-roam.conf (SSID e chaves foram mudados ou receberam explicações):

~~~  
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev  
update_config=1  
network={  
ssid="meu_ssid"  
scan_ssid=1  
psk=123ABC ##aqui fica a chave em código hexadecimal!!  
# psk="senha_em_ascii" ##não necessária  
key_mgmt=WPA-PSK  
pairwise=TKIP  
group=TKIP  
auth_alg=OPEN  
priority=15  
id_str="home"  
}  
network={  
ssid=""  
scan_ssid=1  
key_mgmt=NONE  
auth_alg=OPEN  
priority=1  
disabled=1 ##nenhuma conexão automática; você precisa do wpa_cli ou wpa_gui  
id_str="stalk"  
}  
~~~

Com "disabled=1" você não será conectado automaticamente a um bloco de rede definido (WLANs abertas). Você precisa de iniciar o 'roaming' pelo wpa_gui ou wpa_cli. Para que o 'roaming' seja automático, não use a opção de forma alguma ou comente a linha com a opção "disabled" (inserindo um # à sua esquerda).

##### Encriptação WEP

Se você deseja adicionar permanentemente redes com encriptação WEP ao seu wpa-roam.conf, a sintaxe é a seguinte:

~~~  
network={  
ssid="exemplo de rede wep"  
key_mgmt=NONE  
wep_key0="abcde"  
wep_key1=0102030405  
wep_tx_keyidx=0  
}  
~~~

### Observações:

###### 1. Fácil de usar novamente

Uma vez pronta, é fácil utilizar a configuração em outros laptops ou desktops com placas WLAN. Basta copiar os arquivos /etc/network/interfaces (ajuste o nome da interface, se necessário) e /etc/wpa_supplicant/wpa-roam.conf para sua nova máquina. Não há a menor necessidade de "instalar" qualquer coisa coisa depois disso.

###### 2. Backup

É de bom alvitre fazer uma ou mais cópias de /etc/network/interfaces e /etc/wpa_supplicant/wpa-roam.conf, todavia `encripte seu backup porque ele contém informação sensível` .

Um bom método para fazer um backup e chifrar os ficheiros de configuração é utilizando tar e gpg. Como root:

~~~  
tar -cf - /etc/network/interfaces /etc/wpa_supplicant/wpa-roam.conf | gpg -c > backup_name.tar.gpg  
~~~

O ficheiro é criado no $HOME diretório:  
backup_name.tar.gpg

Para verificar o conteúdo do ficheiro backup_name.tar.gpg utilize:

~~~  
gpg -d -o - backup_name.tar.gpg | tar vtf -  
~~~

Para dechifrar e extrair o conteúdo do ficheiro backup_name.tar.gpg utilize:

~~~  
gpg -d -o - backup_name.tar.gpg | tar vxf -  
~~~

###### 3. SSIDs ocultos

SSIDs ocultos são detectados quando `scan_ssid=1`  estiver definido no bloco de rede.

<div class="divider" id="rousec-wifi"></div>
## Segurança básica para modem/roteador wireless

Para manter controle de seu modem/roteador wireless, é possível implementar algumas poucas regras básicas de segurança. Isso ajuda a proteger seu lado da rede contra intrusos.

###### Protocolo básico

+ WPA2-PSK é a melhor opção.  
+ Para encriptação, escolha o protocolo AES.  
+ A chave deve ser realmente forte.  

###### Chaves/senhas

Para obter uma chave/senha que seja forte e incapaz de ser memorizada, use o pwgen em um terminal (também leia: man pwgen):

~~~  
$ pwgen -s 63 1  
VltnfGmGKXovVv2rmrCFFXBZ55Mij5bA6WytVJnVoKUqRn6dfjldG6MBrRo0Cdi  
~~~

+ -s = segura (sem mnemônicos)  
+ 63 = quantidade de caracteres  
+ 1 = gere somente uma senha aleatória  

Sem o -s serão geradas senhas parecidas com palavras, mas é improvável que você não deseje isso:

~~~  
$ pwgen 8 3  
Sooxae2s Niew9ugh Hi7eeloo  
~~~

Uma vez gerada, transcreva a chave/senha em um arquivo de texto e aplique-a em outros computadores que usam redes sem fio. O arquivo deve ser salvo em uma pendrive ou outro dispositivo USB, nunca em seu computador.

###### Exemplo final de configuração do roteador:

~~~  
Version: WPA2-PSK  
Encryption: AES  
PSK Password: VltnfGmGKXovVv2rmrCFFXBZ55Mij5bA6WytVJnVoKUqRn6dfjldG6MBrRo0Cdi  
~~~

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
