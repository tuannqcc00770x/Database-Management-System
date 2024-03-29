--Sử dụng database
USE CC00770xFBNetwork
GO

--Chọn ra những cặp có chỉ số tương thích (tính năng hẹn hò) lớn hơn trung bình của tất cả các cặp được liệt kê trong bảng

--Tạo bảng tạm #TMP2 để lấy thông tin
SELECT *
INTO #TMP2
FROM SUITABLE
WHERE SuitablePercent > (SELECT AVG(SuitablePercent) FROM SUITABLE)
GO

--Tạo khóa ngoại để tham chiếu từ #TMP2 đến user
ALTER TABLE #TMP2
ADD CONSTRAINT TMPID21 FOREIGN KEY (UserID) REFERENCES FBUser(UserID)
ALTER TABLE #TMP2
ADD CONSTRAINT TMPID22 FOREIGN KEY (SUserID) REFERENCES FBUser(UserID)
GO

--Lấy thông tin theo dự định đã cú thích ở đầu file
SELECT Name, SuitablePercent, (SELECT Name FROM FBUSER WHERE #TMP2.SUserID = FBUSER.UserID)AS SuitablePerson
FROM FBUSER INNER JOIN #TMP2
ON FBUSER.UserID = #TMP2.UserID
GO

--DROP TABLE #TMP2 
--GO
