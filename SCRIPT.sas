/* CRIANDO UM DIRETÓRIO/BIBLIOTECA */
LIBNAME ALURA "/home/u62784676/MyFolders/AluraPlay";

/* LISTAS BASES DENTRO DE UMA PASTA - SE ESTA RECONHECENDO AS BASES */
PROC DATASETS
	LIB=ALURA DETAILS;
RUN;

/* CONTEUDO DE UMA BASE ESPECIFICA */
PROC CONTENTS
	DATA = ALURA.CADASTRO_PRODUTO;
RUN;

PROC CONTENTS
	DATA = ALURA.CADASTRO_CLIENTE;
RUN;

/* IMPRIMINDO A BASE */
PROC PRINT
	DATA = ALURA.CADASTRO_PRODUTO;
RUN;

PROC PRINT
	DATA = ALURA.CADASTRO_CLIENTE;
RUN;
