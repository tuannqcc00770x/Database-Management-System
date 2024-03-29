-- Chọn data base
USE CC00770xFBNetwork
GO

/*
 Procedure này dùng hiển thị kết quả tìm post theo từ khóa nhập vào
 và hiển thị thông tin gồm User, Content, Post Time, Number Of Likes, Number Of Comments
*/
CREATE PROCEDURE searchPostByKey @searchKey NVARCHAR(max) = '' 
AS
--Lấy những thông tin cần thiết, ISNULL dùng để thay thế các giá trị null
SELECT Name AS  'User', PostContent AS 'Content', PostTime AS 'Time', 
	   ISNULL (NumberOfComments, 0) AS 'Number Of Comments', ISNULL (NumberOfLikes, 0) AS 'Number Of Likes'
FROM (
POST

--Đếm số likes dựa và liên kết giữa bảng POST và bảng LIKE_POST 
INNER JOIN	(SELECT POST.PostID, COUNT (LIKE_POST.PostID) AS NumberOfLikes
			 FROM POST LEFT JOIN LIKE_POST ON POST.PostID = LIKE_POST.PostID
			 GROUP BY POST.PostID) AS SubLike 
			  
			 ON POST.PostID = SubLike.PostID
--Đếm số comments dựa và liên kết giữa bảng POST và bảng COMMENT			 
INNER JOIN	(SELECT 
			 POST.PostID, COUNT (COMMENT.PostID) AS NumberOfComments
			 FROM POST LEFT JOIN COMMENT ON POST.PostID = COMMENT.PostID
			 GROUP BY POST.PostID) AS SubComment
			  
			 ON POST.PostID = SubComment.PostID
			 
INNER JOIN FBUSER ON POST.UserID = FBUSER.UserID
) WHERE PostContent LIKE N'%' + @searchKey + '%' -- Từ khóa tìm kiếm đưa vào câu lệnh WHERE
GO

--Test Case1: Tìm kiếm bằng một từ cụ thể. So sánh kết quả bằng cách gọi Select top 1000 rows từ bảng POST và quan sát
EXEC searchPostByKey N'chán' 

--Test Case2: Tìm kiếm bằng ký tự. So sánh kết quả bằng cách gọi Select top 1000 rows từ bảng POST và quan sát
EXEC searchPostByKey N'c' 

--Test Case3: Tìm kiếm bằng ký tự trắng. So sánh kết quả bằng cách gọi Select top 1000 rows từ bảng POST và quan sát
EXEC searchPostByKey N' '

--Test Case4: Tìm kiếm bằng ký đặc biệt @. So sánh kết quả bằng cách gọi Select top 1000 rows từ bảng POST và quan sát
EXEC searchPostByKey N'@'

--Test Case4: Tìm kiếm bằng cụm từ cụ thể. So sánh kết quả bằng cách gọi Select top 1000 rows từ bảng POST và quan sát
EXEC searchPostByKey N'một ngày nghỉ'
