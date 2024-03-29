--Khởi tạo database
CREATE DATABASE CC00770xFBNetwork
GO

--Sử dụng database
USE CC00770xFBNetwork
GO

--Tạo bảng người dùng
CREATE TABLE FBUSER
(
UserID INT PRIMARY KEY IDENTITY(1,1),
Email NVARCHAR(50)NOT NULL UNIQUE,
UPassword NVARCHAR (50)NOT NULL,
Name NVARCHAR (100),
Avatar NVARCHAR (300),
Background NVARCHAR (300),
Sex NVARCHAR(25),
Birthday DATETIME,
UAddress NTEXT,
Workplace NTEXT,
MaritalStatus NVARCHAR(25),
Education NTEXT
)
GO

--Tạo bảng bài đăng
CREATE TABLE POST
(
PostID INT PRIMARY KEY IDENTITY(1,1),
UserID INT NOT NULL,
PostContent NTEXT,
PostTime DATETIME DEFAULT GETDATE(),
DisplayMode NVARCHAR(50),
--Tạo khóa ngoại
CONSTRAINT UserID_P FOREIGN KEY (UserID) REFERENCES FBUSER(UserId)
)
GO

--Tạo bảng bình luận
CREATE TABLE COMMENT
(
CommentID INT PRIMARY KEY IDENTITY(1,1),
CommentContent NTEXT,
CommentTime DATETIME DEFAULT GETDATE(),
ReplyID INT,
UserID INT NOT NULL,
PostID INT NOT NULL,
--Tạo khóa ngoại
CONSTRAINT UserID_C FOREIGN KEY (UserID) REFERENCES FBUSER(UserId),
CONSTRAINT PostID_C FOREIGN KEY (PostID) REFERENCES  POST(PostId),
CONSTRAINT ReplyID_C FOREIGN KEY (ReplyID) REFERENCES COMMENT(CommentID)
)
GO

--Tạo bảng tương thích giữa người dùng với người dùng
CREATE TABLE SUITABLE
(
UserID INT,
SUserID INT,
SuitablePercent FLOAT,
--Tạo khóa chính
PRIMARY KEY (UserID, SUserID),
--Tạo khóa ngoài
CONSTRAINT UserID_S FOREIGN KEY (UserID) REFERENCES FBUSER(UserId),
CONSTRAINT UserID_SS FOREIGN KEY (SUserID) REFERENCES FBUSER(UserId)
)
GO

--Tạo bảng người dùng nhắn tin với người dùng
CREATE TABLE SEND_MSG
(
MessageID INT PRIMARY KEY IDENTITY(1,1),
SenderID INT NOT NULL,
ReceiverID INT NOT NULL,
MessageText NTEXT,
MessageTime DATETIME DEFAULT GETDATE(),
--Tạo khóa ngoài
CONSTRAINT UserID_MS FOREIGN KEY (SenderID) REFERENCES FBUSER(UserId),
CONSTRAINT UserID_MR FOREIGN KEY (ReceiverID) REFERENCES FBUSER(UserId)
)
GO

--Tạo bảng chia sẻ bài đăng
CREATE TABLE SHARE_POST
(
UserID INT,
PostID INT,
SharePostTime DATETIME DEFAULT GETDATE(),
--Tạo khóa chính
PRIMARY KEY (UserID, PostID),
--Tạo khóa ngoại
CONSTRAINT UserID_SP FOREIGN KEY (UserID) REFERENCES FBUSER(UserId),
CONSTRAINT PostID_SP FOREIGN KEY (PostID) REFERENCES  POST(PostId),
)
GO

--Tạo bảng thích bài đăng
CREATE TABLE LIKE_POST
(
UserID INT,
PostID INT,
--Tạo khóa chính
PRIMARY KEY (UserID, PostID),
--Tạo khóa ngoài
CONSTRAINT UserID_LP FOREIGN KEY (UserID) REFERENCES FBUSER(UserId),
CONSTRAINT PostID_LP FOREIGN KEY (PostID) REFERENCES  POST(PostId),
)
GO

--Tạo bảng thích bình luận
CREATE TABLE LIKE_COMMENT
(
UserID INT,
CommentID INT,
--Tạo khóa chính
PRIMARY KEY (UserID, CommentID),
--Tạo khóa ngoài
CONSTRAINT UserID_LC FOREIGN KEY (UserID) REFERENCES FBUSER(UserId),
CONSTRAINT CommentID_LC FOREIGN KEY (CommentID) REFERENCES  COMMENT(CommentId),
)
GO

--Tạo bảng chia sẻ bình luận
CREATE TABLE SHARE_COMMENT
(
UserID INT,
CommentID INT,
ShareCommentTime DATETIME DEFAULT GETDATE(),
--Tạo khóa chính
PRIMARY KEY (UserID, CommentID),
--Tạo khóa ngoài
CONSTRAINT UserID_SC FOREIGN KEY (UserID) REFERENCES FBUSER(UserId),
CONSTRAINT CommentID_SC FOREIGN KEY (CommentID) REFERENCES  COMMENT(CommentId),
)
GO

--Đánh chỉ mục
--Nhu cầu tìm kiếm một tài khoản facebook để theo dõi hoặc kết bạn là rất cao
--Thông thường thì để tìm kiếm một người nào đó trên mạng xã hội thì tìm theo email là chính xác nhất nên em đánh chỉ mục theo email

CREATE INDEX idx_Email ON FBUSER(Email);

select UserID, count(UserID)
FROM
(SELECT FBUSER.UserID, PostID
FROM FBUSER
INNER JOIN POST ON FBUSER.UserID = POST.UserID) as temp
Group by UserID
having count(UserID) >=2