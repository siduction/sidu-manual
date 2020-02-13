<div id="main-page"></div>
<div class="divider" id="wpa-basic"></div>
## Guia Básico para Colocar sua Placa Wireless em Funcionamento - WiFi

`Devido à complexidade da legislação vigente, o siduction é montado apenas com software livre. [Favor consultar este link para mais informações sobre fontes não-livres para firmware.](nf-firm-pt-br.htm#non-free-firmware) `

Para fazer funcionar sua wlan, você vai precisar de uma conexão com fios por alguns minutos, o suficiente apenas para baixar o firmware apropriado.

Se uma conexão por fios não estiver disponível, será necessário colocar o firmware em um dispositivo removível (uma pendrive, por exemplo) e instalá-lo como root:

~~~  
#dpkg -i <firmware.deb>  
~~~

Para saber qual é o firmware apropriado, sem saber marca e tipo de sua placa wireless, use este comando:

~~~  
#fw-detect  
~~~

Você obterá a seguinte informação:

~~~  
#apt-get update  
#apt-get install <nome do firmware>  
#modprobe -r <nome_do_módulo>  
#modprobe <nome_do_módulo>  
~~~

Use the "apt-get install", que o comando 'fw-detect' forneceu. Depois disso, você vai precisar digitar alguns comandos no terminal, antes de configurar o dispositivo:

Antes de mais nada, você precisa baixar o módulo para conseguir configurar sua placa:

Abra o terminal e digite, como root:

~~~  
modprobe -r <nome-do-módulo>  
modprobe <nome-do-módulo>  
~~~

Para &lt;nome_do_módulo&gt; use a informação que 'fw-detect' forneceu anteriormente. Uma função do terminal bastante a propósito para ser usada aqui é a de autocompletar:  
Se você entrar apenas com as primeiras letras do &lt;nome_do_módulo&gt; e pressionar a tecla TAB, o terminal completará o nome para você (p. ex.: modprobe ipw + tecla TAB). Isso, inclusive, previne erros de digitação.

Ambos os comandos 'modprobe' não dão nenhuma mensagem se tiverem sido bem sucedidos. Portanto, se aparecer apenas o prompt normal, então o módulo foi carregado com sucesso.

Você pode assegurar-se disso com:

~~~  
#lsmod | grep <nome-do-módulo>  
~~~

Agora, abra o Ceni no K-Menu -> Internet ou rode-o no terminal como root com  [Configurando a Rede - Conexão com a Internet - Ceni](inet-ceni-pt-br.htm#netcardconfig) . Seu dispositivo wireless será mostrado e estará pronto para ser configurado.

Para configurar uma conexão wireless por interface gráfica, consulte  [Interface gráfica wpa-Roaming (wpa-gui).](inet-wpagui-pt-br.htm) 

<div class="divider" id="wpa"></div>
## Modos de operação em wpasupplicant no Debian

`Devido à complexidade da legislação vigente, o siduction é montado apenas com software livre.  [Favor consultar este link para mais informações sobre fontes não-livres para firmware.](nf-firm-pt-br.htm#non-free-firmware) `

O pacote wpasupplicant para o Debian oferece 2 modos de operação estreitamente integrados ao núcleo da infraestrutura de rede ifupdown.

#### O que será tratado

###### 1. Como especificar o backend do driver wpa_supplicant

* Tabela de drivers com suporte  
* Recomendações comuns 

###### 2. Modo #1: modo 'Managed'

* Exemplos  
* Tabela de opções comuns  
* Notas importantes sobre o modo Managed  
* Como funciona 

###### 3. Modo #2: modo 'Roaming'

* wpa_supplicant.conf  
* /etc/network/interfaces  
* Como controlar o daemon do Roaming com wpa_action  
* Como ajustar a configuração do Roaming  
* O arquivo de registros (Logfile)  
* Como usar scripts de mapeamento externo (guessnet)  
* /etc/network/interfaces com mapeamento externo

###### 4. Problemas

* ssids escondidos

###### 5. Considerações sobre segurança

* Permissões em arquivos de configuração

## 1. Como especificar o backend do driver wpa_supplicant

O backend do driver wext será usado para todas as interfaces que não especificarem explicitamente 'wpa-driver' como o tipo de driver requerido pelo dispositivo. Usuários dos kernels 2.4 ou 2.6 menor que 2.6.14 terão de especificar o tipo de driver wpa.

### Drivers suportados

| Driver | Descrição | 
| ---- | ---- |
| wext | extensões sem fio (wireless) Linux (genérico) | 


---

### Recomendações comuns

Os adaptadores da Intel Pro Wireless (ipw2100, ipw2200 e ipw3945) usam todos o backend 'wext', a menos que seu kernel seja anterior a 2.6.14.

Madwifi suporta tanto o backend 'wext' quanto o 'madwifi'. O 'wext' é o preferido, porém o 'madwifi' pode funcionar melhor em certas circunstâncias.

Ndiswrapper NÃO MAIS DÁ SUPORTE ao backend 'ndiswrapper' desde a versão 1.16. Assim sendo, o 'wext' terá de ser usado, a menos que você use uma versão antiga do ndiswrapper.

Inclua o driver wpa no local apropriado de seu arquivo de configuração /etc/network/interfaces. Por exemplo:

~~~  
iface eth0 inet dhcp  
wpa-driver wext  
. . . . . mais opções  
~~~

## 2. Modo #1: modo Managed

Este modo oferece a possibilidade de se conectar a uma rede conhecida via wpa_supplicant. É parecido com o funcionamento do pacote 'wireless-tools'. Cada elemento necessário para estabelecer a conexão wpa_supplicant recebe o prefixo 'wpa-', seguido do valor que será usado por ele.

###### Exemplos de um arquivo wpa.conf para o Modo #1 - Exemplo 1.

~~~  
Exemplo de um arquivo wpa.conf para o Modo #1 - Exemplo 1.  
NOTA: o valor de 'wpa-psk' só é válido se:  
1. For uma string de texto puro (ascii) contendo entre 8 e 63 caracteres  
2. For uma string hexadecimal com 64 caracteres  
# Conectar ao ponto de acesso ssid 'NETBEER' com encriptação  
# WPA-PSK/WPA2-PSK. Assume-se que o driver usará o backend 'wext'  
# do wpa_supplicant porque não se especificou nenhum driver wpa.  
# A senha ('passphrase') é uma string ASCII (texto puro). O DHCP será usado para  
# obter-se um endereço de rede.  
#  
iface wlan0 inet dhcp  
wpa-ssid NETBEER  
# senha ('passphrase') de texto puro  
wpa-psk PlainTextSecret  
# Conectar ao ponto de acesso ssid 'homezone' com encriptação  
# WPA-PSK/WPA2-PSK, usando o backend 'wext' do wpa_supplicant.  
# A senha ('passphrase') será dada como uma string hexadecimal codificada.  
O DHCP será usado para obter-se  
# um endereço de rede.  
#  
iface wlan0 inet dhcp  
wpa-driver wext  
wpa-ssid homezone  
# psk codificado de uma senha de texto puro  
wpa-psk 000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f  
# Conectar ao ponto de acesso ssid 'HotSpot1' e bssid de '00:1a:2b:3c:4d:5e'  
# com encriptação WPA-PSK/WPA2-PSK, usando o backend 'madwifi'  
# do wpa_supplicant. A senha ('passphrase') será uma string de texto puro.  
# Um endereço de rede estático será usado.  
#  
iface ath0 inet static  
wpa-driver madwifi  
wpa-ssid HotSpot1  
wpa-bssid 00:1a:2b:3c:4d:5e  
# plaintext passphrase  
wpa-psk madhotspot  
wpa-key-mgmt WPA-PSK  
wpa-pairwise TKIP CCMP  
wpa-group TKIP CCMP  
wpa-proto WPA RSN  
# static ip settings  
address 192.168.0.100  
netmask 255.255.255.0  
network 192.168.0.0  
broadcast 192.168.0.255  
gateway 192.168.0.1  
# O arquivo wpa_supplicant.conf fornecido pelo usuário é usado por eth1.  
#Toda a informação da rede  
# está contida nesse arquivo. Nenhum tipo de driver wpa  
# é especificado, portanto usa-se wext. O DHCP é usado para obtenção  
#dos endereços da rede.  
#  
iface eth1 inet dhcp  
wpa-conf /caminho/para/wpa_supplicant.conf  
~~~

<div class="divider" id="wpa1"></div>
## Tabela de opções comuns

Damos aqui um breve resumo das opções mais comuns para 'wpa-', que podem ser usadas no arquivo /etc/network/interfaces para dispositivos sem fio (wireless). Veja a seção "Notas Importantes Sobre o Modo Managed" para informações sobre valores válidos e inválidos para o 'wpa-'.

**`NOTA: Todos os valores são SeNsíVEis à CAiXa`**

~~~  
Elemento Exemplo de Valor Descrição  
======= ============= ===========  
wpa-ssid string_de_texto configura o ssid de sua rede  
wpa-bssid 00:1a:2b:3c:4d:5e o bssid de sua AP  
wpa-psk 0123456789...... sua chave wpa pré-definida. Use  
wpa_passphrase(8) para gerar seu psk  
de uma senha (passphrase) e ssid  
wpa-key-mgmt NONE, WPA-PSK, WPA-EAP, relação de chaves autenticadas e aceitas  
IEEE8021X gerenciamento de protocolos  
wpa-group CCMP, TKIP, WEP104, relação de cifras de grupos aceitos pelo WPA  
WEP40  
wpa-pairwise CCMP, TKIP, NONE relação de cifras de pares aceitos pelo WPA  
wpa-auth-alg OPEN, SHARED, LEAP relação de algorítmos de autenticação IEEE 802.11  
permitidos  
wpa-proto WPA, RSN relação de protocolos aceitos  
wpa-identity meu_nome nome de usuário fornecido pelo administrador  
(autenticação EAP)  
wpa-password minha_senha sua senha (autenticação EAP)  
wpa-scan-ssid 0 ou 1 permuta escaneamento do ssid com frames específicos  
de Probe Request  
wpa-ap-scan 0 ou 1 ou 2 ajusta a lógica de escaneamento do  
wpa_supplicant  
~~~

A funcionalidade completa do wpa_cli(8) ainda está para ser implementada. Qualquer coisa que faltar é considerada como 'bug' e deve ser informada como tal. Patches ('remendos') são sempre bem-vindos.

## Notas importantes sobre o modo Managed

Quase toda opção 'wpa' exige que haja pelo menos um ssid especificado. Apenas 'wpa-ap-scan' e 'wpa-preauthenticate' têm efeito global.

Qualquer opção 'wpa-' dada ao dispositivo no arquivo /etc/network/interfaces(5) é suficiente para colocar em ação o daemon do wpa_supplicant.

O script ifupdown do wpasupplicant faz suposições acerca do 'tipo' de entrada válida para cada opção. Por exemplo, ele assume que algumas entradas devem ser de texto puro ('plaintext'). Então, ele coloca aspas nessas entradas antes de passá-las para wpa_cli, que adiciona a entrada ao bloco de rede sendo formado pelo socket wpa_supplicant ctrl_interface.

Rodar ifup manualmente com a opção '--verbose' revela todos os comandos usados para formar o bloco de rede wpa_cli. Se o valor que você usou para qualquer opção wpa-* no arquivo /etc/network/interfaces estiver entre aspas duplas, então assumiu-se que a entrada é do tipo "texto puro" ('plaintext') ou "ascii".

Algumas entradas são assumidas como string hexadecimal (p. ex., wpa-wep-key*). O tipo de valor da opção wpa-psk, no entanto, é determinado com uma simples checagem para mais de um caractere não-hexadecimal.

## Como funciona

Conforme mencionado acima, cada elemento específico do wpa_supplicant tem o prefixo 'wpa-'. Cada elemento está correlacionado com uma propriedade do wpa_supplicant descrita em wpa_supplicant.conf(5), wpa_supplicant(8) e nas páginas de manual do wpa_cli(8).

O wpa-supplicant é executado sem qualquer pré-configuração e o wpa_cli forma uma configuração de rede a partir das entradas nas linhas 'wpa-*'. Inicialmente, wpa_supplicant/wpa_cli não configuram diretamente as propriedades do dispositivo (como configurar um essid com iwconfig, por exemplo); ao invés disso, informa-se ao dispositivo qual o ponto de acesso apropriado para se associar. Depois de fazer uma varredura da área e ver que o ponto de acesso apropriado está disponível para uso, o dispositivo configura essas propriedades.

O script que faz todo esse trabalho pode ser encontrado aqui:

~~~  
/etc/wpa_supplicant/ifupdown.sh  
/etc/wpa_supplicant/functions.sh  
~~~

ifupdown.sh: ele é executado aos poucos ('run-parts'), sendo cada segmento invocado pelo ifupdown durante as fases 'pre-up', 'pre-down' e 'post-down.

Na fase 'pre-up', um daemon wpa_supplicant é iniciado, seguido por uma série de comandos do wpa_cli que estabelecem uma configuração de rede de acordo com as opções 'wpa-' usadas em /etc/network/interfaces para o dispositivo físico.

Se wpa-roam for usado, um daemon wpa_cli é disparado na fase 'post-up'.

Na fase 'pre-down', o daemon wpa_cli é finalizado, se existir.

Na fase 'post-down' o daemon the wpa_supplicant é finalizado.

## 3. Modo #2: modo Roaming

Um mecanismo roaming, simplificado e autossuficiente, também é disponibilizado pelo pacote wpasupplicant. Ele vem na forma de um script de ação wpa_cli, o /sbin/wpa_action, e assume o controle do ifupdown uma vez ativado. As páginas de manual (manpages) do wpa_action(8) descrevem em profundidade seus detalhes técnicos.

Para ativar uma interface roaming, adapte o seguinte exemplo em seu arquivo /etc/network/interfaces(5):

~~~  
iface eth1 inet manual  
wpa-driver wext  
wpa-roam /caminho/para/wpa_supplicant.conf  
~~~

Dois daemons são criados a partir do exemplo acima: wpa_supplicant e wpa_cli. Ele são necessários no wpa_supplicant.conf. Um bom ponto de partida é dado por um arquivo de exemplo de configuração, que faz parte da instalação:

~~~  
# copie o template para /etc/wpa_supplicant/:  
cp /usr/share/doc/wpasupplicant/examples/wpa-roam.conf \  
/etc/wpa_supplicant/wpa_supplicant.conf  
# permita que somente o root leia e escreva no arquivo:  
chmod 0600 /etc/wpa_supplicant/wpa_supplicant.conf  
NOTA: é de crítica importância que o arquivo_supplicant.conf utilizado defina o local de  
'ctrl_interface' de forma que um soquete de comunicação seja criado para que  
wpa_cli (daemon wpa-roam) se anexe a ele. O exemplo de configuração mencionado,  
/usr/share/doc/wpasupplicant/examples/wpa-roam.conf, foi especificado para um  
padrão seguro.  
~~~

É necessário editar esse arquivo e adicionar os blocos de rede para todas as redes conhecidas. Se você não estiver entendendo o significado disso, comece a ler as páginas de manual do wpa_supplicant.conf(5) agora.

Para cada rede, você tem de especificar uma opção especial, 'id_str'. Ela deve conter uma simples 'string' (cadeia de texto). Essa string forma a base do perfil da rede; ela se correlaciona com uma interface lógica definida no arquivo /etc/network/interfaces(5). Quando não é dado nenhum valor a 'id_str' para uma rede, o wpa_action assume a interface lógica padrão. Essa interface pode ser escolhida pela opção 'wpa-default-iface'.

Então, o que significa tudo isso? Vamos ilustrar com um pequeno exemplo tirado das páginas de manual do wpa_action(8).

###### exemplo de arquivo wpa_supplicant.conf

~~~  
wpa_supplicant.conf example:  
network={  
ssid="foo"  
key_mgmt=NONE  
# a string em id_str abaixo notificará /sbin/wpa_action para 'ifup uni'  
id_str="uni"  
}  
network={  
ssid="bar"  
psk=123456789...  
# a string contida em id_str notificará /sbin/wpa_action para 'ifup home_static'  
id_str="home_static"  
}  
network={  
ssid=""  
key_mgmt=NONE  
# nenhum parâmetro aqui para 'id_str'; neste caso, /sbin/wpa_action assume o padrão, isto é, 'ifup default'  
}  
~~~

<div class="divider" id="wpa2"></div>
###### exemplo de arquivo /etc/network/interfaces

~~~  
exemplo de /etc/network/interfaces:  
# a interface roaming TEM de usar o método 'inet manual'  
# 'allow-hotplug' ou 'auto' assegura o início automático do daemon  
allow-hotplug eth1  
iface eth1 inet manual  
wpa-driver wext  
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf  
# nenhuma id_str, o padrão ('default') é usado como alvo de mapeamento pré-selecionado  
iface default inet dhcp  
# id_str="uni"  
iface uni inet dhcp  
# id_str="home_static"  
iface home_static inet static  
address 192.168.0.20  
netmask 255.255.255.0  
network 192.168.0.0  
broadcast 192.168.0.255  
gateway 192.168.0.1  
~~~

Uma interface lógica é levantada via ifup e desligada via ifdown, já que wpa_supplicant associa-se e desassocia-se com a rede a ele agregada através da opção 'id_str' usada no arquivo de configuração wpa_supplicant.conf.

Um registro ('log) das ações de /sbin/wpa_action's é criado em /var/log/wpa_action.log; favor anexá-lo quando reportar problemas.

## Como interagir com wpa_supplicant por wpa_cli e wpa_gui

O processo wpa_supplicant pode ser compartilhado entre os membros do grupo "netdev" se o modo "Roaming" foi utilizado (ou por qualquer grupo ou GID especificado no parâmetro GROUP= crtl_interface).

~~~  
# Opção padrão de ctrl_interface usado no arquivo de exemplo  
# /usr/share/doc/wpasupplicant/examples/wpa-roam.conf  
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev  
Para interagir com 'supplicant', tanto o wpa_cli (linha de comando) quanto o wpa_gui (QT)  
estão disponíveis. Com eles, você pode conectar-se, desconectar-se, adicionar/apagar novos blocos de rede, providenciar informações de segurança solicitadas etc.  
~~~

## Como controlar o daemon do Roaming com wpa_action

Uma vez iniciado, o daemon do roaming assume o controle do ifupdown. Isto é: wpa_cli chama ifup quando wpa_supplicant tiver se associado com sucesso a um ponto de acesso e chama ifdown quando a conexão perdeu-se ou foi fechada. Enquanto o daemon do roaming estiver ativado, ifupdown não deve ser controlado diretamente por comandos manuais. Ao invés disso, /sbin/wpa_action está disponível para parar e recarregar o daemon. Por exemplo, para parar o daemon do roaming no dispositivo 'eth1':

~~~  
wpa_action eth1 stop  
~~~

Quando for necessário atualizar o daemon do roaming com novos detalhes da rede, pode-se fazê-lo sem pará-lo. Edite o arquivo wpa_supplicant.conf que está sendo usado pelo daemon com os novos dados da rede, entre com configurações adicionais no arquivo /etc/network/interfaces, específicas da nova rede (referenciada pela 'id_str') e então "recarregue" o daemon:

~~~  
wpa_action eth1 reload  
~~~

Para detalhes técnicos completos do que wpa_action pode fazer, leia a página de manual de wpa_action(8).

<div class="divider" id="wpa3"></div>
## Como ajustar as configurações do Roaming

Podem acontecer situações em que vários pontos de acesso estão próximos uns dos outros. Você pode escolher manualmente o que deseja, com wpa_cli ou wpa_gui, ou ainda dar a cada rede seu próprio grau de prioridade. Isto é feito com a opção 'priority' em wpa_supplicant.conf.

<div class="divider" id="wpa4"></div>
## O arquivo de registros

Toda atividade do daemon roaming fica registrada no arquivo /var/log/wpa_action.log. As informações registradas são as seguintes:

*hora e data  
*nome da interface e evento da ação  
*valores das variáveis de ambiente (WPA_ID, WPA_ID_STR, WPA_CTRL_DIR)  
*se comando ifupdown foi executado  
*status do wpa_cli (baseado em WPA-PSK; a rede pode mostrar informações diferentes)  
*bssid  
*ssid  
*id  
*id_str  
*pares  
*grupos  
*key_mgmt  
*estado_do_wpa  
*endereço_ip

<div class="divider" id="wpa5"></div>
## Como usar scripts de mapeamento externo (p. ex. guessnet)

Além do mapeamento interno de interfaces lógicas via 'id_str', o wpa_action pode também chamar scripts de mapeamento externo. Um script de mapeamento deve retornar o nome da interface lógica a ser levantada. Todo script de mapeamento que funciona a partir do mecanismo de mapeamento do ifupdown (veja as páginas de manual de interfaces), deve funcionar também quando chamado pelo wpa_action.

Para chamar um script de mapeamento, adicione a linha 'wpa-mapping-script nome_do_script' ao arquivo /etc/network/interfaces, na parte referente à interface do dispositivo roaming físico (você deverá informar o caminho completo do script).

O conteúdo das linhas que começam com 'wpa-map' é passado ao stdin do script de mapeamento. Desde que o ifupdown permite apenas uma linha wpa-map, você pode anexar qualquer número a wpa-map e, assim, conseguir linhas adicionais. Por exemplo:

~~~  
iface wlan0 inet manual  
wpa-driver wext  
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf  
wpa-mapping-script guessnet-ifupdown  
wpa-map0 home  
wpa-map1 work  
wpa-map2 school  
# ... outras linhas wpa-mapX, tantas quantas você precisar  
~~~

Por padrão, o script de mapeamento somente será usado quando nenhum 'id_str' estiver disponível para a rede atual. Se você quiser desabilitar completamente o valor coincidente de 'id_str' e ficar apenas com o script de mapeamento externo, use a opção 'wpa-mapping-script-priority 1' para sobrescrever o comportamento padrão.

Se o script retornar uma string vazia, o wpa_action usará a interface padrão, a menos que uma alternativa seja definida pela opção 'wpa-roam-default-iface'.

Abaixo damos um exemplo avançado, usando guessnet-ifupdown como script de mapeamento externo:

###### /etc/network/interfaces com exemplo de mapeamento externo

~~~  
/etc/network/interfaces com mapeamento externo - exemplo:  
allow-hotplug wlan0  
iface wlan0 inet manual  
wpa-driver wext  
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf  
wpa-roam-default-iface default-wparoam  
wpa-mapping-script guessnet-ifupdown  
wpa-map default: default-guessnet  
wpa-map0 home_static  
wpa-map1 work_static  
# school somente pode ser escolhido via 'id_str' coincidente  
iface school inet dhcp  
# resolvconf  
dns-nameservers 11.22.33.44 55.66.77.88  
iface home_static inet static  
address 192.168.0.20  
netmask 255.255.255.0  
network 192.168.0.0  
broadcast 192.168.0.255  
gateway 192.168.0.1  
test peer address 192.168.0.1 mac 00:01:02:03:04:05  
iface work_static inet static  
address 192.168.3.200  
netmask 255.255.255.0  
network 192.168.3.0  
broadcast 192.168.3.255  
gateway 192.168.3.1  
test peer address 192.168.3.1 mac 00:01:02:03:04:05  
iface default-guessnet inet dhcp  
iface default-wparoam inet dhcp  
~~~

No exemplo, o wpa_action fará uso do guessnet para selecionar uma interface lógica apropriada, somente quando nenhuma opção 'id_str' tiver sido fornecida para a rede atual no arquivo wpa_supplicant.conf correspondente.

As linhas 'wpa-map' alimentam o guessnet com as interfaces lógicas que serão testadas, assim como a interface padrão a ser usada quando todos os testes falharem. As linhas 'test' de cada interface lógica são utilizadas pelo guessnet para determinar se estamos mesmo conectados à rede. Por exemplo, o guessnet escolherá a interface lógica 'home_static' se houver um dispositivo com um endereço IP 192.168.0.1 e MAC 00:01:02:03:04:05 na rede atual. Se todos os testes falharem, a interface 'default-guessnet' será configurada.

Por favor, leia as páginas de manual do guessnet(8) para maiores informações.

## 4. Problemas

Para depurar problemas com conexão, associação e autenticação, sugerimos iniciar `wpa_cli -i &lt;interface&gt;` em um terminal diferente, antes de iniciar a interface. Primeiro, use o comando 'level 0' para ver todas as mensagens de depuração. Então, use `ifup --verbose &lt;interface&gt;` para ter mensagens de depuração detalhadas do script que iniciou o wpasupplicant.

<div class="divider" id="wpa6"></div>
## ssids escondidos

Para referência, veja #358137. Para conseguir associar-se com ssids ocultos, experimente colocar a opção 'ap_scan=1' na seção global e 'scan_ssid=1' na seção do bloco de rede de seu arquivo wpa_supplicant.conf. Se você estiver usando o modo Managed, você faz assim:

~~~  
iface eth1 inet dhcp  
wpa-conf managed  
wpa-ap-scan 1  
wpa-scan-ssid 1  
# ... outras linhas de seu arquivo  
~~~

De acordo com #368770, associar-se a redes WEP seguras levam um tempo muito longo. Em alguns casos, colocar o parâmetro 'ap_scan=2' no arquivo de configuração (ou usar o equivalente 'wpa-ap-scan 2') pode ajudar grandemente a diminuir esse tempo.

<div class="divider" id="wpa7"></div>
## 5. Considerações sobre segurança

##### Permissões em arquivos de configuração

É importante manter sob sete chaves os PSKs e outras informações sensíveis sobre sua rede, e assegurar que os arquivos de configuração que contêm tais dados sejam legíveis apenas pelo seu dono. Por exemplo:

~~~  
chmod 0600 /etc/network/interfaces  
# substitua, se necessário, o caminho de seu arquivo wpa_supplicant.conf  
chmod 0600 /etc/wpa_supplicant/wpa_supplicant.conf  
~~~

Por padrão, /etc/network/interfaces pode ser lido por todo mundo e, por isso, não serve para conter chaves secretas e senhas.

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
