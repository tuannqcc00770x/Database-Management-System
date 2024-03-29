--Sử dụng database
USE CC00770xFBNetwork
GO
--Gọi câu lệnh thứ nhất
SELECT * FROM FBUSER WHERE UserID = 1
GO
--Gọi câu lệnh thứ hai
SELECT Email, Name FROM FBUSER WHERE UserID = 1
GO
--Gọi lệnh kiểm tra tốc độ
SELECT top 3 last_execution_time
        ,creation_time
        ,total_physical_reads
        ,total_logical_reads 
        ,total_logical_writes
        , execution_count
        , total_worker_time
        , total_elapsed_time
        , total_elapsed_time / execution_count avg_elapsed_time
        ,SUBSTRING(st.text, (qs.statement_start_offset/2) + 1,
         ((CASE statement_end_offset
          WHEN -1 THEN DATALENGTH(st.text)
          ELSE qs.statement_end_offset END
            - qs.statement_start_offset)/2) + 1) AS statement_text
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
ORDER BY last_execution_time DESC
GO
--Sau khi gọi câu lệnh kiểm tra tốc độ quan sát và so sánh cột avg_elapsed_time
--ta thấy việc dùng lệnh "SELECT * FROM" luôn chậm hơn so với việc chọn cột cụ thể  