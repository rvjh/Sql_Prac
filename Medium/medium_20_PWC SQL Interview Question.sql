select * from source;
select * from target;


SELECT 
    COALESCE(s.id, t.id) AS id, 
    s.name AS source_name, 
    t.name AS target_name,
    CASE 
        WHEN t.name IS NULL THEN 'new in source'
        WHEN s.name IS NULL THEN 'new in target'
        ELSE 'mismatch'
    END AS comment
FROM 
    source s
LEFT JOIN 
    target t ON s.id = t.id
WHERE 
    s.name != t.name OR s.name IS NULL OR t.name IS NULL

UNION 

SELECT 
    COALESCE(s.id, t.id) AS id, 
    s.name AS source_name, 
    t.name AS target_name,
    CASE 
        WHEN t.name IS NULL THEN 'new in source'
        WHEN s.name IS NULL THEN 'new in target'
        ELSE 'mismatch'
    END AS comment
FROM 
    source s
RIGHT JOIN 
    target t ON s.id = t.id
WHERE 
    s.name != t.name OR s.name IS NULL OR t.name IS NULL;