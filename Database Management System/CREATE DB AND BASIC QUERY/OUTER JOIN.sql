--Sử dụng database
USE CC00770xFBNetwork
GO

--Lấy ra người dùng (gồm tên và email) và toàn bộ thông tin bài đăng, sắp xếp theo ID người dùng
SELECT Name, Email, POST.*
FROM 
FBUSER FULL OUTER JOIN POST
ON FBUSER.UserID = POST.UserID
ORDER BY FBUSER.UserID
GO
