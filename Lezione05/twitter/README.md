
# Un clone di Twitter

Per lavorare su questo esercizio, assicurarsi di stare usando Ruby versione 1.9.3 e Rails versione 3.2.9

## Orientamento

Eseguire il server con 

    $ rails server
    
E verificare di vedere la home page dell'applicazione alla url http://localhost/users


## Esercizio

* Aggiungere un tweets_controller con

  rails generate controller tweets
  
* modificare app/views/tweets/index.html.erb 
             app/controllers/tweets_controller.rb
             
  Per vedere un elenco di "tweet" alla pagina
  http://localhost:3000/tweets/index

* Aggiungere le azioni "show", "new", "create"

* Verificare che funzionino!!!

* Modificare l'oggetto Tweet per accettare il parametro :user_id.  Ad esempio
    t = Tweet.new(:text => "ciao", :user_id => 1)
  poi definire un metodo .user che restituisce l'utente che ha twittato:
    t.user #=> restituisce User.find(1)
    
* Modificare la form di tweets/new per accettare anche l'id dell'utente

* Quando mostriamo un tweet, dovrebbe essere in un riquadro tipo

    +--------------------------------------------+
    | @pippo                                     |
    | Gawrsh! Sono proprio contento di studiare  |
    | Rails!                                     |
    |                                     (edit) |
    +--------------------------------------------+
    
    Dove (edit) permette di modificare il messaggio, e
    @pippo è un link alla pagina dell'utente @pippo

* La pagina /users/1 deve mostrare tutti i tweet dell'utente a cui
  appartiene quella pagina

