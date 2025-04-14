-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ngo thi thuy linh
-- Create date:2025-04-14
-- Description:	sp_GiangVienDangDayTrongKhoang
-- =============================================
CREATE OR ALTER PROCEDURE sp_GiangVienDangDayTrongKhoang
    @datetime1 DATETIME,
    @datetime2 DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    -- Bảng ánh xạ tiết sang giờ
    WITH TietGio AS (
        SELECT 1 AS tiet, '07:00' AS GioVao, '07:45' AS GioRa UNION ALL
        SELECT 2, '07:50', '08:35' UNION ALL
        SELECT 3, '08:40', '09:25' UNION ALL
        SELECT 4, '09:30', '10:15' UNION ALL
        SELECT 5, '10:20', '11:05' UNION ALL
        SELECT 6, '11:10', '11:55' UNION ALL
        SELECT 7, '13:00', '13:45' UNION ALL
        SELECT 8, '13:50', '14:35' UNION ALL
        SELECT 9, '14:40', '15:25' UNION ALL
        SELECT 10, '15:30', '16:15'
    )

    SELECT 
        gv.tengv AS HoTenGV,
        mh.tenmon AS MonDay,
        CAST(CONVERT(varchar, tkb.ngay, 23) + ' ' + tg1.GioVao AS DATETIME) AS GioVao,
        CAST(CONVERT(varchar, tkb.ngay, 23) + ' ' + tg2.GioRa AS DATETIME) AS GioRa
    FROM 
        tkb
        JOIN  GIAOVIEN gv ON tkb.magv = gv.magv
        JOIN monhoc mh ON tkb.mamon = mh.mamon
        JOIN TietGio tg1 ON tkb.tietbatdau = tg1.tiet
        JOIN TietGio tg2 ON tkb.tietketthuc = tg2.tiet
    WHERE 
        CAST(CONVERT(varchar, tkb.ngay, 23) + ' ' + tg2.GioRa AS DATETIME) > @datetime1 AND
        CAST(CONVERT(varchar, tkb.ngay, 23) + ' ' + tg1.GioVao AS DATETIME) < @datetime2
END
GO
EXEC sp_GiangVienDangDayTrongKhoang
    @datetime1 = '2025-03-17 08:00:00',
    @datetime2 = '2025-03-17 11:00:00'



