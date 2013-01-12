
# Un clone di Twitter: autenticazione e autorizzazione

Per lavorare su questo esercizio, assicurarsi di stare usando Ruby versione 1.9.3 e Rails versione 3.2.9

## Esercizio

1. Proteggere l'applicazione dalla creazione di tweet da utenti non autenticati tramite curl 

  Esempio di attacco

      curl -d 'tweet[user_id]=7' -d 'tweet[text]=Hacked' http://localhost:3000/tweets/create
    
  Attenzione: non è sufficiente verificare che ci sia un utente in sessione.  Bisogna anche verificare che l'utente in sessione corrisponda allo user_id del tweet che stiamo creando; altrimenti diventa possibile per un utente loggato creare dei tweet per chiunque altro.  L'attacco può essere portato a termine, per esempio, usando il plugin di Firefox Tamper Data.
    
2. Proteggere la modifica profilo utente da accessi non autorizzati.  Se non sono loggato, posso vedere il profilo utente di chiunque ma non posso modificarlo.  Se sono loggato, posso modificare il mio profilo ma non quello degli altri utenti.

  a) Modificare l'interfaccia utente: il link "aggiorna il tuo profilo" non deve apparire se non si tratta del mio profilo
  b) modificare users_controller: una richiesta di aggiornare un utente non deve essere accettata a meno che non sia l'utente in sessione che modifica il suo profilo.

3. Non è sicuro salvare le password crittate semplicemente con SHA256. Il problema è che così facendo, due password uguali vengono crittate nello stesso identico modo.  Per evitare questo problema, aggiungiamo un "salt" all'algoritmo di crittazione.

  - Aggiungere una colonna password_salt di tipo :string alla tabella users
  
  - Modificare il metodo di User encrypt_password per 
      - generare un numero casuale e convertirlo in stringa
      - salvare questo numero in password_salt
      - salvare in password_digest il digest di (sale + password) concatenati insieme
    
  - Modificare il metodo authenticate: deve usare il password_salt
  - Verificare che sia ancora possibile registrare un utente e poi fare la login!!!
