-- Pattern Matching
-- INSTR and SUBTSR
SELECT event_name,
	   CASE WHEN INSTR(event_name, ' ') = 0 THEN event_name
	   ELSE SUBSTR(event_name, 1, INSTR(event_name, ' ') - 1)
      -- INSTR(event_name, ' ')
       END AS first_word
FROM my_events;
