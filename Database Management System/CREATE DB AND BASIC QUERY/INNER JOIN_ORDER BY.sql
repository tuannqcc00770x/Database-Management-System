--Sử dụng database
USE CC00770xFBNetwork
GO

--Lấy ra họ tên, email người dùng và các tin nhắn đã gửi, người nhận tin nhắn. Sắp xếp theo id người dùng
SELECT Name, Email, MessageText, MessageTime, (SELECT Name FROM FBUSER WHERE SEND_MSG.ReceiverID = FBUSER.UserID)AS Receiver
FROM 
FBUSER INNER JOIN SEND_MSG
ON FBUSER.UserID = SEND_MSG.SenderID
ORDER BY UserID
GO
