SELECT firstname, lastname, total_quantity
FROM (SELECT buyerid, sum(qtysold) total_quantity
    FROM demo_spectrum_schema. sales
    GROUP BY buyerid
    ORDER BY total_quantity desc limit 10) Q, users
WHERE Q. buyerid = userid
ORDER BY Q. total_quantity desc;