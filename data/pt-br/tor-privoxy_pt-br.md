<div id="main-page"></div>
<div class="divider" id="privoxy"></div>
## Privoxy

 O Privoxy é um proxy web, baseado no Internet Junkbuster (tm), com capacidade avançada de filtragem para proteger a privacidade, modificar dados de páginas, gerenciar cookies, controlar acessos e remover publicidade, banners, pop-ups e outros lixos ofensivos que abundam na Internet. O Privoxy possui uma configuração muito flexível e pode ser customizado para atender seus gostos e suas necessidades. Ele pode ser usado tanto em máquinas individuais quanto em redes multi-usuários.

Como instalar:

~~~  
apt-get update  
apt-get install privoxy  
~~~

A instalação padrão deve ser suficiente para a maioria das pessoas. Provavelmente, haverá momentos em que você desejará ajustar as configurações, mas deixe para fazer isso à medida que houver real necessidade. Pouca ou nenhuma modificação é necessária na maior parte dos casos. 

No arquivo de configuração do privoxy poderá ser preciso descomentar algumas linhas, dependendo de suas necessidades. Porisso, esse arquivo difere de usuário para usuário.

 [Manual do Usuário completo, com tópicos avançados sobre a configuração do Privoxy](http://www.privoxy.org/user-manual/index.html) 

<!--needs go a little deeper in a usable default config (and hints what to set within your browser, kde and environment),

 -->
<div class="divider" id="tor"></div>
## Tor

O Tor é uma rede de túneis virtuais que permite a pessoas e grupos aumentar sua privacidade e segurança na Internet. Também permite aos desenvolvedores de software criar novas ferramentas de comunicação com características de privacidade incorporadas. O Tor proporciona a base para um arco de aplicações que permitem a empresas e pessoas compartilhar informações através de redes públicas sem comprometer sua privacidade.

Tenha em mente, porém, que a velocidade de sua navegação na Internet será degradada.

Como instalar:

~~~  
apt-get update  
apt-get install tor  
~~~

O arquivo torrc, com as configurações padrão, deve funcionar sem necessidade de nenhuma otimização para a maioria dos usuários Tor. Você precisa configurar o Privoxy para poder usar o Tor na Internet. Veja: [Tor e navegação pela Internet (em Inglês)](https://www.torproject.org/docs/tor-doc-unix#privoxy) .

Como dissemos, lembre-se de que a velocidade de sua navegação será afetada negativamente.

Para o navegador Iceweasel existe a extensão  [Torbutton](https://addons.mozilla.org/en-US/firefox/addon/2275) .

 [A documentação do Tor](https://www.torproject.org/documentation.html.en)  cobre de forma bastante completa todos os aspectos da aplicação. 

O Vidalia é uma interface gráfica que permite iniciar, finalizar, ver o status em um relance e monitorar o uso da banda do Tor.

~~~  
apt-get update  
apt-get install vidalia  
~~~

 [Site do Vidalia](http://www.vidalia-project.net)  

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
