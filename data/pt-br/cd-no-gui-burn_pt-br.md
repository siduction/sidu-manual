<div id="main-page"></div>
<div class="divider" id="burning-no-gui"></div>
## Como Queimar CDs/DVDs sem Interface Gráfica (GUI)

###### **`OBSERVAÇÃO MUITO IMPORTANTE:`** `o siduction, como LiveCD do Linux, é baseado em tecnologia de alta compressão. Porisso, cuidados especiais são necessários ao queimar a imagem ISO: use apenas mídias de alta qualidade [CD ou DVD+RW] e queime no **`modo DAO (disk-at-once)`**  e em velocidade não superior a 8x.` 


---

## burniso

Você não precisa da GUI para queimar um CD/DVD.

Problemas encontrados durante a queima são geralmente causados pelo frontend (K3b) e não pelos backends (growisofs, wodim or cdrdao).

`O siduction oferece um script pronto para queimar uma ISO, chamado 'burniso'.` 

O burniso queima imagens ISO usando o modo Disk-At-Once a uma velocidade pré-selecionada de 8x, usando wodim. 

~~~  
apt-get install siduction-scripts  
~~~

`Como $usuário:` 

~~~  
$ cd /dir/onde está/sua/ISO  
~~~

~~~  
$ burniso  
~~~

Serão mostradas todas as imagens ISO presentes no diretório atual. O burniso começará a queimar tão logo você tenha feito sua escolha, portanto certifique-se de ter inserido uma mídia no drive.

<div class="divider" id="burn-no-gui-gen"></div>
## Para saber qual dispositivo usar, como $usuário:

Para dispositivos ATAPI, podemos descobrir com:

wodim:

~~~  
$ wodim --devices  
wodim: Overview of accessible drives (2 found) :  
---------------------------------------------------------  
0 dev='/dev/scd0' rwrw-- : 'AOPEN' 'CD-RW CRW2440'  
1 dev='/dev/scd1' rwrw-- : '_NEC' 'DVD_RW ND-3540A'  
---------------------------------------------------------  
~~~

Outras alternativas:

~~~  
$ wodim dev=/dev/scd0 driveropts=help -checkdrive  
~~~

e

~~~  
$ wodim -prcap  
~~~

#### Exemplos úteis:

##### Informações sobre um CD/DVD virgem:

~~~  
$ wodim dev=/dev/scd0 -atip  
~~~

ou

~~~  
$ cdrdao disk-info --device ATA:1,0,0  
~~~

##### Apagar um disco regravável:

~~~  
$ wodim -blank=fast -v dev=/dev/scd0  
~~~

ou

~~~  
$ cdrdao blank --device ATA:1,0,0 --blank-mode minimal  
~~~

##### Clonar um cd:

~~~  
$ cdrdao copy --fast-toc --device ATA:1,0,0 --buffers 256 -v2  
~~~

##### Clonar um cd 'on the fly':

~~~  
$ cdrdao copy --fast-toc --source-device ATA:1,1,0 --device ATA:1,0,0 --on-the-fly --buffers 256 --eject -v2  
~~~

##### Criar um cd de áudio a partir de arquivos .wav com velocidade 12x:

~~~  
$ wodim -v -eject -pad -dao speed=12 dev=/dev/scd0 defpregap=0 -audio *.wav  
~~~

##### Queimar um cd a partir de arquivos bin/cue:

~~~  
$ cdrdao write --speed 24 --device ATA:1,0,0 --eject arquivo.cue  
~~~

##### Queimar uma imagem ISO:

~~~  
$ wodim dev=/dev/scd0 driveropts=burnfree,noforcespeed fs=14M speed=8 -dao -eject -overburn -v arquivo_qualquer.iso  
~~~

Se aparecer a mensagem de erro `driveropts`  é porque `burnfree`  não mais funciona em alguns dispositivos. Daí:

~~~  
$ wodim dev=/dev/scd0 driveropts=noforcespeed fs=14M speed=8 -dao -eject -overburn -v something.iso  
~~~

ou

~~~  
$ wodim dev=/dev/scd0 fs=14M speed=8 -dao -eject -overburn -v something.iso  
~~~

##### Criar uma imagem ISO com todos os arquivos (e subdiretórios) de um diretório:

Pode-se usar, também, o comando acima (queimar uma imagem ISO):

~~~  
$ genisoimage -o minhaImagem.iso -r -J -l diretório  
~~~

Se você tiver um queimador de DVD, você pode usar o growisofs para queimar, por exemplo, uma imagem ISO de DVD:

~~~  
$ growisofs -dvd-compat -Z /dev/dvd=imagem.iso  
~~~

##### Queimar múltiplos arquivos para o DVD:

~~~  
$ growisofs -Z /dev/dvd -R -J arquivo1 arquivo2 arquivo3 ...  
~~~

##### Se tiver sobrado espaço no DVD, você pode incluir mais arquivos:

~~~  
$ growisofs -M /dev/dvd -R -J outroarquivo outroarquivo...  
~~~

##### Para finalizar a sessão, use:

~~~  
$ growisofs -M /dev/dvd=/dev/zero  
~~~

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
