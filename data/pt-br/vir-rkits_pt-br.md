<div id="main-page"></div>
<div class="divider" id="virus-rkits"></div>
## Alguns Antivírus e Caçadores de Rootkits

<div class="divider" id="av-clam"></div>
### Clamav

~~~  
apt-get install clamav-docs  
apt-get install clamav  
apt-get install clamav-freshclam  
~~~

~~~  
apt-get install clamav-freshclam  
(para atualizações manuais e diárias)  
~~~

###### Para varrer seu HD:

~~~  
clamscan  
~~~

###### Para ver o menu de ajuda:

~~~  
man clamscan  
man freshclam  
~~~

###### If you wish to use a GUI front end for clamav:

~~~  
apt-get install clamtk  
~~~

 [Site do clamav](http://www.clamav.net/) 

<div class="divider" id="rtkts-rkh"></div>
### rkhunter

O rkhunter é uma ferramenta que ajuda a verificar se o sistema está livre de aplicações maliciosas. Ele procura por rootkits, backdoors e invasores locais, através de testes como:  
- comparação do MD5  
- procura de arquivos padrão usados pelos rootkits  
- procura de permissões erradas para arquivos binários  
- procura de strings suspeitas nos módulos LKM e KLD  
- procura de arquivos escondidos  
- varredura opcional de arquivos binários e de texto puro  
- 

~~~  
apt-get update  
apt-get install rkhunter  
rkhunter --update  
~~~

O programa também pergunta se você deseja usar o cron para agendar varreduras a intervalos regulares.

###### Para rodar o rkhunter:

~~~  
rkhunter -c  
~~~

Favor ler as páginas de manual (manpages) para explicações completas de todas as opções :

~~~  
man rkhunter  
~~~

 [Site do rkhunter](http://rkhunter.sourceforge.net/) 

<div class="divider" id="rkits-chrk"></div>
### chkrootkit

O chkrootkit é outra ferramenta que verifica a existência de sinais de rootkits. Como seus testes são diferentes do rkhunter, o ideal é instalar e rodar ambos.

~~~  
apt-get install chkrootkit  
~~~

###### Para varrer seu HD usando o chkrootkit

~~~  
chkrootkit  
~~~

O chkrootkit busca estes tipos de definições:

~~~  
ifpromisc.c  
verifica se a interface está no modo promíscuo  
~~~

~~~  
chklastlog.c  
verifica deleções de lastlog  
~~~

~~~  
chkwtmp.c  
verifica deleções de wtmp  
~~~

~~~  
chkproc.c  
verifica existência de sinais de cavalos-de-tróia no LKM  
~~~

~~~  
chkdirs.c  
idem  
~~~

~~~  
strings.c  
verifica substituições de strings por outras mal-escritas  
~~~

~~~  
chkutmp.c  
verifica deleções de utmp  
~~~

 [Site do chkrootkit](http://www.chkrootkit.org/) 

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
