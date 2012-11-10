
Questa cartella contiene un programma Ruby funzionante, che analizza un file contenente il log degli accessi di un web server

    access_log
    
e produce un report di quali codici di status HTTP sono stati serviti giorno per giorno.  Per provare a vedere funzionare il report, per prima cosa verifica di avere la versione 1.9.3 di Ruby con il comando

    ruby -v
    
Poi esegui

    ruby access_log_report.rb | less
    
La struttura del progetto è la seguente:

    ├── README.md                 Questo file
    ├── Rakefile                  Non ci interessa per ora
    ├── access_log                I dati grezzi
    ├── access_log_report.rb      Il nostro script
    ├── lib                       Codice Ruby da cui il nostro script dipende
    └── test                      Per il momento non ci interessa

Per iniziare a orientarti nel progetto, leggi il file access_log_report.rb cominciando **dal fondo**.  Questo è un programma *a oggetti*; quando ne afferri il senso vedrai che effettuare modifiche è semplice.  Uno schema UML:

    +-----------+      +--------+ 1   * +-----------+ 1   * +------------+
    | AccessLog |<-----| Report |<>-----| ReportRow |<>-----| ReportCell |
    +-----------+      +--------+       +-----------+       +------------+
                            |
                            V
                   +------------------+
                   | PlainTextPrinter |
                   +------------------+

* AccessLog incapsula il file `access_log`; restituisce una riga alla volta,
  incapsulata in un oggetto AccessLine. Un AccessLine fornisce accesso ai dati
  della riga, ad esempio `line.status` oppure `line.bytes_sent`.

* Report è la classe centrale. Incapsula una collezione di ReportRow,
  indicizzata per data.

* ReportRow rappresenta una riga del report e incapsula una collezione di
  ReportCell.
  
* ReportCell rappresenta una singola cella.

* PlainTextPrinter si occupa di trasformare il contenuto del report in una
  sequenza di caratteri ASCII.

Quando diamo al Report il comando `read(access_log)`, il Report legge una AccessLine per volta; ciascuna AccessLine viene passata alla sua ReportRow.  ReportRow, a sua volta, passa la AccessLine a ciascuna ReportCell, e la ReportCell si aggiorna con i dati della AccessLine.  Ciascun diverso tipo di ReportCell usa la AccessLine in maniera diversa; lo StatusCounter2xx ad esempio va a vedere lo status, e incrementa il suo valore se lo status è compreso fra 200 e 299.  DateCell invece prende semplicemente il suo valore dalla data dalla AccessLine. 

Quindi, ragionando ad oggetti, se io sono una ReportCell, allora conosco il mio valore (che è assegnato alla variabile di istanza @value).  Quando mi viene passata una AccessLine, la esamino e aggiorno il mio @value sulla base di una mia regola specifica.

Potresti stupirti perché non si vede il ciclo che itera su tutte le righe del report; in realtà questo ciclo c'è (nel file lib/report.rb); ma dal punto di vista della ReportCell, non lo vediamo; sappiamo soltanto che ci vengono passate delle AccessLine, una per volta.


# Esercizi

0. Aggiungere la colonna "Count 5xx", con un contatore che conta gli accessi che hanno prodotto status 500, 501, 502,...

1. Aggiungere una colonna "Bytes sent average" con la media dei byte inviati al browser.  Questo dato è presente nel log, è il numero appena dopo lo status.

2. Aggiungere una colonna con "IP Count" il numero di indirizzi IP differenti.  Mi spiego: se in una data giornata abbiamo 7 accessi, di cui tre accessi da 1.2.3.4, due accessi da 2.3.4.5 e due accessi da 3.4.5.6, allora il valore della cella "IP Count" deve essere "3".

3. Output con tabella html.  Sostituire nello script l'oggetto PlainTextPrinter con un oggetto HtmlPrinter, che dobbiamo scrivere.  Questo oggetto risponde agli stessi metodi di PlainTextPrinter, ma produce in output una tabella HTML.  E' sufficiente produrre l'html in output.  Se si vuole aprire il file in un browser, si può dare il seguente comando

    ruby access_log_report.rb > report.html; firefox report.html

4. (Difficile, facoltativo) Scrivere un nuovo report raggruppato per Path.  Per fare questo occorre andare a modificare la classe Report, per renderla più flessibile.  La `Report.new` deve diventare `Report.new(:date)` nel caso vogliamo un report raggruppato per date, oppure `Report.new(:path)` nel caso vogliamo un report raggruppato per path.  Questo simbolo verrà poi usato per chiedere alla AccessLine la chiave di raggruppamento.  Nota: ovviamente quello che desideriamo è rendere Report ancora più flessibile, per poter scegliere il campo su cui raggruppare.  Modificare il Report inchiodando dentro ".path" al posto di ".date" non è la soluzione desiderata!

Per l'ultimo esercizio occorre sapere questo trucco: in Ruby, la maniera normale di invocare un metodo è

    access_line.date

ma è anche possibile invocare lo stesso metodo con

    access_line.send(:date)
    
Questo perché "send" significa "invoca questo metodo".  

