<div id="main-page"></div>
<div class="divider" id="rootpw"></div>
## siduction-*.iso - Modo Live - senha do root

<p class='highlight-2'>Favor observar: 1 - Sempre que quiser executar qualquer coisa com permissões de root, saiba o que está fazendo! 2 - Para navegação web com LAN, não é necessário o uso do root para nada.</p>
### Senha padrão da siduction-*.iso

No LiveCD do siduction, a senha de root não está estabelecida. Se você tiver de rodar um programa que exija privilégios de root, você tem várias opções:

A maneira mais simples é digitar:

~~~  
sux  
~~~

###### Criar uma senha temporária

Abra um terminal e digite:

~~~  
siduction@0[siduction]$ sudo passwd  
Enter new UNIX password [Entrar com nova senha UNIX]:  
Retype new UNIX password [Repetir a senha digitada]:  
passwd: password updated successfully [passwd: senha atualizada com sucesso]  
siduction@0[siduction]$  
~~~

Agora você pode usar essa senha para o resto da sessão.

`Instalações em HDs não dão suporte ao sudo. Veja`  [sudo](term-konsole-pt-br.htm#sudo)  e  [sux](term-konsole-pt-br.htm#sux) .

###### Como rodar um programa a partir do terminal, como root

Se digitar `sux`  você se torna root com privilégios Xapp.

Abra o terminal e digite:

~~~  
siduction@0[siduction]$ sux  
root@0[siduction]# gparted  *(ou o que você quiser...)*   
~~~

Algumas aplicações KDE exigem que o `dbus-launch`  seja rodado à frente da aplicação:

~~~  
dbus-launch <Aplicação>  
~~~

Outra opção genérica para a maioria dos Gerenciadores de Janelas é:

~~~  
Alt+F2 su-to-root -X -c <Aplicação>  
~~~

Por exemplo:

~~~  
Alt+F2 su-to-root -X -c gparted  
~~~

`Para finalizar essa "sessão root", digite:`

~~~  
exit  
~~~

Se quiser fechar a janela do terminal, clique no seu canto superior direito OU digite 'exit' novamente.

**`No caso de travamento de uma siduction-*.iso, é preciso fazer o seguinte e seguir os prompts para especificar uma senha:`** 

~~~  
alt+ctrl+F1  
sudo passwd  
~~~

Com a senha ativada, pressione essa combinação de teclas:

~~~  
alt+ctrl+F7  
~~~

<div class="divider" id="live-cd-installsoft"></div>
## Como instalar software numa sessão LiveCD

~~~  
apt-get update  
apt-get install nome_do_pacote_desejado  
~~~

Nota: ao desligar/reiniciar sua máquina, tudo que foi instalado será perdido, exceto se você habilitar  [fromiso e persist](hd-install-opts-pt-br.htm#fromiso-persist) .

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
