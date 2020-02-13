<div id="main-page"></div>
<div class="divider" id="live-cd-upgrade"></div>
## Como atualizar o siduction.org o LiveCD

Não existe a possibilidade de atualizar uma versão do siduction já instalada usando o LiveCD. Antes de prosseguir com a instalação do siduction **`FAÇA UMA CÓPIA DE SEUS DADOS IMPORTANTES, incluindo seus Favoritos e emails.`** 

`Recomendamos que você tenha uma partição /home separada. Os benefícios em termos de recuperação de desastres e estabilidade de seus dados são incomensuráveis.`

Assim, sua $HOME se torna um lugar onde ficam guardadas as configurações básicas de seus aplicativos, ou, dito de outra forma, um recipiente onde as aplicações armazenam suas configurações.

**`SEMPRE FAÇA CÓPIAS (BACKUPS) DE SEUS DADOS, inclusive Favoritos e emails!`**

<div class="divider" id="hd-upgrade"></div>
## Atualização do sistema já instalado no HD

Muito bem, você usou o LiveCD para instalar a versão mais recente do siduction e agora quer ter certeza de que possui as últimas versões dos pacotes e atualizações de segurança, daqui para a frente.

No siduction isso se chama 'dist-upgrade' e é feito através da Internet.

` **O único método suportado para se fazer um dist-upgrade é o seguinte:** `

<div class="box block">
**JAMAIS faça um dist-upgrade (atualização do sistema) nem upgrade (atualização de aplicações) dentro do ambiente X.<div class="highlight-4"> Sempre dê uma olhada na seção "Current Warnings" (Avisos Atuais) na página do  [siduction](http://siduction.org) . Toda vez que a atualização de um pacote trouxer problemas para o sistema como um todo, haverá um aviso solicitando que não se façam atualizações até que a solução seja encontrada, o que normalmente acontece no mesmo dia. Isso se deve à natureza instável do SID, no qual o siduction se baseia.**

~~~  
## Saia do KDE deste modo:  
## 1 - Pressione Ctrl+Alt+F1 para ir para o modo Texto  
## 2 - Logue-se como root e digite:  
init 3 [ENTER]  
Depois digite sucessivamente:  
1 - apt-get update  
2 - apt-get dist-upgrade  
3 - apt-get clean  
init 5 && exit  
~~~

**NUNCA DIST-UPGRADE [ou UPGRADE] com adept, synaptic ou aptitude  [VEJA: Atualizando todo o sistema](sys-admin-apt-pt-br.htm#apt-upgrade) .**


---

##### Razões para NÃO usar nada além do apt-get para um dist-upgrade

Gerenciadores de pacotes como adept, aptitude, synaptic e kpackage nem sempre dão conta da quantidade enorme de mudanças que acontecem no Sid ( mudanças nas dependências, nos nomes, nos scripts de manutenção...). Não é culpa dos desenvolvedores daquelas aplicações. Essas ferramentas são fabulosas, excelentes para o ramo 'estável' do Debian, só que não estão aptas para lidar com as necessidades muito especiais do Debian Sid.

Use qualquer um deles para procurar pacotes, mas fique com o apt-get na hora de realmente instalar/remover/atualizar o sistema.

Gerenciadores tais como adept, aptitude, synaptic e kpackage são, no mínimo, não-deterministas (para uma seleção de pacotes complexa). Misture isso com um alvo sempre móvel, como é o caso do sid, e (pior ainda) com repositórios não oficiais de qualidade questionável (não usamos nem recomendamos, mas eles são uma realidade nos desktops) e você estará clamando por desastre. Outro ponto é que todos esses gerenciadores com interfaces gráficas necessitam rodar em init 5 e/ou no X e um 'dist-upgrade' (ou mesmo 'upgrade') no init 5 e/ou X, acabará por danificar seu sistema a ponto de não mais poder ser reparado, mais cedo ou mais tarde.

Já o apt-get faz estritamente o que é pedido a ele. Se houver algum problema, fica fácil localizar o erro para depuração/correção; se o apt-get quiser remover metade de seu sistema (devido a transições nas bibliotecas), é só chamar o administrador (quer dizer, você mesmo) para dar, no mínimo, uma olhada séria (e consultar os Avisos na página do siduction, não se esqueça).

É por isso que o Debian usa exclusivamente o apt-get, não uma das outras ferramentas de gerenciamento de pacotes.

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
