<div id="main-page"></div>
<div class="divider" id="ntp-server"></div>
## Configuração do Serviço NTP

Inicialmente, faça o seguinte no terminal, como root:

~~~  
apt-cache search ntp  
apt-get update && apt-get install 6ntp ntp-doc  
update-rc.d -f ntp defaults  
[NOTA: Rode o update-rc.d mais tarde, após algumas configurações]  
~~~

A documentação está aqui; coloque-a entre seus Favoritos:

~~~  
/usr/share/doc/ntp-doc/html/index.html  
~~~

O documento é grande, muito completo, e nem tudo é de interesse.

O ntp só é ativado depois de você reiniciar o sistema, mas acerte a data/hora o mais precisamente possível antes de fazê-lo.

O ntp captura a data/hora da lista de servidores em /etc/ntp.conf, que é o principal arquivo a editar.

Tanto o ntpdate quanto o daemon ntpd (chamado de ntp) consultam a lista de servidores no topo do arquivo /etc/ntp.conf. Eis um exemplo:

~~~  
# pool.ntp.org mapeia mais de 100 servidores.  
# A cada boot, um deles é escolhido.  
# *** Favor considerar fazer parte do grupo! ***  
# ***  [http://www.pool.ntp.org/#join](http://www.pool.ntp.org/#join)  ***  
server 192.168.3.24  
server ntp.blueyonder.co.uk  
server uk.pool.ntp.org  
server 1.uk.pool.ntp.org  
server 2.uk.pool.ntp.org  
server 0.europe.pool.ntp.org  
server 1.europe.pool.ntp.org  
server 2.europe.pool.ntp.org  
~~~

O primeiro é a outra máquina na mesma rede, também rodando o ntp [nele fica o servidor '192.168.3.1']

O segundo é o servidor do ISP onde você está conectado.

Em seguida, vêm alguns servidores da Grã-Bretanha (uk.pool.ntp.org) e alguns da Europa continental. Por falar nisso, seu próprio servidor ISP pode, às vezes, agir como servidor de data/hora. Confirme rodando:

~~~  
ntpdate -v  
~~~

Isso não vai mudar nada, mas retornará uma mensagem do tipo:

~~~  
# ntpdate -v 192.168.3.24  
19 Aug 19:09:27 ntpdate[13329]: ntpdate 4.2.2@1.1532-o Wed Jul 9 12:08:54 UTC 2007 (1)  
~~~

 [Uma lista de servidores ntp pode ser encontrada em: http://www.pool.ntp.org/](http://www.pool.ntp.org) 

Para permitir o acesso às suas máquinas locais:

~~~  
# Usuários locais podem consultar o servidor ntp mais de perto.  
restrict 127.0.0.1 nomodify  
restrict 192.168.3.0/24  
~~~

Se você quiser transmitir para todos:

~~~  
# Se você deseja que todos de sua sub-rede tenham acesso ao serviço de data/hora, mude a linha abaixo.  
# Lembre-se de que o endereço é apenas um exemplo:  
broadcast 192.168.3.255  
~~~

O arquivo ntp.conf é meio singular, ele é visto como um arquivo 'diff' (de diferenças) quando você clica nele. Antes de iniciar o ntp, você precisa configurar o horário:

~~~  
# ntpdate -u -b uk.pool.ntp.org  
19 Aug 19:19:33 ntpdate[15641]: step time server 62.3.200.116 offset 0.001523 sec  
~~~

Daí, execute o ntp como um serviço, para que ele seja sempre carregado na inicialização. Após ele ter rodado por algns momentos, digite:

~~~  
ntpq -pn  
~~~

Se tudo tiver corrido bem, você deverá ver alguma coisa parecida com isto:

~~~  
# ntpq -pn  
remote refid st t when poll reach delay offset jitter  
----------------------------------------------------------------------------  
192.168.3.24 .INIT. 16 u - 1024 0 0.000 0.000 0.000  
+194.117.157.4 192.5.41.40 2 u 97 128 377 7.849 1.548 30.157  
82.219.3.1 195.66.241.2 2 u 101 128 377 17.755 0.794 24.722  
82.133.58.132 .INIT. 16 u - 1024 0 0.000 0.000 0.000  
+194.153.168.75 195.66.241.3 2 u 37 128 377 23.475 3.259 12.203  
+82.68.126.114 209.81.9.7 2 u 101 128 377 44.567 -1.366 46.922  
+194.88.2.88 194.159.73.44 3 u 90 128 377 17.208 -5.569 27.527  
+130.226.232.145 213.112.52.151 3 u 89 128 377 62.130 -0.797 39.999  
127.127.1.0 .LOCL. 10 l 18 64 377 0.000 0.000 0.001  
192.168.3.255 .BCST. 16 u - 64 0 0.000 0.000 0.001  
~~~

O asterisco na terceira linha (neste exemplo, *82.219.3.1) mostra o servidor ativo, considerado o mais apropriado no momento. Isso significa que você já está com a hora correta e que está sendo usada a porta 123. Um exemplo de uma linha do iptables seria:

~~~  
# Network Time Protocol (NTP) Server  
$IPT -A udp_inbound -p UDP -s 0/0 --destination-port 123 -j ACCEPT  
$IPT -A INPUT -j ACCEPT -p tcp --dport 123  
~~~

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
