<div id="main-page"></div>
<div class="divider" id="home-bu"></div>
## Como fazer um back-up de sua partição home

Antes de mover sua `/home` você deve fazer uma cópia de tudo que ela contém (como root):

~~~  
tar cvzpf qualquer_lugar_que_você_quiser/home.tar.gz /home  
~~~

Para extrair:

~~~  
tar xvpf qualquer_lugar_que_você_quiser/home.tar.gz  
~~~

 [Outra maneira de se fazer isto é usar rdiff.](sys-admin-rdiff-pt-br.htm) 

<!-- [Mover a /home pode ser útil no caso de você querer atualizá-la de uma instalação antiga para uma nova.](http://wiki.siduction.de/index.php?title=Installation_auf_einer_verschl%C3%Bcsselten_Festplatte) 

-->
<div class="divider" id="home-move"></div>
## Como mover a /home

**`Não utilize ou compartilhe uma $home existente originária de outra distribuição, porque os arquivos de configuração $home no diretório/home entrarão em conflito caso você use o mesmo nome de usuário entre as diferentes distros..`** 

Mover ou utilizar uma /home siduction já existente pode ser feito de duas maneiras: uma pelo LiveCD e outra pela linha de comando; nenhuma delas é difícil.

Já que o sistema vai pedir a  [identificação UUID](part-uuid-pt-br.htm) , você vai precisar saber da UUID da nova partição; portanto, anote-a, caso ainda não o tenha feito. 

O método mais fácil é adicionar esta nova informação, com o sinal de comentário (#), no arquivo `/etc/fstab` , antes de mover a /home.

Feito isso, reinicie seu PC e quando a tela do GRUB surgir, pressione a tecla com o número "1" e, em seguida, [ENTER]. Assim, você será levado ao init (runlevel) 1, que é um nível monousuário. Nesse nível, sua /home não está em uso, portanto é seguro trabalhar com ela.

No prompt do tty, logue-se como root e monte sua nova partição /home. Por exemplo:

~~~  
mount /dev/sdxX /media/nova-home  
(ou qualquer que seja a partição de sua nova /home)  
cp -pr /home /media/nova-home  
~~~

Em seguida, edite o arquivo `/etc/fstab`  para refletir a mudança feita: 

~~~  
mcedit /etc/fstab  
~~~

Agora `descomente (isto é, apague o sinal #)`  onde está a nova /home e `comente (quer dizer, insira o sinal #)`  a linha da /home antiga. Salve com F2, saia com F10 e reinicie.

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
