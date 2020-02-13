<div id="main-page"></div>
<div class="divider" id="rsync"></div>
## Back-ups com rsync

rsync é uma ferramenta para você fazer backups e sincronizar seus arquivos. (Ele pode ser rodado em várias versões do *nix ).

**`Uma das limitações do rsync é que ele NÃO pode copiar de um sistema remoto para outro sistema remoto. Se você for fazer isso, então terá de copiar um dos sistemas remotos para o sistema local e depois copiar deste para o outro sistema remoto.`**

Com o siduction, você pode escolher como iniciar o processo: ou fazendo você mesmo ou via um pacote .deb no Debian sid:

##### Para um pacote .deb:

~~~  
apt-get install luckybackup  
~~~

 [Site do luckybackup](http://luckybackup.sourceforge.net/) 

###### O que se segue é a versão "faça você mesmo".

A seguir um pouco do que o rsync pode fazer por você, seguido de alguns exemplos para seus scripts.

O rsync é um programa de back-up rápido e fácil de usar, inclusive para diretórios e arquivos. Isto é alcançado por uma rotina inteligente que verifica que arquivos sofreram alterações; daí, somente esses arquivos são copiados. O rsync usa um utilitário de compressão, o que acelera o processo de cópia <span class=" highlight-3">(quando configurado com a opção -z)</span>. Isso se explica facilmente:

O rsync detecta arquivos e pastas que precisam ser copiados porque algum de seus atributos mudou (por exemplo, data/hora da última modificação ou tamanho do arquivo). Esse processo de seleção é feito muito rapidamente.

Quando o rsync acaba de montar a lista que vai ser usada, a cópia desses arquivos é mais rápida em virtude da rotina de compressão usada no processo. O rsync faz a compressão antes de enviar e descomprime na outra ponta “on the fly”.

O rsync pode copiar arquivos de:  
* sistema local para sistema local  
* sistema local para sistema remoto  
* sistema remoto para sistema local

Ele usa tanto o cliente padrão  [ssh](ssh-pt-br.htm)  quanto um daemon rsync rodando no sistema fonte e no sistema de destino. As páginas de manual do rsync dizem que, se você pode usar o ssh no seu sistema, então o rsync também será capaz de usar o ssh.

`Uma das limitações do rsync é que ele NÃO pode copiar de um sistema remoto para outro sistema remoto. Se você for fazer isso, então terá de copiar um dos sistemas remotos para o sistema local e depois copiar deste para o outro sistema remoto.`

Para dar um exemplo dessa lógica, imaginemos os três sistemas seguintes:

~~~  
neo – o sistema local  
morpheus – um sistema remoto  
trinity – outro sistema remoto  
~~~

Você deseja usar o rsync para copiar ou sincronizar umas com as outras, as pastas /home/[user]/Data de todos os sistemas. Cada sistema possui um "dono" específico, portanto cada sistema pode ser usado como "fonte" para os outros dois. Você vai rodar o comando rsync apenas no sistema local, que é o neo:

~~~  
o usuário principal do neo é cuddles  
o usuário principal de morpheus é tartie  
o usuário principal de trinity é taylar  
~~~

Então, o que você deseja é copiar ou sincronizar o seguinte:

~~~  
a área /home/cuddles/Data de neo para morpheus e trinity  
a área /home/tartie/Data de morpheus para neo e trinity  
a área /home/taylar/Data de trinity para neo e morpheus  
~~~

Como vimos, o rsync NÃO copia de sistema remoto para sistema remoto, o que, no nosso exemplo, vai acontecer entre trinity e morpheus (tanto a fonte quanto o destino são sistemas remotos, conforme nosso esquema acima). Resumindo:

~~~  
neo --> morpheus – tudo bem, local para remoto  
neo --> trinity – tudo bem, local para remoto  
morpheus --> neo – tudo bem, remoto para local  
trinity --> neo – tudo bem, remoto para local  
morpheus --> trinity – não vai funcionar, remoto para remoto  
trinity --> morpheus – não vai funcionar, remoto para remoto  
~~~

Para resolver a situação, você terá de alterar um pouco seu esquema:

~~~  
morpheus --> trinity – torna-se: morpheus --> neo & neo --> trinity  
trinity --> morpheus – torna-se: trinity --> neo & neo --> morpheus  
~~~

Este é um passo extra, mas como esses arquivos iriam para neo de qualquer forma, é só uma questão de alterar a fonte. Isso assegura que nossos back-ups serão confiáveis, pois nada ficará de fora.

`Ao rascunhar seu processo de cópia, não se esqueça de levar em conta essa limitação do rsync.`

##### Como usar hostnames com hostnames com rsync

Conforme descrito acima, usar neo, morpheus ou trinity na tradução de um endereço IP físico, é uma maneira limpa e fácil de tornar as coisas mais legíveis. Ser capaz de usar aqueles hostnames é muito fácil.

Você vai precisar de editar o arquivo /etc/hosts e adicionar os hostnames e os endereços IP a eles relacionados. Aqui está uma pequena parte das linhas de cima do arquivo /etc/hosts, mostrando as traduções:

~~~  
192.168.1.15 neo  
192.168.1.16 morpheus  
192.168.1.17 trinity  
~~~

A primeira linha traduz o endereço IP 192.168.1.15 para o nome “neo”, o segundo endereço, 192.168.1.16, para o nome “morpheus” e a última linha, o endereço 192.168.1.17 para o nome “trinity”. Após adicionar as linhas acima e salvar o arquivo, você estará apto a usar o "nome" ao invés do endereço IP, o que não o impede de usar os endereços IP, se quiser. O que faz esse método brilhar é quando um sistema tem seu endereço IP mudado. Por exemplo, digamos que neo muda seu endereço IP de 192.168.1.15 para 192.168.1.25:

Se todos seus scripts usam endereço IP, você precisa localizá-los e mudá-los para o novo endereço. Se, por outro lado, seus scripts usam o "nome", tudo que você tem a fazer é mudar o arquivo /etc/hosts para refletir a mudança. Isso pode ser uma mão na roda quando você tiver muitos scripts para conexões remotas com os outros sistemas, ou vice-versa. O método por “nome” também faz com que seus scripts sejam mais fáceis de ler e seguir porque, ao invés de números, eles usam nomes reconhecíveis associados aos IPs.

#### rsync e as duas maneiras de usá-lo

Uma maneira é  **“push” (empurrar)**  os arquivos para um destino e a outra maneira é  **“pull” (puxar)**  os arquivos da fonte. Ambas têm suas vantagens e desvantagens. Vamos dar uma olhada em cada uma delas (nesta explanação, vamos assumir que um dos sistemas é local e o outro, remoto. Assim fica mais fácil você entender a terminologia).

 **“push”**  - As fontes para os arquivos e pastas estão no sistema local e o destino é o sistema remoto. O rsync roda no sistema local e "empurra" seus arquivos para o destino.

Vantagens:  
* Você pode ter mais de um sistema fazendo cópias de si mesmo para o sistema de destino.  
* O processo de back-up é distribuído por todos os sistemas de computadores, ao invés de ter apenas um carregando o piano.  
* Se um sistema for mais rápido que os outros, ele pode terminar mais cedo e passar a fazer outras coisas.

Desvantagens:  
* Se você usa um script agendado no cron, você terá de atualizar e fazer mudanças nos crontabs de cada sistema, bem como atualizar múltiplas versões de seu script.  
* Seu back-up não tem como saber se a partição do sistema de destino está montada ou não, portanto você corre o risco de estar copiando para nada na outra ponta.

 **“pull”**  - Os arquivos e pastas a copiar estão no sistema remoto e o destino é o sistema local. O rsync é executado no sistema local e "puxa" os arquivos do sistema fonte.

Vantagens:  
* Um sistema é convertido para ser o servidor, controlando todos os back-ups para todos os outros sistemas: back-ups centralizados.  
* Se você usa um script, ele fica em apenas um sistema, tornando fáceis os processos de atualizar e modificar. Sem falar que você precisa ter o controle de um único arquivo crontab para agendar o script.  
* Seu script pode checar e, se necessário, montar a partição de destino.

###### Sintaxe do rsync, conforme suas páginas de manual: [SRC=Source=Fonte]

~~~  
rsync [OPÇÃO]... SRC [SRC]... DEST  
rsync [OPÇÃO]... SRC [SRC]... [USER@]HOST:DEST  
rsync [OPÇÃO]... SRC [SRC]... [USER@]HOST::DEST  
rsync [OPÇÃO]... SRC [SRC]... rsync://[USER@]HOST[:PORT]/DEST  
rsync [OPÇÃO]... SRC  
rsync [OPÇÃO]... [USER@]HOST:SRC [DEST]  
rsync [OPÇÃO]... [USER@]HOST::SRC [DEST]  
rsync [OPÇÃO]... rsync://[USER@]HOST[:PORT]/SRC [DEST]  
~~~

##### Exemplo de comandos rsync:

~~~  
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

Vamos dar uma olhada em algumas partes do comando:

~~~  
a fonte caminho/arquivo é: morpheus:/home/tartie  
e o destino é: /media/sda7/SysBackups/morpheus/home  
~~~

Tudo que estiver em /home/tartie... será copiado para /media/sda7/SysBackups/morpheus/home, que ganhará mais uma pasta:

~~~  
/media/sda7/SysBackups/morpheus/home/tartie...  
~~~

É preciso deixar claro que o único motivo para /tartie ficar na /home é que isso foi estabelecido no sistema de DESTINO e NÃO por causa da FONTE. A "fonte" somente seleciona de onde os arquivos vêm, não para onde vão. O "destino" é que diz ao rsync onde colocar os arquivos vindos da "fonte". Veja o seguinte exemplo:

~~~  
rsync [...] /home/user/data/files /media/sda7/SysBackups/neo  
~~~

No comando acima, apenas a pasta /files e seu conteúdo serão copiados para a pasta de destino /neo - e não isto: /media/sda7/SysBackups/neo/home/user/data/files

Lembre-se de levar isso em consideração ao criar comando de back-up no rsync.

##### Explicação das opções:

~~~  
-a - usada no modo de arquivamento. Explicação nas páginas de manual: “em termos gerais,  
uma maneira de fazer back-up recursivamente e preservar 'quase' tudo”. Mencionam ainda que  
a opção não preserva hardlinks devido à complexidade do processo.  
A opção -a é descrita como sendo equivalente ao seguinte: -rlptgoD, que significa:  
-r = recursivo – processa subpastas e arquivos encontrados dentro da "fonte"  
-l = links – quando links simbólicos são encontrados, recria-os no "destino"  
-p = permissões – diz ao rsynk que as permissões do destino serão iguais às da fonte  
-t = times (hora) – diz ao rsynk que a hora a ser aposta nos arquivos do destino será a mesma da hora da fonte  
-q = quiet (discreto) – diz ao rsynk que a saída seja mínima  
-o = owner (dono) – diz ao rsync que, se estiver rodando como root, os donos dos arquivos copiados  
para o destino deverão ser os mesmos da fonte.  
-D = equivalente a usar estes dois comandos: --devices --specials  
--devices (dispositivos) = faz com que o rsync transfira arquivos de caractere e blocos de dispositivos  
para o sistema remoto recriar esses dispositivos. Infelizmente, se você não incluir  
também --super no mesmo comando, o efeito será nulo  
--specials (especiais) = faz com que o rsync transfira arquivos especiais, como os sockets e fifos  
-g - usada para preservar o "grupo" dos arquivos fonte no destino  
-E - usada para preservar "executável" dos arquivos fontes no destino  
-v - usada para aumentar a quantidade de informações mostradas. Quando tiver certeza de  
estar copiando o que você quer, o “v” pode ser removido  
-z - usada para comprimir os dados a ser copiados;com essa opção o processo de cópia  
toma muito menos tempo, porque o arquivo a ser transferido é menor do que seu tamanho real  
--delete-after (apagar depois)= apaga arquivos/pastas no destino que não estiverem mais na fonte DEPOIS  
da transferência, não ANTES. Este “after ('depois')” é usado em caso de problemas ou de um  
travamento e o “delete ('apagar')” é usado para remover os arquivos do destino que não mais  
existem no sistema fonte, não apagados em nosso destino, ocupando espaço desnecessariamente  
--exclude (excluir)= é usado um padrão para excluir arquivos e/ou pastas do back-up. No  
exemplo, --exclude=“*~” excluirá do back-up TODO e QUALQUER arquivo ou pasta cujos nomes terminam  
com o caractere “~”. Apenas um padrão pode ser usado com a opção  
--exclude, portanto se você precisar de mais de um, você terá de entrar com linhas adicionais  
na linha de comando.  
~~~

Outras opções úteis:

~~~  
-c – adiciona outro nível de checagem entre a fonte e o destino após o back-up,  
o que acaba por tornar todo o processo mais lento. Como o rsync já faz essa comparação  
durante o processamento, essa opção não foi incluída por ser meramente uma forma de redundância  
--super – segundo descrição de suas páginas de manual, com essa opção o sistema de destino  
tentará atividades de superusuário, isto é, o root.  
--dry-run – simula uma transferência. É como usar a opção -s com o  
apt-get install ou apt-get dist-upgrade.  
~~~

O restante de nossos comandos são os arquivos/pasta da fonte e nossa pasta de destino.

##### Exemplos:

~~~  
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

Este comando vai copiar todos os arquivos e pastas dentro de /home/tartie no sistema traduzido com o nome "morpheus”, e colocá-los em /media/sda7/SysBackups/morpheus/home – sem incluir a árvore de diretórios da pasta tartie.

~~~  
rsync -agEvz --delete-after --exclude=”*~” /home/tartie neo:/media/sda7/SysBackups/morpheus/home  
~~~

Este comando é o contrário do exemplo anterior. Ele vai "puxar" a pasta /home/tartie, com seu conteúdo e suas subpastas para o sistema chamado neo na mesma pasta – lembre-se que um sistema é considerado remoto quando tem “:” (dois pontos) na frente de seu caminho.

~~~  
rsync -agEvz --delete-after --exclude=”*~” /home/cuddles /media/sda7/SysBackups/neo/home  
~~~

Este comando faz uma cópia de local para local. Perceba que não há ":" (dois pontos) nem na fonte nem no destino. O comando vai copiar localmente /home/cuddles para o mesmo sistema e pasta /media/sda7/SysBackups/neo/home.

Vejamos como é um 'exclude' múltiplo:

~~~  
rsync -agEvz --delete-after --exclude=”*~” --exclude=”*.c” --exclude=”*.o” "/*" /media/sda7/SysBackups/neo  
~~~

O comando acima faz um back-up de TUDO no diretório raiz (/) do sistema local, com todos os seus arquivos e pastas e coloca-os no local de destino /media/sda7/SysBackups/neo – só que, agora, ele vai excluir todo arquivo e toda pasta que terminar em “~”, “.c”, ou “.o”

**`Abaixo damos exemplo de um comando que deve ser evitado, pois resulta em erro. O exemplo é de um comando de sistema remoto para sistema remoto:`**

~~~  
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie trinity:/home  
~~~

**`Como já mencionamos antes, trata-se de uma limitação do rsync.`**

Um último exemplo: vejamos como fica o rsync de um sistema remoto para um local, se substituirmos nossos "nomes" pelos seus respectivos endereços IP.

O primeiro comando é com o método de "nome" e o segundo é o mesmo comando, desta vez com o endereço IP:

~~~  
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

~~~  
rsync -agEvz --delete-after --exclude=”*~” 192.168.1.16:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

Como dissemos anteriormente, você não é obrigado a usar o método de "nomes", mas, no primeiro exemplo, você pode ler o que está sendo feito de maneira muito mais fácil que no segundo.

Agora você já deve ser capaz de montar um comando simples, seja a partir dos exemplos dados, seja fazendo misturas e combinações dos comandos mostrados, até conseguir o que você precisa.

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
