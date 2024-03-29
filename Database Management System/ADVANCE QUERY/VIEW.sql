-- Chọn data base
USE CC00770xFBNetwork
GO

/*Em muốn tạo một View hiển thị người dùng, nội dung, thời gian đăng. View có ý nghĩa
chính là dữ liệu hiển thị news feed của facebook
*/

CREATE VIEW NEWSFEED
AS
SELECT Name AS  'User', PostContent AS 'Content', PostTime AS 'Time', 
	   ISNULL (NumberOfComments, 0) AS 'Number Of Comments', ISNULL (NumberOfLikes, 0) AS 'Number Of Likes'
FROM (
POST 
INNER JOIN	(SELECT POST.PostID, COUNT (LIKE_POST.PostID) AS NumberOfLikes
			 FROM POST LEFT JOIN LIKE_POST ON POST.PostID = LIKE_POST.PostID
			 GROUP BY POST.PostID) AS SubLike
			  
			 ON POST.PostID = SubLike.PostID
INNER JOIN	(SELECT 
			 POST.PostID, COUNT (COMMENT.PostID) AS NumberOfComments
			 FROM POST LEFT JOIN COMMENT ON POST.PostID = COMMENT.PostID
			 GROUP BY POST.PostID) AS SubComment
			  
			 ON POST.PostID = SubComment.PostID
			 
INNER JOIN FBUSER ON POST.UserID = FBUSER.UserID
)
GO
--Hiển thị View
SELECT *
FROM NEWSFEED
GO
--DROP VIEW NEWSFEED
