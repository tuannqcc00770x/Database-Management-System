--Su dung database
USE CC00770xFBNetwork
GO

--Lay ra cac bai dang co it nhat 2 luot thich va hien thi so luot thich

--Tao truoc mot bang ao #TMP chua ID cua post va so luong like (dieu kien it nhat 2 like)
SELECT POST.PostID, COUNT(*) AS NumberOflikes
INTO #TMP
FROM POST INNER JOIN LIKE_POST
ON POST.PostID = LIKE_POST.PostID
GROUP BY POST.PostID
HAVING COUNT(*)>1
GO

--Tao khoa ngoai de tham chieu tu #TMP den post
ALTER TABLE #TMP
ADD CONSTRAINT TMPID FOREIGN KEY (PostID) REFERENCES POST(PostID)
GO

--Hien thi noi dung theo yeu cau
SELECT POST.PostID, PostContent, PostTime, NumberOflikes
FROM POST INNER JOIN #TMP
ON POST.PostID = #TMP.PostID
GO

--Comment o duoi dung de xoa bang tam va chay lai lenh trong truong hop gap loi
--DROP TABLE #TMP 
--GO
