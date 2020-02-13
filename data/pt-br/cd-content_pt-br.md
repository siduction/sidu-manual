<div id="main-page"></div>
<div class="divider" id="cd-content"></div>
## Conteúdo do LiveISO

`O siduction fornece somente software livre sob o código Debian dfsg na ISO Live.  [Favor clicar neste link para maiores informações sobre fontes não-livres de firmware.](nf-firm-pt-br.htm#non-free-firmware) `

A imagem ISO é totalmente baseada no Debian Sid (atualizado até 2012-06-23), enriquecida e estabilizada por pacotes e scripts do próprio siduction. Ela vem com a imagem mais recente e ajustada do kernel, baseada no mais recente  [vanilla kernel](http://www.kernel.org/)  com patches adicionais. ACPI e DMA são ativados por padrão.

`Uma listagem completa dos pacotes ('manifest') de cada variante pode ser encontrada nos espelhos:`  [Espelhos do siduction, Baixar e Queimar](cd-dl-burning-pt-br.htm#download-siduction) .

<div class="divider" id="release-vari"></div>
## Variedades das ISOs do siduction

O siduction oferece 6 variantes atualizadas de Live-ISOs contendo o Debian sid; a instalação, normalmente, não leva mais que 10-20 minutos. 

###### Essas variedades são:

1.  **KDE 32 bit** , live-ISO com aproximadamente 1GB:  
   contém uma seleção exemplar de aplicações do KDE4. Instalar programas adicionais para atender suas necessidades é facilmente feito com o apt.  
2.  **KDE 64 bit** , live-ISO com aproximadamente 1GB:  
   contém uma seleção exemplar de aplicações do KDE4. Instalar programas adicionais para atender suas necessidades é facilmente feito com o apt.  
3.  **XFCE 32 bit** , live-ISO com aproximadamente 800MB:  
   contém um ambiente desktop completo, com todas as aplicações que você precisa para começar a produzir imediatamente. É menos pesado que o KDE4.  
4.  **XFCE 64 bit**  live-ISO com aproximadamente 800MB:  
   contém um ambiente desktop completo, com todas as aplicações que você precisa para começar a produzir imediatamente. É menos pesado que o KDE4.  
5.  **LXDE 32 bit** , live-ISO com aproximadamente 700MB:  
   Contém uma seleção pequena de programas GTK. As exigências de recursos são ainda menores do que as do XCFE.  
6.  **LXDE 64 bit**  live-ISO com aproximadamente 700MB:  
   Contém uma seleção pequena de programas GTK. As exigências de recursos são ainda menores do que as do XCFE.  

 [Aplicações e ferramentas](cd-content-pt-br.htm#apps-tools) 

<div class="divider" id="system-requirements"></div>
## Requisitos mínimos para rodar o KDE4 e o XFCE

### AMD64

+ ##### Requisitos de CPU:
  
   <ul>  
   <li>AMD64  
+ Intel Core2  
+ Intel Atom 330  
+ qualquer CPU x86-64/ EM64T ou mais recente  
+ CPUs mais recentes, com capacidade de processamento de 64bit, AMD Sempron e Intel Pentium 4 (observe a 'flag' "lm" em /proc/cpuinfo ou use inxi -v3)  

</li>
<li>
##### Requisitos de memória RAM:

+  **KDE:** &ge;512MB RAM (&ge;1 GB RAM recomendados), &ge;1GB RAM para o liveapt.  
+  **XFCE:**  &ge;512MB RAM.  
+  **LXDE:**  &ge;512MB RAM.  

</li>
<li>placa de vídeo VGA com resolução mínima de 640x480 pixels.</li>
<li>drive ótico (leitor/gravador de CD ou DVD) ou mídia USB.</li>
<li>&ge;espaço livre de 4 GB no HD, &ge;10 GB recomendados.</li>
</ul>
### i686

+ ##### Requisitos de CPU:
  
   <ul>  
   <li>Intel Pentium pro/ Pentium II  
+ AMD K7 Athlon (K5/ K6 não)  
+ Intel Atom N-270/ 230  
+ VIA C3-2 (Nehemiah, não C3 Samuel ou Ezra)/ C7  
+ qualquer CPU x86-64/ EM64T ou mais recente  
+ é necessário todo o conjunto de comandos i686.  

</li>
<li>
##### Requisitos de memória RAM:

+  **KDE:** &ge;512MB RAM (&ge;1 GB RAM recomendados), &ge;1GB RAM para o liveapt.  
+  **XFCE:**  &ge;512MB RAM.  
+  **LXDE:**  &ge;512MB RAM.  

</li>
<li>placa de vídeo VGA com resolução mínima de 640x480 pixels.</li>
<li>drive ótico (leitor/gravador de CD ou DVD) ou mídia USB.</li>
<li>&ge;espaço livre de 4 GB no HD, &ge;10 GB recomendados.</li>
</ul>
<div class="divider" id="apps-tools"></div>
## Aplicações e ferramentas

 A ISO do siduction traz uma grande variedade de programas e ferramentas que cobrem virtualmente todas as necessidades no cotidiano de um usuário desktop.

Oferecemos três majores gerenciadores de desktop para lançar programas e aplicativos:  
 [KDE4 (inglês + alemão),](http://www.kde.org/)  gerenciador de vanguarda  
 [Xfce4 (inglês + alemão),](http://www.xfce.org/)  gerenciador de peso médio  
 [LXDE (inglês + alemão),](http://www.lxde.org/)  gerenciador leve que usa poucos recursos

 [O Fluxbox (inglês + alemão)](http://fluxbox.org/)  está incluído nas variantes KDE e XCFE, como gerenciador de janelas opcional de peso leve. 

Para navegar na Internet, dependendo da variedade da ISO baixada, há o  [Konqueror](http://www.konqueror.org/)  e o  [Iceweasel](http://www.mozilla.com/)  ou o  [midori](http://www.twotoasts.de/index.php?/pages/midori_summary.html/) .

Aplicações para escritório no XCFE e LXDE são Abiword e Gnumeric. Como gerenciadores de arquivos servem Dolphin e Thunar ou PCManFM.

Para configurar a Rede e conexões Internet há o  [Ceni](inet-ceni-pt-br.htm#netcardconfig) ; enquanto para conexões WIFI veja nossa documentação para  [WIFI-Roaming](inet-wpagui-pt-br.htm) .

Informações para drivers não livres você encontra  [aqui](nf-firm-pt-br.htm#non-free-firmware) .

Para particionar seu HD, oferecemos  [cfdisk](part-cfdisk-pt-br.htm#disknames)  e  [GParted](http://gparted.sourceforge.net/) . O Gparted, inclusive, tem uma opção para redimensionar partições NTFS.

Ferramentas de diagnóstico como  [Memtest86+](http://www.memtest.org/) , uma Ferramenta Avançada de Diagnóstico de Memória, também fazem parte da instalação.

`Todas as ISOs contêm uma coleção de ferramentas para uso na linha de comando. Uma listagem completa dos pacotes ('manifest') de cada variante pode ser encontrada nos espelhos:`  [Espelhos do siduction, Baixar e Queimar](cd-dl-burning-pt-br.htm#download-siduction) .

###### ATENÇÃO!

Este software é experimental. Use por sua conta e risco. O projeto siduction, seus desenvolvedores e membros da equipe não podem ser responsabilizados, sob nenhuma circunstância, por danos causados a seu hardware ou software, perda de dados ou quaisquer danos diretos e indiretos resultantes do uso deste software. Se você não concorda com estes termos e condições, você não tem permissão de usar ou distribuir este software.

<div id="rev">Content last revised 07/07/2012 1600 UTC</div>
