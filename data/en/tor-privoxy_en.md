<div id="main-page"></div>
<div class="divider" id="privoxy"></div>
## Privoxy

 Privoxy is a web proxy with advanced filtering capabilities for protecting privacy, modifying web page data, managing cookies, controlling access, and removing ads, banners, pop-ups and other obnoxious Internet junk. Privoxy has a very flexible configuration and can be customised to suit individual needs and tastes. Privoxy has application for both stand-alone systems and multi-user networks. Privoxy is based on Internet Junkbuster (tm).

To install privoxy:

~~~  
apt-get update  
apt-get install privoxy  
~~~

A default installation should provide a reasonable starting point for most. There will undoubtedly be occasions where you will want to adjust the configuration, but that can be dealt with as the need arises. Little to no initial configuration is required in most cases. 

<!--Using privoxy and the siduction meta-installer  [please refer here](sys-admin-meta-en.htm#meta-proxy) .

-->
In the privoxy config you may need to uncomment lines and this will depend on your preferences, and it will differ for every user. 

 [The Privoxy full user manual with advanced config topics](http://www.privoxy.org/user-manual/index.html) 

<div class="divider" id="tor"></div>
## Tor

Tor is a network of virtual tunnels that allows people and groups to improve their privacy and security on the Internet. It also enables software developers to create new communication tools with built-in privacy features. Tor provides the foundation for a range of applications that allow organisations and individuals to share information over public networks without compromising their privacy.

To install Tor:

~~~  
apt-get update  
apt-get install tor  
~~~

The default torrc file should work out of the box for most Tor users. You will need to configure Privoxy to use Tor on the internet, see: [Tor and internet browsing](https://www.torproject.org/docs/tor-doc-unix#privoxy) .

You should also be aware that internet throughput speeds will be negatively affected.

<!-- For the Iceweasel browser there is a  [Torbutton](https://addons.mozilla.org/en-US/firefox/addon/2275)  add-on available.

 -->
 [The Tor documentation](https://www.torproject.org/documentation.html.en)  offers comprehensive on all aspects of Tor. 

Vidalia is a controller GUI for the Tor software and allows you to start and stop Tor, view the status of Tor at a glance,and monitor Tor's bandwidth usage.

~~~  
apt-get update  
apt-get install vidalia  
~~~

 [Vidalia Homepage](https://www.torproject.org/projects/vidalia.html.en)  

<div id="rev">Content last revised 08/01/2012 1800 UTC</div>
