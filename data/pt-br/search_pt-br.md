<div id="main-page"></div>
<div class="divider" id="search-on"></div>
## Busca On-Line

#### Opção 1

Digite uma ou mais palavras no campo abaixo e clique `Search (ou pressione Return)` .


---

<form method="get" action="/cgi-bin/perlfect/search-pt-br/search.pl">
  
<input type="hidden" name="p" value="1" />  
<input type="hidden" name="lang" value="pt-br" />  
<input type="hidden" name="include" value="" />  
<input type="hidden" name="exclude" value="" />  
<input type="hidden" name="penalty" value="0" />  
<select name="mode">  
<option value="all">Match ALL words</option>  
<option value="any">Match ANY word</option>  
</select>  
<input type="text" name="q" /><input type="submit" value="Search" />  


</form>

---

###### Opções de busca

Se `Match ALL words`  for selecionado, apenas aqueles documentos que contiverem todas as palavras digitadas no campo de busca serão retornados. Com `Match ANY word`  serão mostrados todos os documentos que contiverem pelo menos uma das palavras. 

Uma alternativa é colocar o `sinal de mais (+)`  à esquerda de uma ou mais palavras para que sejam retornados apenas os arquivos que contenham todas elas. Palavras precedidas de um `sinal de menos (-)`  fazem com que sejam mostrados apenas os aquivos que NÃO contenham nenhuma delas.

Observe que não é possível pesquisar por frases, isto é, não faz nenhum sentido colocar aspas no início e no fim das palavras que você procura `"como acontece aqui"` .

Os resultados são ordenados por relevância, com os documentos mais relevantes listados primeiro. A relevância depende do número e da posição das palavras nos arquivos.

#### Opção 2

Para uma busca online, digite ou cole na barra de endereços de seu navegador, (onde `xxxx`  é a palavra que você deseja procurar), o seguinte:

~~~  
xxxxx site:manual.siduction.org/pt-br  
~~~

<div class="divider" id="search-off"></div>
## Busca off-Line

O Manual do siduction criou algumas configurações especiais, juntamente com o desenvolvedor do Recoll, configurações estas que passaram a fazer parte do pacote padrão. O Recoll é uma ferramenta pessoal de procura de texto para o Unix/Linux. Essa ferramenta se baseia no poderoso back-end Xapian, para quem produziu uma interface gráfica em QT, cheia de opções, mas fácil de usar.  *Fica aqui nosso agradecimento todo especial ao Recoll* .

O Recoll é chamado de `Personal Search Tool ('Ferramenta de Busca Pessoal)`  no menu Debian do KDE.

Para configurar a busca local, é necessário seguir alguns passos:

##### Passo 1

O manual está disponível via apt nas seguintes línguas atualmente: de, en, pt-br.

~~~  
apt-get update  
apt-get install bluewater-manual-xx (onde xx é a língua desejada; exemplo: pt-br, para Português do Brasil))  
~~~

##### Passo 2

~~~  
apt-get install recoll  
~~~

##### Passo 3

+ Quando iniciado pela primeira vez, o Recoll diz que não pode montar uma base de dados; `clique 'cancel'`  para que surja uma caixa de configuração de indexação.  
+ Na aba 'Global parameters', clique no sinal `+ (mais)`  (logo abaixo de 'Top directories'), selecione `/usr/share/bluewater-manual` , clique na pasta referente à sua língua (provavelmente pt-br) e clique em OK. A seguir, clique clique no sinal `- (menos)`  e apague quaisquer outras pastas que ali estejam, inclusive aquelas iniciadas com um `~ (til)` .  
+ Por fim, clique `File>Update Index`  e procure por qualquer tópico do manual do siduction que precisar.  

Se for necessário reconfigurar o Recoll devido a atualizações do manual via apt `(no terminal, como usuário)` :

~~~  
recollindex -z  
~~~

Daí: `Kmenu >Debian >Aplicativos > Gerenciamento de Dados > Personal Search Tool e depois em File>Update Index` .

O link 'Preview' destaca todas as instâncias da palavra no arquivo, enquanto que 'Open' abre seu navegador padrão e usa `Encontrar nesta página`  para uma miniprocura da palavra que você pesquisou.

 [Homepage do Recoll](http://www.lesbonscomptes.com/recoll/) .

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
