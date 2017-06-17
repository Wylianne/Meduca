function verificaBD()

	local sqlite3 = require( "sqlite3" )
	local path = system.pathForFile( "meduca.db", system.DocumentsDirectory )
	local db = sqlite3.open( path ) 

	local tablesetup = [[CREATE TABLE IF NOT EXISTS quebra_ossos (id INTEGER PRIMARY KEY, num_pontos);]]
	db:exec( tablesetup )

	local tablesetup = [[CREATE TABLE IF NOT EXISTS quebra_ossos_perguntas (id INTEGER PRIMARY KEY, palavra, dica1, dica2, dica3);]]
	db:exec( tablesetup )

	local tablesetup = [[CREATE TABLE IF NOT EXISTS quiz_perguntas (id INTEGER PRIMARY KEY, pergunta, alter_1, alter_2, alter_3, alter_4, alter_5, resposta);]]
	db:exec( tablesetup )	

	local tablesetup = [[CREATE TABLE IF NOT EXISTS `fases` (`id` INTEGER NOT NULL, `nome_jogo`	TEXT NOT NULL, `qnt_fases`	INTEGER NOT NULL, `qnt_fases_d`	INTEGER NOT NULL, PRIMARY KEY(`id`);]]
	db:exec( tablesetup )
	
	local tablefill = [[INSERT INTO `fases` VALUES (1,'somaOssos',3,1);]]
   	db:exec( tablefill )


	for row in db:nrows("SELECT count(*) as count FROM quebra_ossos_perguntas") do
        id_pergunta = tonumber(row.count)
    end

    if (id_pergunta == 0) then
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

    for row in db:nrows("SELECT count(*) as count FROM quiz_perguntas") do
        id_pergunta = tonumber(row.count)
    end

    if (id_pergunta == 0) then
    	local tablefill = [[INSERT INTO `quiz_perguntas` VALUES (1,'Quantos ossos constituem o esqueleto humano da maioria dos adultos?','306 ossos','206 ossos','236 ossos','286 ossos','216 ossos','206 ossos');
							INSERT INTO `quiz_perguntas` VALUES (2,'Quanto as formas dos ossos do corpo humano, podemos classifica-los como:','Longos, chatos, epiáfise e irregulares','Longos, chatos, curtos e irregulares','Periósteo, longos e curtos','Epífese e Diáfise','Longos, chatos, diáfise e irregulares','Longos, chatos, curtos e irregulares');
							INSERT INTO `quiz_perguntas` VALUES (3,'A afirmativa : "Membrana fina que reveste o osso. Apresenta muitos vasos sanguíneos". Se relaciona com:','O Canal Medular','A Diáfise','A Epífise','O Periósteo','A Osteoporose','A Epífise');
							INSERT INTO `quiz_perguntas` VALUES (4,'A parte do esqueleto na qual os ossos se encontram chama-se:','Articulação','Coluna vertebral','Caixa Torácica','Canal Medular','Medúla Espinhal','Articulação');
							INSERT INTO `quiz_perguntas` VALUES (5,'Os ossos da cabeça são divididos em quantas partes?','2','3','4','5','6','2');
							INSERT INTO `quiz_perguntas` VALUES (6,'É composto por doze pares de ossos em formas de arco. Esses ossos denominados costelas. Estamos falando da(o):','Crânio','Articulação','Caixa Torácica','Sistema Locomotor','Mão','Caixa Torácica');
							INSERT INTO `quiz_perguntas` VALUES (7,'Quando a coluna apresenta curvatura acentuada voltada para fora, a deformação recebe o nome de:','Artrose','Artrite','Cifose','Lordose','Morfose','Cifose');
							INSERT INTO `quiz_perguntas` VALUES (8,'O que é o esqueleto?','Conjunto de músculos','É o crânio','Um conjunto de ossos','Nome de um planeta','Um conjunto de ligamentos','Um conjunto de ossos');
							INSERT INTO `quiz_perguntas` VALUES (9,'Quais são as funções do esqueleto?','O esqueleto serve para enfeitar o corpo','Suportar o corpo e proteger alguns órgãos','Serve para suportar o corpo','O esqueleto serve para proteger os músculos','Serve para segurar o crânio','Suportar o corpo e proteger alguns órgãos');
							INSERT INTO `quiz_perguntas` VALUES (10,'Em quantas partes se divide o esqueleto?','2','3','4','5','6','3');
							INSERT INTO `quiz_perguntas` VALUES (11,'O corpo humano divide-se em três partes:','Cabeça, Tronco e Músculos','Tronco, Membros e Coração','Cabeça, Membros e Crânio','Cabeça, tronco e membros','Cabeça, tronco e coração','Cabeça, tronco e membros');
							INSERT INTO `quiz_perguntas` VALUES (12,'Qual desses ossos não é considerado osso do carpo?','Trapezóide','Semilunar','Capitato','Cubóide','Escafóide','Cubóide');
							INSERT INTO `quiz_perguntas` VALUES (13,'Quais destes ossos fazem parte do esqueleto do tronco?','Vértebras, coluna vertebral, costelas, occipital e clavícula','Vértebras, tíbia, costelas, esterno e clavícula','Vértebras, coluna vertebral, costelas, esterno e clavícula','Bacia, rádio, coluna vertebral, costelas, esterno e clavícula','Vértebras, coluna vertebral, occipital, esterno, clavícula','Vértebras, coluna vertebral, costelas, esterno e clavícula');
							INSERT INTO `quiz_perguntas` VALUES (14,'Quais os nomes dos ossos que fazem parte do esqueleto dos membros inferiores?','Fémur, rádio, perónio e rótula','Fémur, tíbia, perónio e bacia','Fémur, tíbia, cúbito e rótula','Fémur, tíbia, perónio e rótula','Fémur, tíbia, perónio e cúbito','Fémur, tíbia, perónio e rótula');
							INSERT INTO `quiz_perguntas` VALUES (15,'Quais os ossos que fazem parte do pé?','Tarso, metatarso e falanges','Carpo, metacarpo e falanges','Carpo, tarso e falanges','Carpo, metacarpo e falanges','Carpo e falanges','Tarso, metatarso e falanges');
							INSERT INTO `quiz_perguntas` VALUES (16,'Quais os nomes dos ossos que fazem parte do esqueleto dos membros superiores?','Fémur, carpo e cúbito','Fémur, úmero e cúbito','Rádio, Carpo e fémur','Úmero, fémur e rádio','Úmero, cúbito e rádio','Úmero, cúbito e rádio');
							INSERT INTO `quiz_perguntas` VALUES (17,'Quais os nomes dos ossos da mão?','Tarso, metatarso e falanges','Tarso, metatarso e falanges','Carpo, metacarpo e falanges','Carpo e falanges','Tarso e falanges','Carpo, metacarpo e falanges');
							INSERT INTO `quiz_perguntas` VALUES (18,'O crânio protege um órgão importante. Qual?','O coração','O cérebro','O fígado','O pulmão','O intestino','O cérebro');
							INSERT INTO `quiz_perguntas` VALUES (19,'As costelas e o esterno protegem dois órgãos importantes. Quais?','Os pulmões e a pele','Os pulmões e o estômago','O coração e o fígado','O coração e os pulmões','O coração e o intestino','O coração e os pulmões');
							INSERT INTO `quiz_perguntas` VALUES (20,'Qual é o maior osso do nosso corpo?','O estribo','O fémur','A tíbia','A bacia','A clavícula','O fémur');
							INSERT INTO `quiz_perguntas` VALUES (21,'Qual o menor osso do nosso corpo?','Estribo','Fémur','Malar','Patela','Úmero','Estribo');
							INSERT INTO `quiz_perguntas` VALUES (22,'Como se chama o principal osso do joelho?','Fémur','Tíbia','Rótula','Úmero','Malar','Rótula');
							INSERT INTO `quiz_perguntas` VALUES (23,'Qual é o nome da ligação de dois ou mais ossos?','Tendão','Articulação','Músculos','Músculos','Vasos','Articulação');
							INSERT INTO `quiz_perguntas` VALUES (24,'Qual é o nome dado a lesão de um osso?','Músculo','Tendão','Cãibra','Fratura','Ílio','Fratura');
							INSERT INTO `quiz_perguntas` VALUES (25,'São considerados ossos do esqueleto apendicular:','Fêmur, ílio e ísquio','Fêmur, ísquio e púbis','ílio, ísquio e púbis','Todas as alternativas estão corretas','
							Nenhuma das alternativas estão corretas','Todas as alternativas estão corretas');
							INSERT INTO `quiz_perguntas` VALUES (26,'Qual das seguintes estruturas não se articula com o osso esterno?','Primeiro par de costelas','Oitavo par de costelas','Nono par de costelas','Décimo par de costelas','Décimo primeiro par de costelas','Décimo par de costelas');
							INSERT INTO `quiz_perguntas` VALUES (27,'São consideradas costelas falsas:','Quinto, sexto e sétimo par','Sexto, sétimo e oitavo par','Sétimo, oitavo e nono par','Oitavo, nono e décimo par','Nono, décimo e décimo primeiro par','Oitavo, nono e décimo par');
							INSERT INTO `quiz_perguntas` VALUES (28,'Qual dessa afirmações é falsa?','O corpo humano possuem 206 ossos nomeados','A patela é considerada tanto um osso curto quanto sesamóide','Caixa torácica é composta por coluna vertebral, costelas e esterno','O fêmur é considerado o maior osso do corpo humano','A clavícula e a escapula fazem parte da cintura escapular','Caixa torácica é composta por coluna vertebral, costelas e esterno');
							INSERT INTO `quiz_perguntas` VALUES (29,'Qual dessas medulas ósseas não se localiza nas epífises dos ossos longos?','Eritrócitos','Leoucócitos','Flava','Megacariocitos','Todas as alternativas estão corretas','Flava');
							INSERT INTO `quiz_perguntas` VALUES (30,'De que célula se constitui a medula óssea amarela?','Eucarióticas','Adiposas','Procariontes','Citoplasma','Nenhuma das alternativas estão corretas','Adiposas');]]
    	db:exec( tablefill )
    end
end