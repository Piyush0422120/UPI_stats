# UPI_stats
Objective: Analysing UPI Transactions for the month of June 2024  

Total number of Queries: 21

![image](https://github.com/user-attachments/assets/ea73dc37-a749-4d30-8b85-4a06c463f29d)

--- 

## SNAPSHOTS  


#1 Sum of volume and value of UPI transactions
```
-- Query 1
-- Sum of volume and value of UPI transactions

  SELECT ROUND(SUM(Volume_in_lakh_sent),3) AS Volume_sent_lakh,
	       ROUND(SUM(Value_in_crores_sent),3) AS Value_sent_crores,
	       ROUND(SUM(Volume_in_lakh_recieved),3) AS Volume_recieved_lakh,
	       ROUND(SUM(Value_in_crores_recieved),3) AS Value_recieved_crores
  FROM stats;
```

![image](https://github.com/user-attachments/assets/cce6b725-bbfd-4c66-afe5-ec7ebb1e3a6f) 

  
#2 Top 20 entities according to volume sent and contribution
```
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
```

![image](https://github.com/user-attachments/assets/9a25ad79-022f-42d6-8f1a-e6b450681110)  

#3 Top 20 entities according to value sent and contribution
```
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
```

![image](https://github.com/user-attachments/assets/c55dca74-dcfc-4af2-9cf5-1fdb005079d6)  

#4 Top 20 entities according to highest value per transaction (recieved)  

```
-- Query 9
-- Top 20 entities according to highest value per transaction (recieved)

SELECT Serial_no,
       Entity_name,
       ROUND(SUM(Value_in_crores_recieved)*100/SUM(Volume_in_lakh_recieved),3) AS avg_value_transaction
FROM stats
GROUP BY serial_no, entity_name
ORDER BY avg_value_transaction DESC
LIMIT 20;
```

![image](https://github.com/user-attachments/assets/6c0320a0-6007-485a-8d3a-d34530a3f84e)  

#5 Selection of non banking entities by volume_in_lakh_recieved and contribution

```
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
```

![image](https://github.com/user-attachments/assets/3f789169-0153-4899-89e7-4d82f3d6702c)








