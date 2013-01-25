
# Esercizio
## Categorizzare i tweet

### 0. Approntare il controllo dei sorgenti.

Creiamo un nuovo repository con "git init", e committiamo tutto il contenuto di questo progetto con "git add -A", seguito da "git commit".

Poi creiamo un account gratuito su github.com.  Creare un nuovo repository su Github, poi seguire le istruzioni per importare tutto il contenuto del nostro progetto.   

### 1. Gui e salvataggio

Aggiungiamo all'interfaccia utente un campo di testo che permetta di aggiungere una "categoria" al tweet.

Il tweet deve essere implementato come una semplice stringa attributo di Tweet.

FATE UN COMMIT A QUESTO PUNTO!!!!

### 2. Validazione

* Non deve essere possibile salvare una categoria con il nome vuoto!
* Il nome della categoria non deve contenere spazi

FATE UN COMMIT A QUESTO PUNTO!!!!

### 3. Visualizzazione

La categoria deve essere visualizzata nel box del tweet.  Il nome della categoria deve essere cliccabile... e portare a una pagina /categories/nomecategoria che mostra l'elenco dei tweet di quella categoria!

FATE UN COMMIT A QUESTO PUNTO!!!!

### 4. Entità separata

Modificare l'implementazione della categoria; deve ora essere una entità separata.  Va creato il modello Category, la tabella categories, e nel tweet la chiave esterna category_id.

Un buon passo è creare nella classe Category il metodo

  def Category.find_or_create_by_name(name)
    ...
  end
  
perché questo metodo mi permette di semplificare un bel po' il codice nel controller.

FATE UN COMMIT A QUESTO PUNTO!!!!

La validazione della categoria deve essere spostata da Tweet a Category.  Anche il CategoryController va modificato di conseguenza.

FATE UN COMMIT A QUESTO PUNTO!!!!

### 5. Menu delle categorie

Sotto al campo di testo, fare apparire un menu (select) che riporta l'elenco delle categorie.  L'utente può scegliere la categoria con il menu, oppure digitarla nel campo di testo.

FATE UN COMMIT A QUESTO PUNTO!!!!
