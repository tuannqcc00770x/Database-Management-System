--Su dung database
USE CC00770xFBNetwork
GO

--Truy van su dung ca AND, OR, LIKE
--Tim ra nhung nguoi co trinh do dai hoc va lam viec tai FUNIX hoac APTECH tu bang nguoi dung
SELECT * FROM FBUSER
WHERE 
Education LIKE 'University degree'
AND (Workplace LIKE 'FUNIX' OR Workplace LIKE 'APTECH')
GO
