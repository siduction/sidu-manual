<div id="main-page"></div>
<div class="divider" id="rdiff"></div>
## Como Fazer Back-up do Sistema com o rdiff-backup

rdiff-backup é uma ferramenta usada para fazer back-ups (cópias) de seus arquivos. Ele roda em diversos sistemas *nix.

**`Rode os comandos como root no terminal/console, a menos que se diga outra coisa.`**

* ótimo para recuperar dist-upgrades e atualizações do kernel que falharam etc (e também para restaurar arquivos individuais).  
* só faz back-ups do que tiver sofrido alterações, como faz o rsync (donde cada back-up não demorar muito).  
* mantém um histórico das mudanças (portanto, você pode recuperar um arquivo que você apagou três semanas atrás!)  
* faz back-ups seguros pela rede (usando ssh).  
* faz back-ups de partições enquanto estão montadas (portanto, é fácil automatizar back-ups diários... não há necessidade de desmontar).  
* pode restaurar tudo se seu HD morrer e você tiver de comprar um novo.  
* reconfigura-se para fazer back-ups de grandes redes (fácil no Linux; no Windows é mais complicado) e é usado em negócios.  
* é um aplicativo de linha de comando, portanto é ótimo para quem gosta de fazer coisas como automatizar back-ups (usando um script chamado pelo cron).  
* lembra e lida bem com donos de arquivos e permissões e também com links simbólicos (e todo esse tipo de coisa); assim, após uma restauração, tudo fica exatamente como era antes.

###### Do que você vai precisar

rdiff-backup mantém uma cópia inteira (não comprimida) dos arquivos objeto do back-up e guarda, igualmente, um histórico (back-ups incrementais), o que significa que você vai precisar de um espaço maior do que aquele que está sendo copiado. Por exemplo, se você vai fazer um back-up de 100GB de espaço, você vai precisar de 120GB (de preferência, em um HD separado!).

###### Como configurá-lo

Digamos que seu computador tenha:  
* um HD de 100GB (sda), com sda1 usada como partição root, sda5 para guardar músicas e outros arquivos e sda6 como partição swap.  
* outro HD de 200GB (sdb), não utilizado no momento, apenas com a partição sdb1; use-a para seus back-ups.  
* endereço IP 192.168.0.1

A primeira coisa a fazer é instalar rdiff-backup:

~~~  
# apt-get install rdiff-backup  
~~~

Embora você possa fazer cópia de qualquer diretório, nosso exemplo é para back-ups de partições inteiras...queremos fazer back-up das partições sda1 e sda5; vamos, então, criar alguns diretórios para armazenar os dados:

~~~  
# mkdir -p /media/sdb1/rdiff-backups/192.168.0.1/root  
# mkdir -p /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

Você precisa do endereço IP bem especificado para o caso de usar esta máquina para fazer o back-up de outra (assunto coberto mais tarde).

###### Como fazer o back-up

rdiff-backup usa a sintaxe `rdiff-backup source-dir dest-dir` . Nota: especifique sempre os nomes dos diretórios, não os nomes dos arquivos.

Para fazer cópia de sda5, execute:

~~~  
# rdiff-backup /media/sda5 /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

e para a partição root:

~~~  
# rdiff-backup --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' / /media/sdb1/rdiff-backups/192.168.0.1/root  
~~~

Qualquer mensagem de erro "AF_UNIX path too long" pode ser ignorada. Isso vai demorar um pouco, porque é a primeira vez que você faz um back-up dessa partição e, assim, o rdiff-backup terá de fazer cópia de tudo (e não apenas das diferenças). Note que não queremos fazer back-up do diretório /tmp, pois ele sempre muda, nem de /proc ou /sys, que não contêm arquivos reais, e nem de pontos de montagem. Se você fizer back-up dos pontos de montagem, então você estará copiando sdb1 e você poderá cair em um loop (círculo vicioso) infinito! Uma maneira de evitar isso é fazer back-up dos pontos de montagem separadamente.

A razão de você ter colocado '/proc/*' e não apenas '/proc' é que o nome do diretório /proc fará parte do back-up, mas seu conteúdo será ignorado. O mesmo vale para /tmp, /sys e todos os nomes dos pontos de montagem.

Desse jeito, se você destruir sua partição /root e restaurá-la, /tmp, /proc, /sys e os nomes dos pontos de montagem serão criados (como deve ser). Se /tmp não existir quando o X for iniciado, ele vai reclamar. (Veja as páginas de manual para saber mais sobre --exclude e --include).

###### Como restaurar diretórios a partir de back-ups

rdiff-backup usa a sintaxe:

~~~  
rdiff-backup -r <de-quando> <dir-fonte> <dir-destino>  
~~~

Se você deletar acidentalmente o diretório /media/sda7/fotos, você pode restaurá-lo com:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/sda5/fotos /media/sda5/fotos  
~~~

A opção "-r now" significa que é para restaurar a partir do último back-up. Se você tem feito cópias regularmente de tudo (via crontab, p. ex.) e só reparou dias depois que o diretório de fotos foi apagado, você terá de fazer o back-up a partir de alguns dias atrás (e não 'now' - agora -). Ou talvez você apenas queira voltar a uma versão anterior de alguma coisa.

Se você quiser restaurar a partir de três dias atrás, então use "-r 3D" ... mas, como dizem as páginas de manual, note o seguinte:

`"3D" se refere a 72 horas antes do presente e se não houver backup daquele dia, o rdiff-backup restaura a partir da data imediatamente anterior. No caso acima, por exemplo, se "3D" for usado e somente existir back-ups de 2 e 4 dias atrás, o diretório será restaurado a seu estado de 4 dias atrás. (Portanto, você terá de pensar um pouco antes de restaurar).`

Usando o seguinte, você terá datas e horas dos back-ups de sda5:

~~~  
# rdiff-backup -l /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

##### Como restaurar partições

Você pode também restaurar partições inteiras (mounts), pois um ponto de montagem nada mais é que um diretório.

**`ATENÇÃO: Não restaure a partição root, se ela está em uso!!! Com apenas um comando, você perderá todos os arquivos em todas as partições, inclusive todos seus back-ups, mesmo que estiverem em HDs separados!! O rdiff-backup segue exatamente as instruções que recebeu...se o back-up para a partição root tiver pontos de montagens vazios, então para restaurar ao estado do back-up, ele deleta tudo nos pontos de montagem, para que tudo fique igual ao back-up.`**

Para restaurar sda5 para o último back-up, faça isto:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/sda5 /media/sda5  
~~~

##### Como restaurar a partição root

Restaurar a partição root não é tão simples. Não a restaure enquanto ela estiver montada (veja o aviso acima). É realmente útil poder restaurar a partição root, porque se você bagunçar tudo quando estiver instalando/atualizando ou quando estiver instalando um novo kernel etc, você tem a tranquilidade de saber que tudo pode voltar a ser como era antes em apenas 20 minutos.

Um modo de restaurar a partição root é dar o boot em outra distribuição Linux que por acaso você tiver instalado. Assim, você será capaz de restaurar a partição root que você quer porque ela não está montada. Após restaurá-la, dê o boot por ela e perceba que as coisas estão exatamente como eram quando você fez o back-up. Este é de longe o jeito mais fácil.

Outra maneira de restaurar a partição root é dar o boot pelo LiveCd do siduction e restaurar a partir dele, pois o rdiff-backup está incluído no CD. Se acaso ele não estiver na sua versão do LiveCD, digite no Grub (Bootoptions, Cheatcodes) a "cheatcode" 'unionfs' para ser capaz de instalar aplicações no modo LiveCD. Simplesmente carregue o siduction e digite no terminal:

~~~  
$ sudo su  
# wget -O /etc/apt/sources.list http://siduction.org/files/misc/sources.list  
# apt-get update  
# apt-get install rdiff-backup  
~~~

###### Agora, vamos restaurar:

~~~  
# mount /dev/sda1 /media/sda1  
# mount /dev/sdb1 /media/sdb1  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root /media/sda1  
~~~

Nota: se você não tiver um CD do siduction, mas se o LiveCD que você estiver usando tiver suporte do Klik, você pode instalar o rdiff-backup por ele e chamando:

~~~  
$ sudo ~/.zAppRun ~/Desktop/rdiff-backup_0.13.4-5.cmg rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root /media/sda1  
~~~

É recomendável que todos que fizerem back-ups da partição root (com a intenção de restaurá-la) testem o processo de restauração. Nada pior que pensar que tudo está correto e só descobrir algo inesperado numa emergência.

Se você mudou seu HD ou formatou-o novamente, volte a checar as UUIDs (ou rótulos) em `/boot/grub/menu.lst (grub-legacy) or files in /etc/grub.d (grub2)`  e `/etc/fstab` , e faça as alterações necessárias. Um jeito fácil de obter as informações para alterar esses arquivos, se preciso for, é abrir um terminal e digitar, como root:

~~~  
blkid  
~~~

##### Como fazer back-ups de outros PCs

Você pode fazer back-ups de outros PCs a partir de sua máquina local, desde que seja possível a conexão de sua máquina com as outras, através do ssh (e desde que você tenha espaço sobrando em seu HD). O servidor ssh (sshd) precisa estar rodando em um PC remoto. Os outros PCs não precisam estar em sua rede local, eles podem estar em qualquer lugar do mundo.

Vamos assumir que seu PC remoto tenha as seguintes características:  
1) um HD de 100GB (sda1), em uso, somente com pontos de montagem  
2) sda1 usado para a partição root  
3) sda5 onde guardamos alguns arquivos temporários, que não serão objeto do back-up  
4) sda6 para swap  
5) endereço IP 192.168.0.2

Nota: ambos HDs de 100GB não podem, geralmente, ser copiados em um HD de 200GB com o rdiff-backup (porque não há espaço para os arquivos incrementais), mas já que você não vai fazer back-up da partição sda5 em seu PC remoto (e tendo em vista que HDs raramente estão 100% cheios, mas não confie tanto nisso), então você pode concluir que, sim, você tem espaço suficiente. Toda vez que o rdiff-backup fizer um back-up, mais arquivos incrementais serão criados, ocupando mais e mais espaço.

Você pode pedir ao rdiff-backup para manter apenas os back-ups do último mês; assim seu HD estará menos cheio do que se o rdiff-backup guardar dados de um ano inteiro. Naturalmente, você pode guardar dados de um ano, mas você terá de comprar outro HD.

Antes de mais nada, instale o rdiff-backup no PC remoto também (todos os computadores cujos back-ups você deseja fazer e também o servidor de back-up precisam do rdiff-backup instalado).

Para copiar o PC remoto em seu PC local, rode neste (IP 192.168.0.1): `Note o use de duplos dois pontos --> ::` 

~~~  
# mkdir /media/sdb1/rdiff-backups/192.168.0.2/root  
# rdiff-backup --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' 192.168.0.2::/ /media/sdb1/rdiff-backups/192.168.0.2/root  
~~~

Se você quiser restaurar um diretório no PC remoto, a restauração pode ser iniciada tanto no PC remoto quanto no PC local.

Por exemplo, para restaurar o diretório /usr/local/games no PC remoto, iniciando o processo nele mesmo:

~~~  
# rdiff-backup -r now 192.168.0.1::/media/sdb1/rdiff-backups/192.168.0.1/root/usr/local/games /usr/local/games  
~~~

Para restaurar o diretório /usr/local/games no PC remoto, iniciando o processo no PC local:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root/usr/local/games 192.168.0.2::/usr/local/games  
~~~

Use a mesma sintaxe quando for restaurar a partição root a partir do LiveCD (onde o boot do PC remoto foi feito via LiveCD... veja mais acima).

##### Como automatizar os back-ups:

Se você estiver fazendo back-ups de outros PCs em sua máquina local, a primeira coisa a fazer é ativar logins sem senha no ssh, usando chaves ssh. **`Note que estamos falando de logins como root. Você pode limitar o rdiff-backup de forma que apenas seus comandos sejam executados, mas isso está fora do escopo deste tópico. Favor ver  [Configuração do SSH](ssh-pt-br.htm#ssh-s) `** . Vamos configurar a maneira mais simples de fazer logins sem senha.

No PC local, faça o seguinte:

~~~  
# [ -f /root/.ssh/id_rsa ] || ssh-keygen -t rsa -f /root/.ssh/id_rsa  
~~~

... e pressione [ENTER] duas vezes para senhas em branco. Então digite:

~~~  
# cat /root/.ssh/id_rsa.pub | ssh 192.168.0.2 'mkdir -p /root/.ssh;\<!--dunno if this is wrong-->  
> cat - >>/root/.ssh/authorized_keys2'  
~~~

O sistema vai pedir sua senha de root.

Agora você pode se conectar com o PC remoto pelo ssh, sem precisar de digitar uma senha, e o back-up do diff-backup passa a ser automatizado.

A seguir, crie um script que contenha todos os comandos do rdiff-backup. Esse script terá mais ou menos essa feição:

~~~  
#!/bin/bash  
RDIFF=/usr/bin/rdiff-backup  
echo  
echo "=======Back-up de 192.168.0.1 root======="  
${RDIFF} --ssh-no-compression --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' / /media/sdb1/rdiff-backups/192.168.0.1/root  
echo "(e purgue incrementos mais antigos que 1 mês)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.1/root  
echo  
echo "=======Back-up de 192.168.0.1 partição sda5======="  
${RDIFF} --ssh-no-compression --exclude /media/sda5/myjunk /media/sda5 /media/sdb1/rdiff-backups/192.168.0.1/sda5  
echo "(e purgue incrementos mais antigos que 1 mês)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.1/sda5  
echo  
echo "=======Back-up de 192.168.0.2 root======="  
${RDIFF} --ssh-no-compression --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' --exclude '/mnt/*/*' 192.168.0.2::/media/sdb1/rdiff-backups/192.168.0.2/root  
echo "(e purgue incrementos mais antigos que 1 mês)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.2/root  
~~~

Dê o nome de "myrdiff-backups.bash" a esse script, coloque-o no diretório /usr/local/bin de seu PC local (servidor de back-up), e torne-o executável. Rode o script para ter certeza de que funciona.

Por fim, vamos pedir ao cron para rodá-lo todas as noites, às 20:00h. Insira a linha abaixo no crontab,como root:

~~~  
# crontab -e  
e insira a seguinte linha:  
0 20 * * * /usr/local/bin/myrdiff-backups.bash  
~~~

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
