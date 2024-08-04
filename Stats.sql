-- UPI_stats-----------------------------------
USE upi_stats;
-- --------------------------------------------
-- Query 1
-- Sum of volume and value of UPI transactions

SELECT ROUND(SUM(Volume_in_lakh_sent),3) AS Volume_sent_lakh,
	   ROUND(SUM(Value_in_crores_sent),3) AS Value_sent_crores,
	   ROUND(SUM(Volume_in_lakh_recieved),3) AS Volume_recieved_lakh,
	   ROUND(SUM(Value_in_crores_recieved),3) AS Value_recieved_crores
FROM stats;

-- --------------------------------------------
-- Query 2
-- Difference between volume sent & volume recieved and value sent & value recieved

SELECT ROUND(SUM(Volume_in_lakh_sent)- SUM(Volume_in_lakh_recieved),3) AS volume_difference_lakhs,
	   ROUND(SUM(Value_in_crores_sent)- SUM(Value_in_crores_recieved),3) AS value_difference_crore
FROM stats;

-- --------------------------------------------
-- Query 3
-- Average value per transaction

SELECT ROUND(SUM(value_in_crores_sent)*100/SUM(Volume_in_lakh_sent),3) AS avg_sent_transaction_value,
       ROUND(SUM(value_in_crores_recieved)*100/SUM(Volume_in_lakh_recieved),3) AS avg_recieved_transactioN_value
FROM stats;

-- --------------------------------------------
-- Query 4
-- Top 20 entities according to volume sent and contribution

SELECT Serial_no,
	   Entity_name,
       Volume_in_lakh_sent,
	   ROUND(Volume_in_lakh_sent/(SELECT SUM(Volume_in_lakh_sent)
								  FROM stats)*100,3) AS contribution_percent
FROM stats
ORDER BY Volume_in_lakh_sent DESC
LIMIT 20;

-- --------------------------------------------
-- Query 5
-- Top 20 entities according to value sent and contribution

SELECT Serial_no,
	   Entity_name,
       Value_in_crores_sent,
	   ROUND(Value_in_crores_sent/(SELECT SUM(Value_in_crores_sent)
								  FROM stats)*100,3) AS contribution_percent
FROM stats
ORDER BY Value_in_crores_sent DESC
LIMIT 20;

-- --------------------------------------------
-- Query 6
-- Top 20 entities according to volume recieved and contribution

SELECT Serial_no,
	   Entity_name,
       volume_in_lakh_recieved,
	   ROUND(Volume_in_lakh_recieved/(SELECT SUM(Volume_in_lakh_recieved)
								      FROM stats)*100,3) AS contribution_percent
FROM stats
ORDER BY Volume_in_lakh_recieved DESC
LIMIT 20;

-- --------------------------------------------
-- Query 7
-- Top 20 entities according to value recieved and contribution

SELECT Serial_no,
	   Entity_name,
       value_in_crores_recieved,
	   ROUND(Value_in_crores_recieved/(SELECT SUM(Value_in_crores_recieved)
								       FROM stats)*100,3) AS contribution_percent
FROM stats
ORDER BY value_in_crores_recieved DESC
LIMIT 20;

-- --------------------------------------------
-- Query 8
-- Top 20 entities according highest to value per transaction (sent)

SELECT Serial_no,
	   Entity_name,
       ROUND(SUM(Value_in_crores_sent)*100/SUM(Volume_in_lakh_sent),3) AS avg_value_transaction
FROM stats
GROUP BY serial_no, entity_name
ORDER BY avg_value_transaction DESC
LIMIT 20;

-- --------------------------------------------
-- Query 9
-- Top 20 entities according to highest value per transaction (recieved)

SELECT Serial_no,
	   Entity_name,
       ROUND(SUM(Value_in_crores_recieved)*100/SUM(Volume_in_lakh_recieved),3) AS avg_value_transaction
FROM stats
GROUP BY serial_no, entity_name
ORDER BY avg_value_transaction DESC
LIMIT 20;

-- --------------------------------------------
-- Query 10
-- entities with less than 1000 UPI transactions (inclduing both sent and recieved)

SELECT Serial_no,
	   Entity_name
FROM stats
WHERE volume_in_lakh_sent<0.01
AND Volume_in_lakh_recieved<0.01;

-- --------------------------------------------
-- Query 11
-- Non banking entities in this list

SELECT  Serial_no,
		Entity_name
FROM stats
WHERE entity_name NOT LIKE '%BANK%';

-- --------------------------------------------
-- Query 12
-- Selection of non banking entities by value_in_lakh_sent and contribution

SELECT  Serial_no,
		Entity_name,
        Volume_in_lakh_sent,
	    ROUND(Volume_in_lakh_sent/(SELECT SUM(Volume_in_lakh_sent)
								   FROM stats)*100,3) AS contribution_percent
FROM stats
WHERE entity_name NOT LIKE '%BANK%'
ORDER BY Volume_in_lakh_sent DESC;

-- --------------------------------------------
-- Query 13
-- Selection of non banking entities by value_in_crores_sent and contribution

SELECT  Serial_no,
		Entity_name,
        Value_in_crores_sent,
	    ROUND(Value_in_crores_sent/(SELECT SUM(Value_in_crores_sent)
								    FROM stats)*100,3) AS contribution_percent
FROM stats
WHERE entity_name NOT LIKE '%BANK%'
ORDER BY Value_in_crores_sent DESC;

-- --------------------------------------------
-- Query 14
-- Selection of non banking entities by volume_in_lakh_recieved and contribution

SELECT  Serial_no,
		Entity_name,
        volume_in_lakh_recieved,
		ROUND(Volume_in_lakh_recieved/(SELECT SUM(Volume_in_lakh_recieved)
									   FROM stats)*100,3) AS contribution_percent
FROM stats
WHERE entity_name NOT LIKE '%BANK%'
ORDER BY  volume_in_lakh_recieved DESC ;

-- --------------------------------------------
-- Query 15
-- Selection of non banking entities by value in crores recieved and contribution

SELECT  Serial_no,
		Entity_name,
        value_in_crores_recieved,
		ROUND(Value_in_crores_recieved/(SELECT SUM(Value_in_crores_recieved)
										FROM stats)*100,3) AS contribution_percent
FROM stats
WHERE entity_name NOT LIKE '%BANK%'
ORDER BY  value_in_crores_recieved DESC;

-- --------------------------------------------
-- Query 16
-- Selection of non banking entities according highest to value per transaction (sent)

SELECT  Serial_no,
		Entity_name,
        ROUND(SUM(Value_in_crores_sent)*100/SUM(Volume_in_lakh_sent),3) AS avg_value_transaction
FROM stats
WHERE entity_name NOT LIKE '%BANK%'
GROUP BY Serial_no, Entity_name
ORDER BY avg_value_transaction DESC;

-- --------------------------------------------
-- Query 17
-- Selection of non banking entities according highest to value per transaction (recieved)

SELECT  Serial_no,
		Entity_name,
        ROUND(SUM(Value_in_crores_recieved)*100/SUM(Volume_in_lakh_recieved),3) AS avg_value_transaction
FROM stats
WHERE entity_name NOT LIKE '%BANK%'
GROUP BY Serial_no, Entity_name
ORDER BY avg_value_transaction DESC;

-- --------------------------------------------
-- Query 18
-- Top 20  banks with positive net_difference (Value recieved- value sent)

SELECT Serial_no,
	   Entity_name,
       ROUND(value_in_crores_recieved-value_in_crores_sent,2) AS Net_difference
FROM stats
ORDER BY Net_difference DESC
LIMIT 20;

-- --------------------------------------------
-- Query 19
-- Top 20  banks with negative net_difference (Value recieved- value sent)

SELECT Serial_no,
	   Entity_name,
       ROUND(value_in_crores_recieved-value_in_crores_sent,2) AS Net_difference
FROM stats
ORDER BY Net_difference ASC
LIMIT 20;

-- --------------------------------------------
-- Query 20
-- Top 20  banks that handled most number of transactions and contribution

SELECT Serial_no,
	   Entity_name,
       ROUND(SUM(Volume_in_lakh_sent)+SUM(Volume_in_lakh_recieved),2) AS Overall_volume,
       ROUND((SUM(Volume_in_lakh_sent)+SUM(Volume_in_lakh_recieved))/(SELECT SUM(Volume_in_lakh_sent)+SUM(Volume_in_lakh_recieved)
																	FROM stats)*100,3) AS contribution_percent
FROM stats
GROUP BY Serial_no, entity_name
ORDER BY Overall_volume DESC
LIMIT 20;

-- --------------------------------------------
-- Query 20
-- Top 20  banks that according to value (of both sent and recieved)

SELECT Serial_no,
	   Entity_name,
       ROUND(SUM(Value_in_crores_sent)+SUM(Value_in_crores_recieved),2) AS Overall_value,
       ROUND((SUM(Value_in_crores_sent)+SUM(Value_in_crores_recieved))/(SELECT SUM(Value_in_crores_sent)+SUM(Value_in_crores_recieved)
																	FROM stats)*100,3) AS contribution_percent
FROM stats
GROUP BY Serial_no, entity_name
ORDER BY Overall_value DESC
LIMIT 20;

-- DONE-----------------------------------------------------------------











       
