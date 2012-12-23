
# Un clone di Twitter

Per lavorare su questo esercizio, assicurarsi di stare usando Ruby versione 1.9.3 e Rails versione 3.2.9

## Orientamento

Eseguire il server con 

    $ rails server
    
E verificare di vedere la home page dell'applicazione alla url http://localhost/users


## Esercizio

1. Aggiungere le seguenti validazioni al modello User
  * username deve essere presente
  * username deve essere lungo almeno 3 caratteri
  * email deve contenere il carattere "@"
2. Verificare che non sia possibile creare un utente nuovo senza rispettare le validazioni; verificare che si vedano i messaggi di errore
3. Verificare che le validazioni funzionino anche quando si aggiorna il profilo.  Per questo sarà necessario modificare lo user_controller.rb
4. Creare un modello ActiveRecord per i tweet.  Verificare che sia possibile creare i tweet.
5. Modificare la tabella dei tweet per contenere un attributo user_id di tipo integer.  Questo va fatto creando una nuova migrazione con `rails generate migration add_user_id_to_tweet` e andando ad aggiungere il codice ruby necessario nel file di migrazione appena creato
6. Modificare la form dei tweet in index.html.erb; aggiungere un input hidden che specifica lo user_id, tenendolo fissato a 1.  Simuliamo così che l'utente in sessione sia l'utente numero uno.
7. Opzionalmente, al posto del campo hidden, mettere un menu (elemento select di html) che permetta di scegliere l'utente fra tutti gli utenti esistenti nel database.
8. Modificare la presentazione dei tweet per mostrare lo user che ha generato il tweet.  Nota bene, si vuole mostrare lo username e non l'id!  La maniera migliore è aggiungere un metodo al modello Tweet che restituisca lo user.  

Per esempio:

    class Tweet < ActiveRecord::Base    
      def user
        User.find(user_id)
      end
    end 



