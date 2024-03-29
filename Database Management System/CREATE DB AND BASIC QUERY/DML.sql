--Sử dụng database
USE CC00770xFBNetwork
GO

--Bắt đầu chèn dữ liệu

--Bảng người dùng
INSERT FBUSER(Email, UPassword, Name, Avatar, Background, Sex, Birthday, UAddress, Workplace, MaritalStatus, Education)
VALUES ('tuanfunix@gmail.com', 'ghjke321', N'Nguyễn Quốc Tuấn', 'tuan.jpg', 'tuanb.jpg', 'Male', '1992-01-02', N'Long An', 'FUNIX', 'Single', 'University degree')

INSERT FBUSER(Email, UPassword, Name, Avatar, Background, Sex, Birthday, UAddress, Workplace, MaritalStatus, Education)
VALUES ('minhfunix@gmail.com', 'ghhjk219', N'Trần Công Lực', 'luc.jpg', 'lucb.jpg', 'Male', '1994-04-09', N'Bến Tre', 'APTECH', 'Married', 'University degree')

INSERT FBUSER(Email, UPassword, Name, Avatar, Background, Sex, Birthday, UAddress, Workplace, MaritalStatus, Education)
VALUES ('tuyenfunix@gmail.com', 'hkenjh23', N'Vũ Ngọc Tuyền', 'tuyen.jpg', 'tuyenb.jpg', 'Female', '1995-08-02', N'Tiền Giang', 'SaiGon Precision Co.Ltd', 'Single', 'University degree')

INSERT FBUSER(Email, UPassword, Name, Avatar, Background, Sex, Birthday, UAddress, Workplace, MaritalStatus, Education)
VALUES ('han1996@gmail.com', 'hhhhee', N'Dương Thúy Hân', 'han.jpg', 'hanb.jpg', 'Female', '1996-01-28', N'Bạc Liêu', 'ChingLuh Co.Ltd', 'Single', 'General Education')

INSERT FBUSER(Email, UPassword, Name, Avatar, Background, Sex, Birthday, UAddress, Workplace, MaritalStatus, Education)
VALUES ('hai0809@gmail.com', 'hai08091995', N'Bùi Ngọc Hải', 'hai.jpg', 'haib.jpg', 'Male', '1995-09-08', N'Tuyên Quang', 'Samsung Co.Ltd', 'Single', 'University degree')

INSERT FBUSER(Email, UPassword, Name, Avatar, Background, Sex, Birthday, UAddress, Workplace, MaritalStatus, Education)
VALUES ('quanpm@gmail.com', 'tonhu5859', N'Phạm Minh Quân', 'quan.jpg', 'quanb.jpg', 'Male', '1994-06-02', N'Long An', 'Toppro Steel', 'Single','University degree')

INSERT FBUSER(Email, UPassword, Name, Avatar, Background, Sex, Birthday, UAddress, Workplace, MaritalStatus, Education)
VALUES ('lychikhanh@gmail.com', '586214', N'Lý Chí Khánh', 'khanh.jpg', 'khanhb.jpg', 'Male', '1994-08-02', N'Long An', 'Toppro Steel', 'Single','University degree')

GO
										 
--Bảng bài đăng
INSERT POST(UserID, PostContent, PostTime, DisplayMode)
VALUES (1, N'Chán quá chán', '2019-04-23 17:02:00', 'Public')

INSERT POST(UserID, PostContent, PostTime, DisplayMode)
VALUES (1, N'Cần lắm một ngày nghỉ', '2019-04-23 17:04:00', 'Public')

INSERT POST(UserID, PostContent, PostTime, DisplayMode)
VALUES (2, N'Một ngày đầy áp lực', '2019-04-25 19:02:00', 'Friend only')

INSERT POST(UserID, PostContent, PostTime, DisplayMode)
VALUES (3, N'Đang cảm thấy rất vui vì vừa làm được việc có ích', '2019-04-15 10:02:00', 'Public')

INSERT POST(UserID, PostContent, PostTime, DisplayMode)
VALUES (4, N'Thật tồi tệ', '2019-04-21 22:02:00', 'Only me')

INSERT POST(UserID, PostContent, PostTime, DisplayMode)
VALUES (5, N'Muốn làm rất nhiều thứ', '2019-03-03 17:09:00', 'Public')

INSERT POST(UserID, PostContent, PostTime, DisplayMode)
VALUES (6, N'Lễ này đi đâu đây mọi người?', '2019-04-23 18:02:00', 'Public')

INSERT POST(UserID, PostContent, PostTime, DisplayMode)
VALUES (6, N'Chuẩn bị gì để đi chơi nhỉ?', '2019-04-23 18:30:00', 'Public')

GO

--Bảng bình luận
INSERT COMMENT (UserID, PostID, CommentContent, CommentTime)
VALUES (5, 6, N'Vote một phiếu đi Phú Quốc', '2019-04-23 18:04:00')

INSERT COMMENT (UserID, PostID, CommentContent, CommentTime, ReplyID)
VALUES (6, 6, N'Hẹn hò nhậu nhẹt ở đó đê! hehe', '2019-04-23 18:05:00', 1)

INSERT COMMENT (UserID, PostID, CommentContent, CommentTime)
VALUES (3, 1, N'Chán thì đi chơi cho đỡ chán', '2019-04-23 17:02:00')

GO

--Bảng tương thích của người dùng với người dùng (ket noi hen ho)
INSERT SUITABLE (UserID, SUserID, SuitablePercent)
VALUES (1, 4, 0.9)

INSERT SUITABLE (UserID, SUserID, SuitablePercent)
VALUES (6, 3, 0.75)
GO

--Bảng tin nhắn
INSERT SEND_MSG (SenderID, ReceiverID, MessageText, MessageTime)
VALUES (1, 6, N'Dạo này còn làm công ty lúc trước không?', '2019-04-25 11:42:00')

INSERT SEND_MSG (SenderID, ReceiverID, MessageText, MessageTime)
VALUES (6, 1, N'Tao nghỉ rồi mày ạ', '2019-04-25 11:48:00')

INSERT SEND_MSG (SenderID, ReceiverID, MessageText, MessageTime)
VALUES (1, 2, N'Bạn ơi chỉ giúp mình cái này', '2019-04-25 11:45:00')

INSERT SEND_MSG (SenderID, ReceiverID, MessageText, MessageTime)
VALUES (2, 1, N'Bạn cần mình giúp gì?', '2019-04-25 11:47:00')
GO

--Bảng chia sẻ bài đăng
INSERT SHARE_POST (UserID, PostID, SharePostTime)
VALUES (5, 7, '2019-04-23 18:03:00')
GO

INSERT SHARE_POST (UserID, PostID, SharePostTime)
VALUES (1, 7, '2019-04-23 18:03:00')
GO

INSERT SHARE_POST (UserID, PostID, SharePostTime)
VALUES (5, 5, '2019-04-23 18:03:00')
GO

--Bảng thích bài đăng
INSERT LIKE_POST (UserID, PostID)
VALUES (1, 3)

INSERT LIKE_POST (UserID, PostID)
VALUES (1, 5)


INSERT LIKE_POST (UserID, PostID)
VALUES (2, 5)

GO

--Bảng thích bình luận
INSERT LIKE_COMMENT(UserID, CommentID)
VALUES (1, 1)

INSERT LIKE_COMMENT(UserID, CommentID)
VALUES (1, 2)

INSERT LIKE_COMMENT(UserID, CommentID)
VALUES (3, 1)

INSERT LIKE_COMMENT(UserID, CommentID)
VALUES (3, 2)

GO

--Bảng chia sẻ bình luận
INSERT SHARE_COMMENT(UserID, CommentID, ShareCommentTime)
VALUES (5, 2, '2019-04-23 18:06:00')

INSERT SHARE_COMMENT(UserID, CommentID, ShareCommentTime)
VALUES (1, 2, '2019-04-23 18:06:30')

GO



