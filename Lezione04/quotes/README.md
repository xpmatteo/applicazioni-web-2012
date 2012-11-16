
# Sommario

Questa è un'applicazione che contiene un database di citazioni (quotes).  


## Per vederla funzionare

Installare Rails con

    gem install rails
  
Per caricare tutte le gemme che servono eseguire da dentro la directory del progetto

    bundle install
  
Poi per fare partire il server eseguire

    rails server

Aprire il browser alla url http://localhost:3000/.  Si deve poter leggere una citazione.


### Problemi che abbiamo visto in classe

Se appare un messaggio tipo

    sqlite3.h is missing
    
Provare (su Ubuntu)

    sudo apt-get install libsqlite3-dev

Per altri problemi, cercare una soluzione con Google.


## Esercizi


### Link a /quotes/1234

Vogliamo fare in modo che il numero che appare sopra la citazione sia un link permanente (un "permalink") alla citazione stessa.  Per fare questo dobbiamo eseguire i seguenti passi: (verificare sempre che cosa succede nel browser dopo ogni modifica)

0. modificare app/views/quotes/index.html.erb
  - mettere l'indirizzo del link alla singola quote nel formato /quotes/1234
  - (verifico che il link ha l'indirizzo corretto nel browser)
  - (verifico che la route non esiste)

1. modificare config/routes.rb
  - mettere la riga
     
      get "quotes/:id" => "quotes#show"

  - (verifico che ora la route viene riconosciuta, ma non c'è la "action" (il metodo) nel controller)

2. modificare app/controllers/quotes_controller.rb
  - mettere l'azione (il metodo) show
  - fare restituire al metodo show la citazione desiderata per ID, con un comando tipo
  
      @quote = Quote.find(params[:id])
      
  - (Verifico che il metodo Quote.find non esiste)

3. Modificare app/models/quote.rb
  - Aggiungere il metodo Quote.find che prende un ID e restituisce la quote corrispondente.
  - (Verifico che il link ora funziona correttamente.)

### Aggiornare la navigazione a Home

La parola "Home" nel layout app/views/layouts/application.html.erb deve diventare un link alla pagina principale "/".

### Aggiungere una pagina con 10 citazioni casuali

Le parole "10 Random" nel layout devono diventare un link a "/quotes/random?count=10". Questa pagina deve contenere non una ma 10 citazioni scelte a caso.  (Anche in questo caso, come sempre, ad ogni minima modifica verificare che come funziona l'app nel browser.)

0. Aggiornare il link in app/views/layouts/application.html.erb

1. Aggiornare config/routes.rb, aggiungere una riga

    get "/quotes/random" => "quotes#random"

2. Aggiungere l'azione "random" al QuotesController.  La prima versione restituisce un numero fisso di citazioni.

    def random
      @quotes = [Quote.random, Quote.random, ...(10 volte), Quote.random]
    end

3. Implementare la view corrispondente in app/views/quotes/random.html.erb. Questa view deve mostrare tutte le citazioni contenute nell'array @quotes.  Usare un costrutto tipo

    <% for quote in @quotes %>
      ... codice html che mostra la quote
    <% end %>

4. Modificare l'azione quotes#random per rispettare il parametro count. Se ad esempio apriamo la pagina /quotes/random?count=3 deve mostrare esattamente tre citazioni. Il metodo random del controller diventerà simile a

    def random
      count = params[:count].to_i
      @quotes = Quote.many_random(count)
    end

    La logica che seleziona un certo numero di citazioni va tolta dal controller e spostata nel modello.


### Aggiungere una pagina con un range di citazioni casuali

Le parole "0-99", "100-149", ecc. nel layout devono diventare link a pagine che contengono, rispettivamente, le prime 50 citazioni, le seconde 50, ecc.  L'indirizzo avrà la forma, ad esempio

    /quotes/range?start=100&count=50
    
(in questo esempio restituirà le citazioni con ID da 100 a 149.)



    
