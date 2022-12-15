/* ANÁLISE VARIÁVEL DE DATA DA BASE CADASTRO DE PRODUTO */

LIBNAME ALURA "/home/u62784676/MyFolders/AluraPlay";

PROC FREQ
	DATA = ALURA.CADASTRO_PRODUTO_V2;
	TABLE DATA;
RUN;

/* FILTRANDO INFORMAÇÕES ESPECIFICAS */
/* IS MISSING = VALORES NUMÉRICOS NÃO PREENCHIDOS */
DATA TESTE1;
SET ALURA.CADASTRO_PRODUTO_V2;
WHERE DATA IS MISSING;
RUN;

/* FILTRANDO */
DATA TESTE2;
SET ALURA.CADASTRO_PRODUTO_V2;
WHERE NOME = "Soccer" OR NOME = "Forgotten Echo" OR NOME = "Fireshock";
RUN;

DATA TESTE2;
SET ALURA.CADASTRO_PRODUTO_V2;
WHERE NOME IN ("Soccer", "Forgotten Echo", "Fireshock");
RUN;

PROC FREQ
	DATA = TESTE2;
	TABLE NOME*DATA
	/LIST MISSING;
RUN;

/* FAZENDO O FILTRO EM CIMA DA PRÓPRIA BASE (SEM BASE INTERMEDIARIA)*/
PROC FREQ
	DATA = ALURA.CADASTRO_PRODUTO_V2
		(WHERE = (NOME IN ("Soccer", "Forgotten Echo", "Fireshock")));
		TABLE NOME*DATA
	/LIST MISSING;
RUN;

/* PREENCHENDO OS VALORES MISSING */
/* FORMA 1 */
DATA TESTE2;
SET ALURA.CADASTRO_PRODUTO_V2;

IF DATA = . AND NOME = "Fireshock" 		THEN = 201706; ELSE
IF DATA = . AND NOME = "Forgotten Echo" THEN = 201411; ELSE
IF DATA = . AND NOME = "Soccer" 		THEN = 201709;

RUN;

/* FORMA 2*/
/* THEN DO (ENTÃO FAÇA)*/
DATA TESTE2;
SET ALURA.cadastro_produto_v2;

IF DATA = . THEN DO;
	IF NOME = "Fireshock" 		THEN DATA = 201706; ELSE
	IF NOME = "Forgotten Echo" 	THEN DATA = 201411; ELSE
	IF NOME = "Soccer" 			THEN DATA = 201709;
END;

RUN;

/* OTHERWISE - CASO CONTRÁRIO */
DATA TESTE2;
SET ALURA.CADASTRO_PRODUTO_V2;

IF DATA = . THEN DO;
	SELECT(NOME);
		WHEN ("Fireshock") 		DATA = 201706;
		WHEN ("Forgotten Echo") DATA = 201411;
		WHEN ("Soccer") 		DATA = 201709;
		OTHERWISE;
	END;
END;
RUN;

PROC FREQ
	DATA = TESTE2
		(WHERE = (NOME IN ("Soccer", "Forgotten Echo", "Fireshock")));
		TABLE NOME*DATA
	/LIST MISSING;
RUN;


/ *AJUSTANDO A FLAG DE LANÇAMENTO */
DATA ALURA.CADASTRO_PRODUTO_V3;
SET TESTE2;

IF DATA > 201606
	THEN FLAG_LANCAMENTO = 1;
	ELSE FLAG_LANCAMENTO = 0;
	
LABEL FLAG_LANCAMENTO = "MARCA 1 PARA JOGOS QUE SÃO LANÇAMENTO E 0 CASO CONTRÁRIO";

RUN;

PROC FREQ
	DATA = ALURA.CADASTRO_PRODUTO_V3
		(WHERE = (NOME IN ("Soccer", "Forgotten Echo", "Fireshock")));
		TABLE NOME*DATA
	/LIST MISSING;
RUN;

/*COMPARANDO AS FLAGS DE LANÇAMENTO DA BASE 2 E 3*/
PROC FREQ
	DATA = ALURA.CADASTRO_PRODUTO_V2;
	TABLE FLAG_LANCAMENTO;
RUN;
	
PROC FREQ
	DATA = ALURA.CADASTRO_PRODUTO_V3;
	TABLE FLAG_LANCAMENTO;
RUN;
	
