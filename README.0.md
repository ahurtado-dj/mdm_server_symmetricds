=======================
SYMMETRICDS
=======================
	- EN PROGRESO - 

	es un engine de replicacion tipo master-slave
	define un masternode
	define nodos slave
	cada cambio en el master node es replicado a los hijos
	
	normlammente intenta que la repicacion sea exacta hacia el nodo destino
	sin embargo se pueden realizar transformaciones mediante
	la extension de un api que tiene.
	
	

- descargar symmetricds
descomprimir en c:\.work\symmetric-server-3.7.28

- configurar nodos
	MASTER: ek2 
	SLAVE1: ek1 

copiar la configuracion a [SYMMETRIC-SERVER]/engines/
ejecutar lo siguiente para 
 (a) configurara las tablas en el nodo msater y luego en el slave1
 (b)  cargar el script de configuracion

cd engines
..\bin\symadmin --engine master create-sym-tables
..\bin\dbimport --engine master master_init.sql

#luego habilitar el autoregistro
#editar el archivo conf/symmetric.properties cambiando: auto.registration=true
#registration.url

- iniciar el servidor sym
..\bin\sym	


## InitialLoad
se cargan los datos de los slaves enviando los datos del master: 
bin/symadmin --engine master reload-node 001



TABLAS
sym_outgoing_batch: ver el estado de envio; si falla, se debe corregir y elimianr el registro aqui



========================
OTRAS ALTERNATIVAS
=======================
- Tugsten replicator (version open source y empresarial:vmware) (MySQL?)
- MasterDataServices (Sqlserver)
- talendETL
- http://www.manageability.org/blog/stuff/java-open-source-replication-synchronization/view
- Oracle GoldenGate
- OpenDBDiff



		
		
		


=======================
REFERENCIAS
=======================

- http://www.slideshare.net/jmfranco/mdm-for-customer-data-with-talend
- talend: requiere un conector CDC: https://www.talendforge.org/forum/viewtopic.php?id=36913
- talend-mdm-tutorial: https://docs.google.com/document/d/1hTs0zKDvMq1AN_mliYbkSNWavGvX5upjAKIKPXyAPi4/edit#
