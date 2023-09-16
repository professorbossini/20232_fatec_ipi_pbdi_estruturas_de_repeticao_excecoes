-- IF/EXIST
DO $$
DECLARE
	contador INT := 1;
BEGIN
	LOOP
		RAISE NOTICE 'Contador: %', contador;
		contador := contador + 1;
		IF contador > 10 THEN
			EXIT;
		END IF;
	END LOOP;
END;
$$


-- DO $$
-- BEGIN
-- 	LOOP
-- 		RAISE NOTICE 'Loop infinito...';
-- 	END LOOP;
-- END;
-- $$