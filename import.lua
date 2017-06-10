function verificaQuebraOssosPerguntas()

	local sqlite3 = require( "sqlite3" )
	local path = system.pathForFile( "meduca.db", system.DocumentsDirectory )
	local db = sqlite3.open( path ) 

	for row in db:nrows("SELECT count(*) as count FROM quebra_ossos_perguntas") do
        id_pergunta = tonumber(row.count)
    end

    if (id_pergunta < 33) then
    	print("entrou")
    	local tablefill = [[INSERT INTO `quebra_ossos_perguntas` VALUES (1,'ISQUIO','É um osso','Localizado na extremidade inferior','É um osso do quadril');
							INSERT INTO `quebra_ossos_perguntas` VALUES (2,'ILIO','É um osso','Localizado na extremidade inferior','É um osso do quadril');
							INSERT INTO `quebra_ossos_perguntas` VALUES (3,'PUBIS','É um osso','Localizado na extremidade inferior','É um osso do quadril');
							INSERT INTO `quebra_ossos_perguntas` VALUES (4,'FEMUR','É um osso','Localizado em uma das extremidades','Localizado na extremidade inferior');
							INSERT INTO `quebra_ossos_perguntas` VALUES (5,'PATELA','É um osso','Localizado em uma das extremidades','Localizado na extremidade inferior');
							INSERT INTO `quebra_ossos_perguntas` VALUES (6,'FIBULA','É um osso','Localizado em uma das extremidades','Localizado na extremidade inferior');
							INSERT INTO `quebra_ossos_perguntas` VALUES (7,'TIBIA','É um osso','Localizado em uma das extremidades','Localizado na extremidade inferior');
							INSERT INTO `quebra_ossos_perguntas` VALUES (8,'TARSOS','É um osso','Localizado na extremidade inferior','Localizado no pé');
							INSERT INTO `quebra_ossos_perguntas` VALUES (9,'CALCANEO','É um osso','Localizado na extremidade inferior','Localizado no pé');
							INSERT INTO `quebra_ossos_perguntas` VALUES (10,'TALUS','É um osso','Localizado na extremidade inferior','Localizado no pé');
							INSERT INTO `quebra_ossos_perguntas` VALUES (11,'NAVICULAR','É um osso','Localizado na extremidade inferior','Localizado no pé');
							INSERT INTO `quebra_ossos_perguntas` VALUES (12,'CUNEIFORMES','É um osso','Localizado na extremidade inferior','Localizado no pé');
							INSERT INTO `quebra_ossos_perguntas` VALUES (13,'CUBOIDE','É um osso','Localizado na extremidade inferior','Localizado no pé');
							INSERT INTO `quebra_ossos_perguntas` VALUES (14,'METATARSOS','É um osso','Localizado na extremidade inferior','Localizado no pé');
							INSERT INTO `quebra_ossos_perguntas` VALUES (15,'FALANGES','É um osso','Localizado na extremidade inferior','Localizado no pé');
							INSERT INTO `quebra_ossos_perguntas` VALUES (16,'CLAVICULA','É um osso','Localizado em uma das extremidades','Localizado na extremidade superior');
							INSERT INTO `quebra_ossos_perguntas` VALUES (17,'ESCAPULA','É um osso','Localizado em uma das extremidades','Localizado na extremidade superior');
							INSERT INTO `quebra_ossos_perguntas` VALUES (18,'UMERO','É um osso','Localizado em uma das extremidades','Localizado na extremidade superior');
							INSERT INTO `quebra_ossos_perguntas` VALUES (19,'ULNA','É um osso','Localizado em uma das extremidades','Localizado na extremidade superior');
							INSERT INTO `quebra_ossos_perguntas` VALUES (20,'RADIO','É um osso','Localizado em uma das extremidades','Localizado na extremidade superior');
							INSERT INTO `quebra_ossos_perguntas` VALUES (21,'METACARPAIS','É um osso','Localizado em uma das extremidades','Localizado na extremidade superior');
							INSERT INTO `quebra_ossos_perguntas` VALUES (22,'ESCAFOIDE','É um osso','Localizado na extremidade superior','É um osso do carpo');
							INSERT INTO `quebra_ossos_perguntas` VALUES (23,'SEMILUNAR','É um osso','Localizado na extremidade superior','É um osso do carpo');
							INSERT INTO `quebra_ossos_perguntas` VALUES (24,'PIRAMIDAL','É um osso','Localizado na extremidade superior','É um osso do carpo');
							INSERT INTO `quebra_ossos_perguntas` VALUES (25,'PISIFORME','É um osso','Localizado na extremidade superior','É um osso do carpo');
							INSERT INTO `quebra_ossos_perguntas` VALUES (26,'TRAPEZIO','É um osso','Localizado na extremidade superior','É um osso do carpo');
							INSERT INTO `quebra_ossos_perguntas` VALUES (27,'TRAPEZOIDE','É um osso','Localizado na extremidade superior','É um osso do carpo');
							INSERT INTO `quebra_ossos_perguntas` VALUES (28,'CAPITATO','É um osso','Localizado na extremidade superior','É um osso do carpo');
							INSERT INTO `quebra_ossos_perguntas` VALUES (29,'HAMATO','É um osso','Localizado na extremidade superior','É um osso do carpo');
							INSERT INTO `quebra_ossos_perguntas` VALUES (30,'FALANGES','É um osso','Localizado em uma das extremidades','Localizado na extremidade superior');
							INSERT INTO `quebra_ossos_perguntas` VALUES (31,'MARTELO','É um osso','É um osso pequeno','É um ossículo');
							INSERT INTO `quebra_ossos_perguntas` VALUES (32,'BIGORNA','É um osso','É um osso pequeno','É um ossículo');
							INSERT INTO `quebra_ossos_perguntas` VALUES (33,'ESTRIBO','É um osso','É um osso pequeno','É um ossículo');]]
    	db:exec( tablefill )
    end
end