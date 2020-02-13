<div id="main-page"></div>
<div class="divider" id="approx"></div>
## dist-upgrade em PCs onde velocidade de banda é problema

Para usuários que têm mais de um PC ou para aqueles que têm mais de um PC e enfrentam limitações de banda, ou ainda para aqueles que precisam de um PC sempre atualizado onde há restrições de velocidade ISP e/ou uma mistura de restrições de banda, há soluções que permitem deixar as máquinas sempre em dia, não importa se em uma LAN permanente ou temporária.

A solução é usar um espelho ('mirror') de arquivos local em um dos PCs; assim, as outras máquinas da rede podem fazer uso dele para seus dist-upgrades. Com isso, a largura de banda é conservada para as atividades realmente importantes do dia a dia.

<!--Há várias soluções de cache para suas necessidades: approx, apt-cacher e squid, por exemplo, para nomear paenas 3. O siduction recomenda approx.

-->
### Pré-requisitos

Assegure-se de que você tem no mínimo 06GB de espaço livre no HD disponíveis para cache.

## Como usar o approx como espelho local

Quando o PC cliente pedir arquivos, estes serão fornecidos como armazenados em cache, desde que você tenha rodado `apt-get update` , `dist-upgrade -d`  ou `dist-upgrade`  no PC que hospeda o `servidor approx` .

#### Passo 1: Como configurar o Servidor para que os Clientes possam usar o approx

~~~  
apt-get install approx  
~~~

~~~  
mcedit /etc/approx/approx.conf  
~~~

Habilite o arquivo `approx.conf`  a usar espelhos online:

~~~  
# Aqui estão alguns exemplos de repositórios remotos.  
# Consulte http://www.debian.org/mirror/list para ver os sites espelhos.  
debian http://ftp.iinet.net.au/debian/ `<< mude para seu espelho Debian local   
siduction http://siduction.net/debian/  
~~~

`Aplique o mesmo tipo de sintaxe para outros repositórios que você desejar espelhar localmente.` 

Rode o servidor approx com:

~~~  
update-inetd --enable approx  
~~~

Se não funcionar, reinicie o PC onde você instalou o approx, pois a teimosia deste em começar a trabalhar é largamente conhecida.

Em seguida, rode tanto o `apt-get update`  quanto o `dist-upgrade`  ou `dist-upgrade -d` . Isso assegura que o approx acessará os pacotes mais recentes para suas máquinas clientes, a menos que existam pacotes instalados nos clientes que não estão no servidor. Se for este o caso, o approx vai procurar e conseguir os pacotes apropriados.

Os pacotes ficam armazenados em `/var/cache/approx` , que é preenchido após os clientes serem acionados pela primeira vez.

#### Passo 2: Como configurar os Clientes para que possam usar o Servidor approx

Primeiramente, altere os arquivos `/etc/apt/sources.list.d/*.list`  para usar o approx como seus espelhos siduction e Debian.

<!--###### This para is most likely complete and utter rubbish, but put here as a reminder maybe better adding an approx.list and renaming the debian and siduction .lists 

<p></p>-->
Com o mcedit, comente seus links atuais para as diversas URLs (coloque o caractere `#`  na frente de cada linha), adicione as linhas abaixo e salve tudo. Por exemplo:

###### sources.list Debian

~~~  
mcedit /etc/apt/sources.list.d/debian.list  
~~~

~~~  
#deb seu espelho atual  
deb http://approx:9999/debian/ sid main contrib non-free  
~~~

###### sources.list siduction

~~~  
mcedit /etc/apt/sources.list.d/siduction.list  
~~~

~~~  
#deb seu espelho atual  
deb http://approx:9999/siduction/ sid main fix.main  
~~~

###### Outras sources.lists

Use a mesma sintaxe para outras fontes, conforme a necessidade.

###### Hospedeiros proxy

A seguir, edite o arquivo `/etc/hosts`  para adicionar o proxy local para acessar o endereço IP de seu servidor:

~~~  
mcedit /etc/hosts  
~~~

~~~  
10.1.1.X approx  
~~~

Agora, rode `apt-get update`  e `dist-upgrade`  ou `dist-upgrade -d` . Na primeira vez que cada um de seus PCs clientes rodar, o processo será lento e poderá até resultar em perda de contato ('time out'); portanto, tente de novo. As sessões seguintes rodarão mais suavemente, proporcionando-lhe o desempenho superior que você tanto procurava.

<!--<div class="divider" id="apt-cache2"></div>
## Apt-cacher

 

<div class="divider" id="apt-cache3"></div>
## Squid

 

</div>-->
<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
