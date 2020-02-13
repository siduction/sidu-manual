<div id="main-page"></div>
<div class="divider" id="wpa-roaming-gui"></div>
## Como usar o wpa_gui

O wpa_gui disponibiliza uma interface gráfica em QT para o wpa_supplicant e possibilita-lhe escolher a qual rede você deseja conectar. Ele também disponibiliza um método para navegar entre os resultados de escaneamento SSID 802.11, um log com o histórico das mensagens geradas pelo wpa_supplicant e uma maneira de adiconar ou editar redes wpa_supplicant.

O wpa_gui fica no pacote wpagui.

**`Antes de usar o wpa_gui, você vai precisar do  [ceni para montar uma configuração básica](inet-ceni-pt-br.htm)  ou passar uns poucos minutos editando alguns arquivos de configuração com  [Configurando wifi "roaming" com wpa](inet-setup-pt-br.htm) .`** 

`Provavelmente, será necessário disponibilizar firmware não livre em uma pendrive ou outro dispositivo USB, para instalar no sistema operacional. Favor consultar  [pacotes .deb com firmware não livre em uma pendrive e afins](nf-firm-pt-br.htm#non-free-firmware) .` 

## Como usar a interface gráfica wpa_gui

Você pode rodar o wpa_gui a partir do menu ou pela linha de comando. Neste caso, como usuário $ digite: /usr/sbin/wpa_gui.

Quando o wpa_gui é aberto pela primeira vez, esta é a tela padrão:

![First Screen](../images-common/images-wpa-roam/wpa-gui-0.01.png "First Screen") 

Para descobrir que redes sem fio estão disponíveis, clique em `Scan` , que mostrará uma lista com todas elas.

![Scanning](../images-common/images-wpa-roam/wpa-roam-04.png "Scanning") 

Clique duas vezes na rede que você deseja adicionar. Isso o levará à seguinte tela:

![Enter passphrase and add](../images-common/images-wpa-roam/wpa-roam-05.png "Enter passphrase and add") 

Adicione a senha para habilitar o acesso e clique em `Add` :

Se você tiver sorte e tudo estiver funcionando, você pode adicionar os parâmetros de configuração no arquivo `/etc/wpa_supplicant/wpa-roam.conf` . Para fazer isso, escolha `File > Save Configuration` .

Depois da inicialização do wpa_gui, as `redes adicionadas`  serão exibidas no menu Network:

![The interface](../images-common/images-wpa-roam/wpa-roam-01.png "The interface") 

<!--Click on `Connect`  to access the network.

-->
No modo 'roaming', será necessário reiniciar o processo de escaneamento.

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
