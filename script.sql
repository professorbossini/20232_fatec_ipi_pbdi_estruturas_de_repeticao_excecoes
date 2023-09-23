DO $$
DECLARE
	a INT := valor_aleatorio_entre(0, 5);
BEGIN
	IF a = 0 THEN
		RAISE 'a não pode ser zero';
		RAISE NOTICE 'Vejamos se chega aqui...';
	ELSE
		RAISE NOTICE 'Valor de a: %', a;
	END IF;
EXCEPTION WHEN OTHERS THEN
	-- SQLState é o código da exceção
	-- SQLERRM é a mensagem (SQL Error Message)
	RAISE NOTICE 'SQLState: %, SQLERRM: %', SQLSTATE, SQLERRM;
END;
$$

-- DO $$
-- BEGIN
-- 	RAISE NOTICE '%', 1 / 0;
-- EXCEPTION
-- 	WHEN division_by_zero THEN
-- 		RAISE NOTICE 'Não é possível fazer divisão por zero';
-- END;
$$

--FOREACH usando slices (fatias)
-- DO $$
-- DECLARE
-- 	vetor INT[] := ARRAY[1, 2, 3];
-- 	matriz INT[] := ARRAY[
-- 		[1, 2, 3],
-- 		[4, 5, 6],
-- 		[7, 8, 9]
-- 	];
-- 	var_aux INT;
-- 	vet_aux INT[];
-- BEGIN
-- 	RAISE NOTICE 'slice igual a 0 sobre vetor';
-- 	FOREACH var_aux IN ARRAY vetor LOOP
-- 		RAISE NOTICE '%', var_aux;
-- 	END LOOP;
-- 	RAISE NOTICE '-------------------';
-- 	RAISE NOTICE 'Slice igual a 1 sobre vetor';
-- 	FOREACH vet_aux SLICE 1 IN ARRAY vetor LOOP
-- 		RAISE NOTICE '%', vet_aux;
-- 		FOREACH var_aux IN ARRAY vet_aux LOOP
-- 			RAISE NOTICE '%', var_aux;
-- 		END LOOP;
-- 	END LOOP;
-- 	RAISE NOTICE '-------------------';
-- 	RAISE NOTICE 'matriz, slice 0';
-- 	FOREACH var_aux IN ARRAY matriz LOOP
-- 		RAISE NOTICE '%', var_aux;
-- 	END LOOP;
-- 	RAISE NOTICE 'matriz, slice 1';
-- 	FOREACH vet_aux SLICE 1 IN ARRAY matriz LOOP
-- 		RAISE NOTICE '%', vet_aux;
-- 	END LOOP;
-- 	RAISE NOTICE 'matriz, slice 2';
-- 	FOREACH vet_aux SLICE 3 IN ARRAY matriz LOOP
-- 		RAISE NOTICE '%', vet_aux;
-- 	END LOOP;
-- END;
-- $$

--foreach, iterando sobre os elementos de um array
-- DO
-- $$
-- DECLARE
-- 	valores INT[] := ARRAY[
-- 		valor_aleatorio_entre(1, 10),
-- 		valor_aleatorio_entre(1, 10),
-- 		valor_aleatorio_entre(1, 10),
-- 		valor_aleatorio_entre(1, 10),
-- 		valor_aleatorio_entre(1, 10)		
-- 	];
-- 	valor INT;
-- 	soma INT := 0;
-- BEGIN
-- 	FOREACH valor IN ARRAY valores LOOP
-- 		RAISE NOTICE 'Valor da vez: %', valor;
-- 		soma := soma + valor;
-- 	END LOOP;
-- 	RAISE NOTICE 'Soma: %', soma;
-- END;
-- $$


-- DO $$
-- DECLARE
-- 	--RECORD: tipo para representar uma linha de uma linha
-- 	aluno RECORD;
-- 	media NUMERIC (10, 2) := 0;
-- 	total INT;
-- BEGIN
-- 	FOR aluno IN
-- 		SELECT * FROM tb_aluno	
-- 	LOOP
-- 		--. é o operador de acesso a membro
-- 		RAISE NOTICE 'Nota(%): %', aluno.cod_aluno, aluno.nota;
-- 	END LOOP;
-- END;
-- $$


-- SELECT * FROM tb_aluno;


-- DO $$
-- BEGIN
-- 	--gerando notas
-- 	FOR i IN 1..100 LOOP
-- 		INSERT INTO tb_aluno (nota) VALUES(valor_aleatorio_entre(0, 10));
-- 	END LOOP;
-- END;
-- $$


-- CREATE TABLE tb_aluno(
-- 	cod_aluno SERIAL PRIMARY KEY,
-- 	nota INT
-- );


-- DO $$
-- BEGIN
-- 	--de 1 a 10, pulando de um em um
-- 	FOR i IN 1..10 LOOP
-- 		RAISE NOTICE '%', i;
-- 	END LOOP;
	
-- 	FOR i IN 10..1 LOOP
-- 		RAISE NOTICE '%', i;
-- 	END LOOP;
	
-- 	FOR i IN REVERSE 10..1 LOOP
-- 		RAISE NOTICE '%', i;
-- 	END LOOP;
	
-- 	FOR i IN 1..50 BY 2 LOOP
-- 		RAISE NOTICE '%', i;
-- 	END LOOP;
-- END;
-- $$

-- DO $$
-- DECLARE
-- 	nota INT;
-- 	media NUMERIC (10, 2) := 0;
-- 	contador INT := 0;
-- BEGIN
-- 	--[-1, 10] -1 será nosso sentinela
-- 	SELECT valor_aleatorio_entre(0, 11) -1 INTO nota;
-- 	WHILE nota >= 0 LOOP
-- 		RAISE NOTICE '%', nota;
-- 		media := media + nota; --acumulador
-- 		contador := contador + 1;
-- 		SELECT valor_aleatorio_entre(0, 11) -1 INTO nota;
-- 	END LOOP;
-- 	IF contador > 0 THEN -- se tem pelo menos uma nota
-- 		RAISE NOTICE 'Média: %', media / contador;
-- 	ELSE
-- 		RAISE NOTICE 'Nenhuma nota gerada';
-- 	END IF;
-- END;
-- $$

-- DO $$
-- DECLARE 
-- 	i INT;
-- 	j INT;
-- BEGIN
-- 	i := 0;
-- 	-- esse é um rótulo
-- 	<<externo>>
-- 	LOOP
-- 		i := i + 1;
-- 		EXIT WHEN i > 10;
-- 		j := 1;
-- 		<<interno>>
-- 		LOOP
-- 			RAISE NOTICE '%, %', i, j;
-- 			j := j + 1;
-- 			EXIT WHEN j > 5;
-- 			EXIT externo WHEN j > 5;
-- 		END LOOP;
-- 	END LOOP;
-- END;
-- $$
--1 6 N
--1 5 S
--1 4 S
--1 3 S
--1 2 S
--1 1 S
--0 1, 0 2 N


-- CONTINUE
-- DO $$
-- DECLARE
-- 	contador INT := 0;
-- BEGIN
-- 	LOOP
-- 		contador := contador + 1;
-- 		EXIT WHEN contador > 100;
-- 		-- ignorando as iterações em que contador é múltiplo de 7
-- 		IF contador % 7 = 0 THEN
-- 			CONTINUE;
-- 		END IF;
-- 		CONTINUE WHEN contador % 11 = 0;
-- 		RAISE NOTICE '%', contador;
-- 	END LOOP;
-- END;
-- $$
-- EXIT WHEN
-- DO $$
-- DECLARE
-- 	contador INT := 1;
-- BEGIN
-- 	LOOP
-- 		RAISE NOTICE 'Contador: %', contador;
-- 		contador := contador + 1;
-- 		EXIT WHEN contador > 10;
-- 	END LOOP;
-- END;
-- $$

-- IF/EXIT
-- DO $$
-- DECLARE
-- 	contador INT := 1;
-- BEGIN
-- 	LOOP
-- 		RAISE NOTICE 'Contador: %', contador;
-- 		contador := contador + 1;
-- 		IF contador > 10 THEN
-- 			EXIT;
-- 		END IF;
-- 	END LOOP;
-- END;
-- $$


-- DO $$
-- BEGIN
-- 	LOOP
-- 		RAISE NOTICE 'Loop infinito...';
-- 	END LOOP;
-- END;
-- $$