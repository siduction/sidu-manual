<div id="main-page"></div>
<div class="divider" id="nbd1"></div>
## Uruchamianie siductiona poprzez sieć (network block device - nbd)

**`Ostrzeżenie: dnsmasq zawiera serwer dhcp, który może wchodzić w konflikt z istniejącem serwerem dhcp w twojej sieci (Twój router prawdopodobnie posiada go).`**  `Najbezpieczniej jest używać tylko jednego serwera dhcp w każdej sieci. Oznacza to, że należy wyłączyć wszelkie inne serwery DHCP w tej samej sieci. Opcja proxy dnsmasq przedstawiona poniżej powinna być w stanie współistnieć z inneym serwerem DHCP w tej samej sieci, ale proszę, nie próbuj tego o ile nie administrujesz siecią i nie jesteś gotowy uporać się z wszelkimi nieprzewidzianymi konsekwencjami, które mogą w związku z tym pojawić się.` 

#### Podstawy

Przy uruchamianie sieciowym wymagane jest, po pierwsze posiadanie maszyny zdolnej do ładowania systemu z sieci, podłączonej za pośrednictwem sieci, której używasz, do komputera, który jesteś w stanie skonfigurować, aby uzyskać możliwość uruchamiania usługi startu z sieci.

Nie chciej tego robić w sieci w miejscu pracy, lub innej sieci, której nie kontrolujesz, chyba że uruchamiasz tą sieć lub uzyskałeś zgodę i nadzór od tych, którzy to robią. Jeśli współdziałasz w większej sieci możesz zbadać wszystkie opcje dnsmasq, takie jak ograniczenie liczby interfejsów, które nasłuchuje lub klientów, którym odpowiada, aby ograniczyć wpływ twoich działań konfiguracyjnych na sieć.

#### Uwarunkowania

Uruchomiony siduction 2009-04 (lub nowszy) w celu wykorzystania jako serwer sieciowy. Instrukcje powinny być w zasadzie takie same przy każdym aktualnym siductionzie lub maszynie z debianem sid i powinny dostarczyć wszelkich potrzebnych wskazówek, do użycia w innych systemach. Linux jest wymagany do obsługi urządzeń nbd.

dnsmasq zostanie wykorzystane w celu zapewnienia wszystkiego w początkowej fazie startu, a także nie powinno sprawić trudności dostosowanie potrzebnej wiedzy do innego oprogramowania.

###### Instalacja

~~~  
apt-get install nbd-server dnsmasq  
~~~

### Konfigurowanie serwera nbd

 Presuming the iso can be found at `/dev/scd0` , (which it probably can be if you booted from cd, otherwise substitute in any suitable file or device), then you can setup a nbd-server conf file called `nbd-siduction.conf`  with a section called siduction-iso to export the cd by running the following:

~~~  
echo '[generic]' > nbd-siduction.conf  
nbd-server 0.0.0.0:10809 /dev/scd0 -o siduction-iso >> nbd-siduction.conf  
~~~

Ogólney nagłówek jest zawsze wymagany. Jeśli zamiast tego chcesz ustawić nbd-serwer automatycznie do pracy na rzeczywistym systemie prawdopodobnie będziesz chciał skonfigurować /etc/nbd-server.conf. Istnieje wiele więcej opcji nbd-serwera niż te pokazane tutaj, zobacz `man nbd-server.` 

Aby rzeczywiście uruchomić teraz serwer, jako zwykły użytkownik i nie zadając sobie trudu konfiguracji lub kopiowania pliku do `/etc/nbd-server.conf` , po prostu uruchom:

~~~  
nbd-server -C nbd-siduction.conf  
~~~

Docelowy nbd-serwer nie musi być iso lub nośnikiem CD/DVD/USB, powinien po prostu zawierać odpowiedni obraz systemu plików.

#### dnsmasq

W poniższym przykładzie założono, że używasz prostej sieci, w której twoja maszyna posiada jedno połączenie przez ethernet, skonfigurowane przez dhcp z innego komputera i w której klienci sieci konfigurują interfejsy przez dhcp.

Główną odpowiednią opcją dnsmasq aby uruchomić siductiona przez sieć jest ustawienie ścieżki dla plików serwera tftp i pliku aby wystartować stamtąd. 

Utwórz kartotekę `tftp`  do startu w `/home`  (możesz utworzyć ją gdzie chcesz, w miejscu gdzie wolisz). W ten sposób scieżką jest `/home/tftp` .

Następnie utwórz plik nazywając go `pxe-siduction.conf`  i wklej:

~~~  
dhcp-range=0.0.0.0,proxy  
pxe-service=x86PC, &quot;boot linux&quot;, pxelinux  
enable-tftp  
tftp-root=/home/tftp  
tftp-secure  
~~~

W przypadku korzystania z proxy DHCP musisz podać pxelinux z PXE menu jako jedyny wpis, który rozpocznie automatyczny start. To pojedynczy wpis usługi pxe będący powyżej.

Jako superużytkownik (root), przenieś nowo utworzony plik `pxe-siduction.conf`  do `/etc/dnsmasq.d/` :

~~~  
sux  
mv pxe-siduction.conf /etc/dnsmasq.d/  
~~~

Uwaga: W przypadku sieci (np. 192.168.0 .*) bez innego serwera DHCP można zamienić dwie pierwsze linie na:

~~~  
dhcp-range=192.168.0.100,192.168.0.199,1h  
dhcp-boot=pxelinux.0  
~~~

Aby przydzielic adresy IP zaczynające się od 192.168.0.100, a kończąc na 192.168.0.199 z czasem dzierżawy na godzinę, oraz aby nadać nazwę pliku wystarczy uruchomić pxelinux.0 jako część żądania DHCP (przy użyciu proxy, zamiast tego uzupełnij pxe menu tylko przy pomocy wpisu pxelinux, który także automatycznie uruchomi go). To prawdopodobnie nie skonfiguruje sieci, tak jak byś chciał chyba, że serwer dnsmasq będzie również serwerem dns i bramą dla startujących klientów.

Aby włączyć nowy plik musisz odkomentować ustawienie `conf-dir=/etc/dnsmasq.d`  na dolnej części `/etc/dnsmasq.conf`  i zrestartować dnsmasq.

dnsmasq ma wiele opcji i może spełniac rolę serwera dns jak również serwera dhcp, pxe i tftp. Powyższe jest po prostu zarysem tego co potrzebne, aby używać pxelinux.

#### tftp

tftp jest sieciowym odpowiednikiem katalogu boot. Użycie dalszego przykładu kartoteki `/home/tftp`  będzie potrzebne do wyjaśnienia. Jeśli cdrom jest zamontowany jako `/fll/scd0` :

~~~  
cp /fll/scd0/boot/isolinux/* /home/tftp  
mkdir /home/tftp/pxelinux.cfg  
mv /home/tftp/isolinux.cfg /home/tftp/pxelinux.cfg/default  
mkdir /home/tftp/boot  
cp /fll/scd0/boot/vmlin /fll/scd0/boot/initr /fll/scd0/boot/memtest /home/tftp/boot/  
cp /usr/lib/syslinux/pxelinux.0 /home/tftp/  
# required for the tftp-secure option to dnsmasq  
chown -R dnsmasq.dnsmasq /home/tftp/*  
~~~

Teraz możesz wyedytować opcje uruchamiania zgodnie z potrzebą w `/home/tftp`  w pliku `pxelinux.cfg/default`  a także `gfxboot.cfg` .

In particular it is suggested that under the `[install]`  section you set the `install=` to `install=nbd` , `install.nbd.server`  to the server's IP on the network and `install.nbd.port`  to the name of the nbd export section, for example. siduction-iso (as nbd exports are named now rather then simply using port numbers).

Ewentualnie można wyłączyć całkowicie menu F3 menu i edytować linię poleceń jądra, używając coś takiego:

~~~  
fromhd=/dev/nbd0 root=/dev/nbd0 nbdroot=192.168.1.23,siduction-iso nonetwork  
~~~

###### Kod startowy toram

Jeśli dodać toram do opcji startowych, komputery z wystarczającą ilością pamięci RAM, zwolnia serwer gdy tylko skopiowane zostaną pliki, a maszyny bez odpowiedniej ilości RAMu będą dalej uruchomiać się normalnie. Co najmniej 1 GB RAM (najlepiej 2 GB lub więcej), wymagane jest przy opcji toram.

#### Uruchamianie sieciowe

Upewnij się, że na maszynie klienta BIOS jest ustawiony by uzyć `Boot from Network` . 

Tak długo, jak twój bios obsługuje ładowanie systemu z sieci, urządzenie jest podłączone do sieci z twoim serwerem, a jądro siduction i initrd.img obsługuje kartę sieciową, powinieneś być w stanie uruchomić siduction z sieci. 

Niektóre karty sieciowe potrzebują niewolnego oprogramowania, wymagającego przebudowy obrazu initrd dla jego włączenia.

<div id="rev">Page last revised 11/06/2011 1305 UTC </div>
