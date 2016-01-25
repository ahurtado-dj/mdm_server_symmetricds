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
	
========================================
INFORMACION TECNICA - INSTALACION MASTER
=========================================

- descargar symmetricds
descomprimir en 
SYMMETRICDS_HOME=c:\.work\symmetric-server-3.7.28

- configurar nodos
	MASTER: ek2 
	SLAVE1: ek1 

copiar la configuracion a [SYMMETRIC-SERVER]/engines/
	
	cd C:\.apps\e_aj.Apps\.ws\ARQ\trunk\02_Proyectos\0028_Aj_Baseline_Ciclo01\03_construccion\mdm_base\mdm_server_symmetricds
	cp conf\engines $SYMMETRICDS_HOME\engines

ejecutar lo siguiente para 
 (a) configurar las tablas en el nodo master y luego en el slave1
 (b)  cargar el script de configuracion

cd engines
cd $SYMMETRICDS_HOME\engines

..\bin\symadmin --engine master create-sym-tables
..\bin\dbimport --engine master master_init.sql

#luego habilitar el autoregistro
#editar el archivo conf/symmetric.properties cambiando: auto.registration=true
#registration.url


========================================
INFORMACION TECNICA - INSTALACION SLAVE1
=========================================
	seguir los siguientes pasos para la prueba de sincronizacion 
	de las 2 aplicaciones, luego de haber copiado mdm_app_master a mdm_app_slave1

bajar la app ek1
  eliminar la db en ek1, para recrear las tablas de sincronizacion
  recrear la db de la aplciacion: 
	python manage.py migrate
	python manage.py createsuperuser (
		-> name: admin
		-> mail: ahurtado.dj@gmail.com
		-> pwd: meconio3

luego se sube symmetricds para la autoconfiguracion del slave1
cd $SYMMETRICDS_HOME\engines
..\bin\sym	

cuando termine de configurar, parar; 

despues: se cargan los datos de los slaves enviando los datos del master
(de esta forma se hace un cargue inicial). para ello ejecutar:

cd $SYMMETRICDS_HOME\engines
..\bin\symadmin --engine master reload-node 001

luego subir de nuevo la aplicacion (python manage.py runserver 0.0.0.0:8001)


========================================
INFORMACION TECNICA - SUBIR SYMMETRIC
=========================================

- iniciar el servidor sym
cd $SYMMETRICDS_HOME\engines
..\bin\sym	

==============================
PRUEBA INICIAL
==============================
en la app ek2 crear nueva persona:
tipopersona: N
tipoid: TI
id: 100100100
nombre: marilin 
apellido: gomez
fechanac: today
celular: 300300301
email-persnal: marilin@google.com









==============================
INITIAL-LOAD
==============================


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
- http://www.symmetricds.org/doc/3.7/html/tutorials.html (tutorial inicial)
- http://www.slideshare.net/jmfranco/mdm-for-customer-data-with-talend
- talend: requiere un conector CDC: https://www.talendforge.org/forum/viewtopic.php?id=36913
- talend-mdm-tutorial: https://docs.google.com/document/d/1hTs0zKDvMq1AN_mliYbkSNWavGvX5upjAKIKPXyAPi4/edit#
