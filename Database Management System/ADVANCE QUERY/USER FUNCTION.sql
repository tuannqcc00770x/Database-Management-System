--Chọn data base
USE CC00770xFBNetwork
GO

/*Function dùng để tính số lượt thích của một Post.
Việc tính số likes của Post là cần thiết và thường xuyên được sử dụng để hiển thị trên news feed
*/

CREATE FUNCTION GetLikePost (@PostID INT)
RETURNS INT
AS
BEGIN
	DECLARE @NumLike INT = 0
	SELECT @NumLike = COUNT (LIKE_POST.PostID)
			--Dùng LEFT JOIN để lấy được tất cả POST bất kể có được like hay không
			 FROM POST LEFT JOIN LIKE_POST ON POST.PostID = LIKE_POST.PostID
			 GROUP BY POST.PostID
			 HAVING POST.PostID = @PostID 
	RETURN @NumLike
END
GO



--Test case

/*Đầu tiên xem thông tin từ bảng LIKE_POST trước để dự đoán kết quả
UserID	PostID
	1		3
	1		5
	2		5

Với PostID = 5 kết quả sẽ là 2
Với PostID = 3 kết quả sẽ là 1
*/
SELECT dbo.GetLikePost (5) -->Kết quả là 2
SELECT dbo.GetLikePost (3) -->Kết quả là 1

--Test thử id post không có trong bảng POST
SELECT dbo.GetLikePost (11) -->Kết quả là 0

--Test thử id post có trong bảng POST nhưng số likes là 0
SELECT dbo.GetLikePost (6) -->Kết quả là 0

--DROP FUNCTION GetLikePost