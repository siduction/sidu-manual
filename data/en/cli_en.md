319 <div id="main-page"></div>
320 <div class="divider" id="nm on cli"></div>
321 ## Network Manager in a Shell

322 ### Common hints

323 Networkmanager [NM] is a quite useful substitute for the network commands  *ifup, ifdown*  or  *ifconfig*  in Debian. The prejudice that NM is not suited for the command line or that it is not fit for every day use cannot be upheld anymore. Besides the GUI version there is a powerful command line client named  *nmcli* .

324
325 In the following examples we assume 2 configured interfaces:

326
327 <div>
328 Wireless:
329 Name: BluelupoWLAN
330 Interface: wlan0
331 </div>
332
333 <div>
334 Wired:
335 Name: BluelupoLAN
336 Interface: eth0
337 </div>
338
339 Please adjust the respective name to your usecase.

340
341 ### Installation

342 Should NM not be installed yet, this is easily done.

343 The following command installs all packages needed to configure all possible connections [mobile broadband, wireless and wired] as well as the graphical KDE-Plasma-Widget for NM.

344
~~~  
345 apt-get install network-manager modemmanager mobile-broadband-provider-info plasma-widget-networkmanagement network-manager-vpnc network-manager-openvpn network-manager-pptp  
~~~

346
347 ### Show information about wireless networks

348 Available networks at your location can be seen with  *nmcli dev wifi list* .

349
~~~  
350 nmcli dev wifi list  
351 SSID BSSID MODE FREQUENCY RATE SIGNAL SECURITY ACTIV  
352 'WLAN01' 00:24:FE:A7:82:99 Infrastucture 2412 MHz 54 MB/s 45 WPAWPA no  
353 'WLAN02' 34:08:04:DB:05:A0 Infrastucture 2437 MHz 54 MB/s 37 WPA no  
354 'WLAN03' 00:1A:4F:DA:D5:1D Infrastucture 2462 MHz 54 MB/s 29 WPAWPA no  
355 'WLAN04' C0:25:06:BB:10:3C Infrastucture 2462 MHz 54 MB/s 19 WPAWPA no  
356 'WLAN05' 00:26:4D:4B:24:FF Infrastucture 2437 MHz 54 MB/s 15 WPAWPA no  
357  
358 SSID changed for security reasions  
359   
~~~

360
361 ### Show configured connections

362 With the command  *nmcli con list*  you can see the configured connections on your machine.

363
~~~  
364 nmcli con list  
365 NAME UUID TYPE TIMESTAMP  
366 BluelupoWLAN a9fc7143-11cb-e64a-b6b5-63c94600490c 802-11-wireless Fr 29 Jun 2012 11:06:48 CEST  
367 BluelupoLAN b92aa237-1b70-4a2b-9bbb-da15a3f0e599 802-3-ethernet Fr 29 Jun 2012 06:17:58 CEST  
368 BluelupoUMTS fe09a895-f5fa-4b94-8622-d03c4195721e gsm Fr 29 Jun 2012 10:37:30 CEST  
369   
~~~

370 In the above example you see 3 connections: wireless, wired and mobile broadband.

371 ### Show configured devices

372 To find out which devices [interfaces] NM can see use the command:  *nmcli dev status* .

373
~~~  
374 nmcli dev status  
375 DEVICE TYPE STATUS  
376 ttyACM0 gsm not connected  
377 usb0 802-3-ethernet not available  
378 wlan0 802-11-wireless connected  
379 eth0 802-3-ethernet not available  
380   
~~~

381 Very detailed information [properties] on your own and other wifi networks at your given location can be obtained by:  *nmcli dev list*  [Info in this example shortened for security reasons].

382
~~~  
383 nmcli dev list  
384 [...]  
385 GENERAL.DEVICE: wlan0  
386 GENERAL.TYPE: 802-11-wireless  
387 GENERAL.VENDOR: Intel Corporation  
388 GENERAL.PRODUCT: PRO/Wireless 3945ABG [Golan] Network Connection  
389 GENERAL.DRIVER: iwl3945  
390 GENERAL.HWADDR: 00:18:DE:55:11:0D  
391 GENERAL.STATUS: 100 (connected)  
392 GENERAL.REASON: 0 (no reason)  
393 GENERAL.UDI: /sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0/net/wlan0  
394 GENERAL.IP-IFACE: wlan0  
395 GENERAL.NM-MANAGED: yes  
396 GENERAL.FIRMWARE-MISSING: no  
397 GENERAL.CONNECTION: /org/freedesktop/NetworkManager/ActiveConnection/3  
398 CAPABILITIES.CARRIER:FREQUENCY:DETECTION:no  
399 CAPABILITIES.SPEED: 54 Mb/s  
400 WIFI-PROPERTIES.WEP: yes  
401 WIFI-PROPERTIES.WPA: yes  
402 WIFI-PROPERTIES.WPA2: yes  
403 WIFI-PROPERTIES.TKIP: yes  
404 WIFI-PROPERTIES.CCMP: yes  
405 [...]  
406   
~~~

407
408
409 ### Switching between connections

410 To change the type of connection. e.g. from wired to wireless, you need to deactivate the current connection and activate the new one with the following commands:

411
~~~  
413  
414 # nmcli dev disconnect iface eth0  
415 # nmcli dev status  
416 DEVICE TYPE STATUS  
417 ttyACM0 gsm not connected  
418 usb0 802-3-ethernet not connected  
419 wlan0 802-11-wireless not connected  
420 eth0 802-3-ethernet not connected  
421   
~~~

~~~  
423 Now we bring the wireless connection up:  
424 # nmcli con up id BluelupoWLAN  
425 # nmcli dev status  
426 DEVICE TYPE STATUS  
427 ttyACM0 gsm not connected  
428 usb0 802-3-ethernet not available  
429 wlan0 802-11-wireless connected  
430 eth0 802-3-ethernet not connected  
431   
~~~

432
433 The change from wired to wireless [or any other change of interfaces] can also be put into one command:

434
435 ### Switch from wired to wireless connection

436
~~~  
437  # nmcli dev disconnect iface eth0 && sleep 2 && nmcli con up id BluelupoWLAN && nmcli dev status  
438  
439 And from wireless to wired connection:  
440  
441 # nmcli dev disconnect iface wlan0 && sleep 2 && nmcli con up id BluelupoLAN && nmcli dev status  
442   
~~~

443
444
445 ### More information

+ 447   
   ~~~    
   449 man nmcli    
   450     
   ~~~
  
   451  
+  [Ubuntuusers Wiki](http://wiki.ubuntuusers.de/NetworkManager?redirect=no)   

454 <li> [Ubuntu-Manpage von nmcli](http://manpages.ubuntu.com/manpages/maverick/man1/nmcli.1.html) </li>
455 </ul>
456 <div id="rev">Page last revised 01/09/2012 1345 UTC</div>
457 translated from a wiki post by Bluelupo

458
459 </div>
460 </div>
