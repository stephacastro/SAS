LIBNAME ALURA "/home/u62784676/MyFolders/AluraPlay";

DATA DESAFIO;
SET ALURA.CADASTRO_PRODUTO_V3;

IF DATA > 201606 THEN DO;
	IDENTIFICADOR_IDADE = "LANÇAMENTO";
	PRECO_AJUSTADO = PRECO - 10;
END;

	ELSE IF DATA < 201401 THEN DO;
		IDENTIFICADOR_IDADE = "ANTIGO";
		PRECO_AJUSTADO = PRECO*1.1;
	END;
	
		ELSE DO;
			IDENTIFICADOR_IDADE = "OUTRO";
			PRECO_AJUSTADO = PRECO;
		END;
		
RUN;