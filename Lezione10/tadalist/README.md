# A Todo List!

## Nuovo esercizio.

Il modello dei dati contiene due classi: TodoList e TodoItem.  Una TodoList contiene zero o più TodoItem

              1        *
    TodoList <>--------- TodoItem
    
Tutto ciò SENZA USARE SCAFFOLD!!!  Sennò non si impara.
    
## Primo passo: la home page

Nella home page vedo:

    +------------------------
    |
    | TodoLists!
    |
    |   * Fare la spesa
    |   * Studiare per AW
    |   * Festa di carnevale
    |  
    | Create a new list
    |
    +--------------------------

In alto a sinistra c'è il titolo dell'applicazione.  Poi c'è l'elenco delle mie todolist. Poi c'è un link che dice "Create a new list".

Link e url:

 * Questa pagina risponde alla url "/".
 * Il link "Create a new list" punta a /lists/new.
 * I nomi delle liste nell'elenco puntato sono link che puntano a /lists/123 dove 123 è l'id della TodoList.

### Suggerimento: 

 * Creare per prima cosa il modello TodoList con il suo unico attributo "name"
 * Creare un po' di istanze di TodoList usando la "rails console"
 * Creare il controller ListsController.  La home page è l'azione "index".
 
## Secondo passo: la creazione di una nuova lista

Quando premo "Create new list" vado su /lists/new

    +-----------------------------------
    |
    | Name your new list
    | +--------------------------------
    | |
    | +--------------------------------
    | 
    | +-----------------+
    | |Create this list | or Cancel
    | +-----------------+
    |
    +------------------------------------
    
Questa pagina contiene una form che mi permette di inserire il nome della nuova lista.  Quando premo "Create this list" crea la nuova lista, usando l'azione /lists/create.  Questa mi ridirige su /lists/123 (che ancora non funziona.)

La parola Cancel mi riporta su "/".

Non deve essere possibile creare liste con nome vuoto!!  E nemmeno liste con nome uguale a un'altra lista esistente.  Se ci provo, devo vedere di nuovo la form con un appropriato messaggio di errore.

## Terzo passo: la pagina che mostra una lista

La pagina che mostra una lista deve mostrare il nome della lista e i suoi TodoItems.  La url di questa pagina è /lists/123 dove 123 è l'id della lista

    +----------------------------------
    |
    |  Fare la spesa
    |
    |  [] Latte
    |  [] Uova
    |  [] Giornale
    |
    |  +-------------------------------+
    |  |                               |
    |  +-------------------------------+
    |
    |  +--------------+
    |  |Add this item | 
    |  +--------------+    
    |
    +----------------------------------


Completiamo il modello: una TodoList ha molti TodoItems.  

Quando inserisco un testo nel campo e premo "Add this item", la form mi porta su "/items/create", che crea l'item e mi ridirige indietro sulla pagina della lista.

Il todo item non deve essere vuoto!  Se è vuoto, la /items/create non lo crea, mette un messaggio di errore nella flash, e ridirige comunque alla pagina di show.

## Quarto passo: spuntare gli "item"

Nella pagina di una lista, ogni item ha accanto una checkbox.  Se clicco la checkbox, vado su /items/update dove l'item viene modificato; dopodiché vengo rediretto di nuovo sulla pagina della lista.  A questo punto vedo:

    +----------------------------------
    |
    |  Fare la spesa
    |
    |  [] Latte
    |
    |  +-------------------------------+
    |  |                               |
    |  +-------------------------------+
    |
    |  +--------------+
    |  |Add this item | 
    |  +--------------+    
    |
    |  [X] Giornale
    |  [X] Uova
    |
    +----------------------------------

Cioè le voce spuntate appaiono in basso, con la checkbox spuntata.  Usare il CSS per mostrarle più piccole e in colore più grigio.

Se clicco su una checkbox spuntata, vengo di nuovo portato su /items/update e l'item viene de-spuntato e torna fra le cose da spuntare.

### Suggerimento

Ognuno dei TodoItem va racchiuso in una sua piccola form, che contiene l'id del TodoItem in un campo hidden.

(Come fa la /items/update a sapere se deve spuntare o de-spuntare?  A vostra scelta, la form di cui sopra potrebbe contenere un altro campo hidden che gli dice in che stato deve mettere il TodoItem, oppure si può andare a vedere qual'è lo stato corrente dell'item (spuntato o non spuntato) e invertirlo.)


## Quinto passo: aggiungere registrazione e autenticazione

Non posso vedere nessuna pagina come utente anonimo.  Qualsiasi pagina io provi a vedere, mi ridirige sulla /sessions/new.  La pagina /sessions/new ha un link a "Registrati" che punta a /users/new. Usare le tecniche che abbiamo già usato per l'esempio Tuitter.  Quando mi sono autenticato, vedo un messaggio "Benvenuto Tizio" con accanto un link al "logout" (che punta a /sessions/destroy).

## Sesto passo: autorizzazione.

Posso vedere solo le liste che ho creato io.  Quando visito la home page, vedo elencate solo le mie liste.  Se provo a inserire la url di una lista di qualcun altro, vengo rediretto sulla home page.  Se provo a modificare una lista non mia, vengo rediretto.  Usare le tecniche che abbiamo già usato per Tuitter.


## Riassumendo

L'elenco delle routes dovrebbe comprendere:

  * / che corrisponde a lists_controller#show
  * /lists/new
  * /lists/create
  * /lists/123 (corrisponde a lists_controller#show)
  * /items/create
  * /items/update
  * /users/new
  * /users/create
  * (opzionale) /users/edit e /users/update
  * /sessions/new
  * /sessions/create
  * /sessions/destroy

