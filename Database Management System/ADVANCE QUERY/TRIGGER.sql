-- Chọn Database
USE CC00770xFBNetwork
GO

/*
Trigger được tạo nhằm mục đích kiểm tra tính đúng đắn khi thao tác thêm, xóa, sửa comment
Nguyên tắc thêm, sửa:
+Với một comment có cột ReplyID là null thì đó là comment cấp trực tiếp hiển thị trên Post. Mặc định không cần kiểm tra
vì lúc insert nếu id của post hoặc user không tồn tại sẽ báo lỗi
+Với một comment có cột ReplyID khác null thì đó là comment cấp thấp hơn trả lời cho comment khác, cần phải thỏa mãn điều kiện
là chỉ trả lời cho comment cấp đầu tiên, và phải hiển thị trên cùng một post

Nguyên tắc xóa:
+ Bắt buộc xóa tất cả các liên kết liên quan đến comment đó
+ Khi xóa comment cấp đầu tiên thì phải xóa luôn các comment trả lời cho nó
+ Khi xóa comment cấp thấp hơn trả lời cho comment khác, chỉ cần xóa mình nó là đủ

Do bài tập chỉ yêu cầu tạo và test một trigger thôi nên em chỉ xây dựng trigger khi thêm comment
*/

CREATE TRIGGER NewComment
ON COMMENT
AFTER INSERT, UPDATE
AS
BEGIN
	IF  EXISTS (
		SELECT *
		FROM COMMENT INNER JOIN inserted ON COMMENT.CommentID = inserted.ReplyID
		WHERE COMMENT.ReplyID IS NOT NULL
		) --Kiểm tra xem comment được trả lời có phải là cấp trả lời không
	BEGIN
		RAISERROR('ReplyID không hợp lệ', 16, 1) --bật thông báo lỗi
		ROLLBACK TRANSACTION  -- hủy bỏ transaction
	END
	
	ELSE IF  NOT EXISTS (
		SELECT *
		FROM COMMENT INNER JOIN inserted ON COMMENT.CommentID = inserted.ReplyID
		WHERE (COMMENT.PostID = inserted.PostID)
		) --kiểm tra xem id của post có giống nhau hay không
		AND NOT EXISTS ( SELECT * FROM inserted WHERE inserted.ReplyID IS NULL)--Kiểm tra cấp comment
	BEGIN
		RAISERROR('PostID không hợp lệ', 16, 1) --bật thông báo lỗi
		ROLLBACK TRANSACTION  -- hủy bỏ transaction
	END
END
GO
--Sau khi chạy 2 file DDL và DML thì có bảng COMMENT như sau:
/*
CommentID	CommentContent					CommentTime					ReplyID		UserID	PostID
1			Vote một phiếu đi Phú Quốc		2019-04-23 18:04:00.000		NULL		5		6
2			Hẹn hò nhậu nhẹt ở đó đê! hehe	2019-04-23 18:05:00.000		1			6		6
3			Chán thì đi chơi cho đỡ chán	2019-04-23 17:02:00.000		NULL		3		1
*/

--Test Case 1: Chèn một comment cấp đầu tiên vào một post (mặc định luôn chèn được)
INSERT COMMENT (UserID, PostID, CommentContent, CommentTime)
VALUES (6, 6, N'TC1', '2019-04-23 18:05:00')

--Chạy xong test case 1 thì bảng COMMENT như sau:
/*
CommentID	CommentContent					CommentTime					ReplyID		UserID	PostID
1			Vote một phiếu đi Phú Quốc		2019-04-23 18:04:00.000		NULL		5		6
2			Hẹn hò nhậu nhẹt ở đó đê! hehe	2019-04-23 18:05:00.000		1			6		6
3			Chán thì đi chơi cho đỡ chán	2019-04-23 17:02:00.000		NULL		3		1
4			TC1	2019-04-23					18:05:00.000				NULL		6		6
*/

--Test Case 2: Chèn một comment trả lời comment vừa tạo (id = 4) với PostID trùng khớp (thành công)
INSERT COMMENT (UserID, PostID, CommentContent, CommentTime, ReplyID)
VALUES (5, 6, N'TC2', '2019-04-23 18:05:00', 4)

--Chạy xong test case 2 thì bảng COMMENT như sau:
/*
CommentID	CommentContent						CommentTime					ReplyID		UserID	PostID
1			Vote một phiếu đi Phú Quốc			2019-04-23 18:04:00.000		NULL		5		6
2			Hẹn hò nhậu nhẹt ở đó đê! hehe		2019-04-23 18:05:00.000		1			6		6
3			Chán thì đi chơi cho đỡ chán		2019-04-23 17:02:00.000		NULL		3		1
4			TC1									2019-04-23 18:05:00.000		NULL		6		6
5			TC2									2019-04-23 18:05:00.000		4			5		6
*/

--Test Case 3: Chèn một comment cấp trả lời để trả lời cho một comment cấp trả lời khác (id = 5) (thất bại)
INSERT COMMENT (UserID, PostID, CommentContent, CommentTime, ReplyID)
VALUES (5, 6, N'TC3', '2019-04-23 18:05:00', 5)

--Test Case 4: Chèn một comment cấp trả lời (cho comment có id = 4) với PostID không trùng khớp (thất bại)
INSERT COMMENT (UserID, PostID, CommentContent, CommentTime, ReplyID)
VALUES (5, 1, N'TC2', '2019-04-23 18:05:00', 4)

--DROP TRIGGER NewComment

