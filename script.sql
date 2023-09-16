-- CONTINUE
DO $$
DECLARE
	contador INT := 0;
BEGIN
	LOOP
		contador := contador + 1;
		EXIT WHEN contador > 100;
		-- ignorando as iterações em que contador é múltiplo de 7
		IF contador % 7 = 0 THEN
			CONTINUE;
		END IF;
		CONTINUE WHEN contador % 11 = 0;
		RAISE NOTICE '%', contador;
	END LOOP;
END;
$$
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