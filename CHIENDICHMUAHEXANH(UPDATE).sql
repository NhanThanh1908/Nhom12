create database CHIENDICHMUAHEXANH
on primary (name = 'muahexanh', filename='D:\muahexanh.mdf')
log on (name='muahexanhlog', filename='D:\muahexanh.ldf')
go
use CHIENDICHMUAHEXANH
go
create table KHOA(
MAKHOA char(3) constraint Pk_MAKHOA primary key,
TENKHOA nvarchar(50) not null,
NAMTL date
)
go
create table DIABAN(
MADB char(3) constraint Pk_MADB primary key,
TENDB nvarchar(50) not null
)
go
create table GIAOVIEN(
MAGV char(4) constraint Pk_MAGV primary key,
TENGV nvarchar(50) not null,
MAKHOA char(3) constraint Fk_GIAOVIEN_KHOA references KHOA(MAKHOA) not null
)
go
create table NHOM_SV(
MANHOM char(3) constraint Pk_MANHOM primary key,
TENNHOM nvarchar(30) not null,
SOLUONGSV smallint check (SOLUONGSV between 3 and 6),
MANHOMTRUONG char(4) not null,
MAGV char(4) constraint Fk_NHOMSV_MAGV references GIAOVIEN(MAGV) not null
)
go
create table SINHVIEN(
MASV char(4) constraint Pk_MASV primary key,
TENSV nvarchar(50) not null,
MAKHOA char(3) constraint Fk_SV_KHOA references KHOA(MAKHOA) not null,
MANHOM char(3) constraint Fk_SV_NHOM references NHOM_SV(MANHOM) not null,
MADB char(3) constraint Fk_SV_DIABAN references DIABAN(MADB) not null
)
go
create table THANHTICH(
MATT char(4) constraint Pk_THANHTICH primary key,
TENTT nvarchar(50) not null,
MASV char(4) constraint Fk_TT_SV references SINHVIEN(MASV) NOT NULL,
GHICHU nvarchar(100)
)
go 
create table XA(
MAXA char(4) CONSTRAINT Pk_XA primary key, 
TENXA nvarchar(30) not null,
MADB char(3) constraint Fk_XA_DIABAN references DIABAN(MADB) not null
)
go
create table AP(
MAAP char(4) constraint Pk_AP primary key,
TENAP nvarchar(50) not null,
MAXA char(4) constraint Fk_AP_XA references Xa(MAXA) not null
)
go
create table NHADAN(
MAND char(4) constraint Pk_NHADAN primary key,
DIACHI nvarchar(50) not null,
TENCHUHO nvarchar(50) not null,
MAAP char(4) constraint Fk_NHADAN_AP references AP(MAAP) not null,
MANHOM char(3) constraint Fk_NHANDAN_NHOM references NHOM_SV(MANHOM) not null
)
go
create table CONGVIEC(
MACV char(4) constraint Pk_MACV primary key,
TENCV nvarchar(30) not null,
KHOILUONGCV smallint check (KHOILUONGCV between 1 and 3),
NGAYBD date not null,
NGAYKT date not null
)
go
create table PHANCONG(
MANHOM char(3) not null,
MACV char(4) not null,
NGAYCV date not null,
BUOICV nvarchar(10) check (BUOICV in (N'Sáng', N'Chiều', N'Tối')) not null,
CONSTRAINT PK_PHANCONG primary key (MANHOM, MACV)
)
go

insert into KHOA values
('K01', N'Công nghệ thông tin', '1980'),
('K02', N'Kế toán', '1990'),
('K03', N'Quản trị kinh doanh', '1990'),
('K04', N'Điện tử', '1980'),
('K05', N'Cơ khí', '2000'),
('K06', N'Môi trường', '2010'),
('K07', N'Tài chính ngân hàng', '1990'),
('K08', N'Thiết kế đồ họa', '2010'),
('K09', N'Ngôn ngữ Anh', '1990'),
('K10', N'Quản trị khách sạn', '2000')
go
insert into DIABAN values
('DB1', N'Bình Dương'),
('DB2', N'Gò Vấp'),
('DB3', N'Thủ Đức'),
('DB4', N'Nhà Bè'),
('DB5', N'Củ Chi')
go
insert into GIAOVIEN values
('GV01', N'Nguyễn Văn Nam','K01'),
('GV02', N'Đỗ Thị Lan', 'K02'),
('GV03', N'Lê Văn Hưng', 'K03'),
('GV04', N'Nguyễn Thị Hoa', 'K04'),
('GV05', N'Lê Văn Long', 'K05'),
('GV06', N'Nguyễn Thị Yến', 'K06'),
('GV07', N'Nguyễn Văn Tuấn', 'K07'),
('GV08', N'Lê Thị Nhung', 'K08'),
('GV09', N'Nguyễn Văn Đạt', 'K09'),
('GV10', N'Nguyễn Thị Phượng', 'K10')
go
insert into NHOM_SV values
('N01', N'Nhóm 1',3, 'SV01', 'GV01'),
('N02', N'Nhóm 2',4, 'SV02', 'GV02'),
('N03', N'Nhóm 3',5, 'SV04', 'GV03'),
('N04', N'Nhóm 4',6, 'SV06', 'GV04'),
('N05', N'Nhóm 5',4, 'SV03', 'GV05'),
('N06', N'Nhóm 6',3, 'SV07', 'GV06'),
('N07', N'Nhóm 7',6, 'SV10', 'GV07'),
('N08', N'Nhóm 8',6, 'SV05', 'GV08'),
('N09', N'Nhóm 9',5, 'SV08', 'GV09'),
('N10', N'Nhóm 10',4, 'SV06', 'GV10')
go
insert into SINHVIEN values
('SV01', N'Nguyễn Văn An', 'K01','N01', 'DB1'),
('SV02', N'Trần Thị Bích', 'K02', 'N03', 'DB2'),
('SV03', N'Lê Văn Chung', 'K05', 'N05', 'DB3'),
('SV04', N'Phạm Thị Dung', 'K03', 'N02', 'DB4'),
('SV05', N'Võ Văn Nam', 'K07', 'N04', 'DB5'),
('SV06', N'Huỳnh Thị Linh', 'K04', 'N08', 'DB5'),
('SV07', N'Đỗ Văn Giàu', 'K08', 'N10', 'DB4'),
('SV08', N'Lý Thị Hoa', 'K06', 'N07', 'DB3'),
('SV09', N'Tống Văn Nhân', 'K10', 'N06', 'DB2'),
('SV10', N'Ngô Ngọc Trinh', 'K09', 'N09', 'DB1')
go
alter table NHOM_SV
add constraint Fk_SV_NHOMTRUONG foreign key (MANHOMTRUONG) references SINHVIEN(MASV)
go
insert into THANHTICH VALUES
('TT01', N'Hoàn thành xuất sắc nhiệm vụ', 'SV03', N'Sinh viên dẫn đầu nhóm trong việc xây nhà tình thương' ),
('TT02', N'Tham gia đầy đủ', 'SV05', N'Tham dự đủ các buổi sinh hoạt và hoạt động tình nguyện'),
('TT03', N'Có sáng kiến tốt', 'SV09', N'Đề xuất mô hình “Đổi rác lấy cây xanh” tại địa phương'),
('TT04', N'Tích cực hỗ trợ nhóm', 'SV07', N'Luôn hỗ trợ đồng đội trong các hoạt động dọn dẹp môi trường'),
('TT05', N'Được dân khen ngợi', 'SV10', N'Nhận thư cảm ơn từ trưởng ấp vì giúp đỡ người dân sửa chữa nhà cửa')
go
insert into XA values
('XA01', N'Xã Tân Phú Trung', 'DB1'),
('XA02', N'Xã Phước Vĩnh An', 'DB2'),
('XA03', N'Xã Trung Lập Hạ', 'DB3'),
('XA04', N'Xã Bình Mỹ', 'DB4'),
('XA05', N'Xã Nhơn Đức', 'DB5')
go
insert into AP values
('AP01', N'Ấp 1', 'XA01'),
('AP02', N'Ấp 2', 'XA02'),
('AP03', N'Ấp 3', 'XA03'),
('AP04', N'Ấp 4', 'XA04'),
('AP05', N'Ấp 5', 'XA05'),
('AP06', N'Ấp 6', 'XA05'),
('AP07', N'Ấp 7', 'XA04'),
('AP08', N'Ấp 8', 'XA03'),
('AP09', N'Ấp 9', 'XA02'),
('AP10', N'Ấp 10','XA01')
go
insert into NHADAN values
('ND01', N'123 đường A', N'Nguyễn Văn A', 'AP01', 'N01'),
('ND02', N'456 đường B', N'Lê Thị B', 'AP05', 'N06'),
('ND03', N'78/9 đường C', N'Trần Văn C', 'AP03', 'N05'),
('ND04', N'101 đường D', N'Đỗ Thị D', 'AP08', 'N10'),
('ND05', N'202 đường A', N'Phạm Văn E', 'AP02', 'N03'),
('ND06', N'303F đường C', N'Huỳnh Văn G', 'AP09', 'N08')
go
INSERT INTO CONGVIEC VALUES
('CV01', N'Xây cầu bê tông', 1, '2025-06-01', '2025-06-10'),
('CV02', N'Sửa đường', 1, '2025-06-05', '2025-06-07'),
('CV03', N'Dọn vệ sinh', 1, '2025-06-03', '2025-06-05'),
('CV04', N'Phát quang bụi rậm', 1, '2025-06-04', '2025-06-06'),
('CV05', N'Trồng cây xanh', 1, '2025-06-07', '2025-06-08'),
('CV06', N'Dạy học thiếu nhi', 1, '2025-06-02', '2025-06-15'),
('CV07', N'Tuyên truyền bảo vệ môi trường', 1, '2025-06-09', '2025-06-09'),
('CV08', N'Phát tờ rơi phòng chống dịch', 1, '2025-06-10', '2025-06-10'),
('CV09', N'Tổ chức trò chơi cho trẻ em', 1, '2025-06-11', '2025-06-13'),
('CV10', N'Hỗ trợ tiêm vắc-xin', 1, '2025-06-14', '2025-06-15')
go
INSERT INTO PHANCONG VALUES
('N01', 'CV01', '2025-06-01', N'sáng'),
('N02', 'CV02', '2025-06-02', N'chiều'),
('N03', 'CV03', '2025-06-03', N'sáng'),
('N04', 'CV04', '2025-06-04', N'tối'),
('N05', 'CV05', '2025-06-05', N'chiều'),
('N06', 'CV06', '2025-06-06', N'sáng'),
('N07', 'CV07', '2025-06-07', N'tối'),
('N08', 'CV08', '2025-06-08', N'sáng'),
('N09', 'CV09', '2025-06-09', N'chiều'),
('N10', 'CV10', '2025-06-10', N'sáng')
go
Select * from KHOA
Select * from DIABAN
Select * from NHOM_SV
Select * from SINHVIEN
Select * from THANHTICH
Select * from XA
Select * from GIAOVIEN
Select * from AP
Select * from NHADAN
Select * from CONGVIEC
Select * from PHANCONG

--TRUY VẤN NHÓM 
--CÂU HỎI TRUY VẤN KẾT NỐI NHIỀU BẢNG:
--1. Liệt kê danh sách sinh viên (MASV, HOTEN) thuộc khoa Tài chính ngân hàng, 
--đang tham gia công việc “dọn vệ sinh” ở Xã Trung Lập Hạ.
SELECT S.MASV, S.TENSV
FROM SINHVIEN S
JOIN KHOA K ON S.MAKHOA = K.MAKHOA
JOIN PHANCONG P ON S.MANHOM = P.MANHOM
JOIN CONGVIEC C ON P.MACV = C.MACV
JOIN XA X ON S.MADB = X.MADB
WHERE K.TENKHOA = N'Tài chính ngân hàng'
AND C.TENCV = N'Dọn vệ sinh'
AND X.TENXA = N'Xã Trung Lập Hạ'
--KQ: 0 ROWS

--2. Liệt kê danh sách sinh viên tham gia công việc 
--"Xây cầu bê tông" cùng với thông tin nhóm và địa bàn.
SELECT S.MASV, S.TENSV, N.TENNHOM, D.TENDB
FROM SINHVIEN S
JOIN NHOM_SV N ON S.MANHOM = N.MANHOM
JOIN DIABAN D ON S.MADB = D.MADB
JOIN PHANCONG P ON S.MANHOM = P.MANHOM
JOIN CONGVIEC C ON P.MACV = C.MACV
WHERE C.TENCV = N'Xây cầu bê tông'
--KQ: 1 ROWS

--CÂU HỎI UPDATE:
--3. Cập nhật tất cả sinh viên thuộc khoa "Cơ khí", 
--từng làm việc vào buổi chiều thêm vào nhóm 3.
UPDATE SINHVIEN
SET MANHOM = 'N03'
WHERE MAKHOA = (SELECT MAKHOA FROM KHOA WHERE TENKHOA = N'CƠ KHÍ')
AND MASV IN (
    SELECT S.MASV
    FROM SINHVIEN S
    JOIN PHANCONG P ON S.MANHOM = P.MANHOM
    WHERE P.BUOICV = N'Chiều')
--KQ: 1 ROWS

--4. Chuyển tất cả sinh viên thuộc nhóm tham gia công việc 
--tại địa bàn Bình Dương sang địa bàn Gò Vấp (MADB = 'DB2').
UPDATE SINHVIEN
SET MADB = 'DB2'
WHERE MADB = 'DB1'
AND MANHOM IN (
    SELECT MANHOM
    FROM PHANCONG)
--KQ: 2 ROWS

--CÂU HỎI DELETE:
--5. Xóa các nhóm sinh viên nếu nhóm đó có ít hơn 3 thành viên và chưa từng tham gia bất kỳ công việc nào.
DELETE FROM NHOM_SV
WHERE SOLUONGSV < 3
AND MANHOM NOT IN (SELECT MANHOM FROM PHANCONG)

--6. Xóa tất cả các phân công công việc của các nhóm sinh viên tại các ấp không có nhà dân nào được phân công.
DELETE FROM PHANCONG
WHERE MANHOM IN (
    SELECT N.MANHOM
    FROM NHOM_SV N
    WHERE N.MANHOM NOT IN (SELECT MANHOM FROM NHADAN))

--CÂU HỎI GROUP BY:
--7. Đếm số công việc mỗi xã đã thực hiện, chỉ liệt kê các xã có trên 2 công việc.
SELECT X.TENXA, COUNT(P.MACV) AS SOCONGVIEC
FROM XA X
JOIN AP A ON X.MAXA = A.MAXA
JOIN NHADAN N ON A.MAAP = N.MAAP
JOIN PHANCONG P ON N.MANHOM = P.MANHOM
GROUP BY X.TENXA
HAVING COUNT(P.MACV) > 2
--KQ: 0 ROWS

--8. Tính số lượng công việc được thực hiện tại mỗi địa bàn, kèm theo số lượng xã và 
--tổng khối lượng công việc, chỉ lấy các địa bàn có ít nhất 2 công việc.
SELECT D.TENDB, COUNT(DISTINCT P.MACV) AS SOCONGVIEC, COUNT(DISTINCT X.MAXA) AS SOXA, SUM(C.KHOILUONGCV) AS TONGKHOILUONG
FROM DIABAN D
JOIN XA X ON D.MADB = X.MADB
JOIN AP A ON X.MAXA = A.MAXA
JOIN NHADAN N ON A.MAAP = N.MAAP
JOIN PHANCONG P ON N.MANHOM = P.MANHOM
JOIN CONGVIEC C ON P.MACV = C.MACV
GROUP BY D.TENDB
HAVING COUNT(DISTINCT P.MACV) >= 2
--KQ: 2 ROWS

--CÂU HỎI SUB QUERY:
--9. Liệt kê các nhóm sinh viên mà tất cả các thành viên đều đến từ cùng một khoa.
SELECT N.MANHOM, N.TENNHOM
FROM NHOM_SV N
JOIN SINHVIEN S ON N.MANHOM = S.MANHOM
GROUP BY N.MANHOM, N.TENNHOM
HAVING COUNT(DISTINCT S.MAKHOA) = 1
--KQ: 8 ROWS

--10. Liệt kê các giáo viên giám sát các nhóm sinh viên có số lượng 
--thành viên lớn hơn số lượng thành viên trung bình của tất cả các nhóm.
SELECT G.MAGV, G.TENGV
FROM GIAOVIEN G
JOIN NHOM_SV N ON G.MAGV = N.MAGV
WHERE N.SOLUONGSV > (SELECT AVG(SOLUONGSV) FROM NHOM_SV)
--KQ: 5 ROWS

--CÂU HỎI BẤT KÌ:
--11. Liệt kê tên các sinh viên thuộc nhóm có số lượng công việc phân công nhiều nhất trong chiến dịch.
SELECT S.TENSV
FROM SINHVIEN S
WHERE S.MANHOM IN (
    SELECT P.MANHOM
    FROM PHANCONG P
    GROUP BY P.MANHOM
    HAVING COUNT(P.MACV) = (SELECT MAX(COUNT(MACV)) FROM PHANCONG GROUP BY MANHOM))
--KQ: 10 ROWS

--12. Tìm các nhóm sinh viên tham gia cả hai công việc 'Xây cầu bê tông' và 
--'Trồng cây xanh' trong cùng một ngày, liệt kê mã nhóm và ngày thực hiện.
SELECT P1.MANHOM, P1.NGAYCV
FROM PHANCONG P1
JOIN PHANCONG P2 ON P1.MANHOM = P2.MANHOM AND P1.NGAYCV = P2.NGAYCV
JOIN CONGVIEC C1 ON P1.MACV = C1.MACV
JOIN CONGVIEC C2 ON P2.MACV = C2.MACV
WHERE C1.TENCV = N'Xây cầu bê tông' AND C2.TENCV = N'Trồng cây xanh'
--KQ: 0 ROWS

--Bài cá nhân - Võ Lê Hồng Hân
--13. Tìm danh sách sinh viên thuộc nhóm có số lượng ít nhất, nhóm đó đã được phân công công việc gì?
SELECT S.MASV, S.TENSV, C.TENCV
FROM SINHVIEN S
JOIN NHOM_SV N ON S.MANHOM = N.MANHOM
JOIN PHANCONG P ON N.MANHOM = P.MANHOM
JOIN CONGVIEC C ON P.MACV = C.MACV
WHERE N.SOLUONGSV = (SELECT MIN(SOLUONGSV) FROM NHOM_SV)
--KQ: 2 ROWS

--14. Có bao nhiêu công việc diễn ra trong xã có quản lý giáo viên “ Nguyễn Văn Nam”
SELECT COUNT(DISTINCT P.MACV) AS SOCONGVIEC
FROM PHANCONG P
JOIN NHOM_SV N ON P.MANHOM = N.MANHOM
JOIN GIAOVIEN G ON N.MAGV = G.MAGV
JOIN NHADAN ND ON N.MANHOM = ND.MANHOM
JOIN AP A ON ND.MAAP = A.MAAP
JOIN XA X ON A.MAXA = X.MAXA
WHERE G.TENGV = N'Nguyễn Văn Nam'
--KQ: 1 ROWS

--15. Liệt kê những sinh viên chưa đạt thành tích nào, bao gồm mã sinh viên, tên sinh viên và tên nhóm đang tham gia.
SELECT SV.MASV, SV.TENSV, NSV.TENNHOM
FROM SINHVIEN SV
JOIN NHOM_SV NSV ON SV.MANHOM = NSV.MANHOM
WHERE NOT EXISTS (
    SELECT 1
    FROM THANHTICH TT
    WHERE TT.MASV = SV.MASV)
--KQ: 5 ROWS

--16. Liệt kê những giáo viên hướng dẫn từ 2 nhóm sinh viên trở lên, bao gồm mã giáo viên, tên giáo viên và số lượng nhóm mà họ hướng dẫn.
SELECT GV.MAGV, GV.TENGV, COUNT(NSV.MANHOM) AS SoNhom
FROM GIAOVIEN GV
JOIN NHOM_SV NSV ON GV.MAGV = NSV.MAGV
GROUP BY GV.MAGV, GV.TENGV
HAVING COUNT(NSV.MANHOM) >= 2
--KQ: 0 ROWS

--17. Tìm tên sinh viên là nhóm trưởng và đồng thời thuộc khoa công nghệ thông tin
SELECT S.TENSV
FROM SINHVIEN S
JOIN KHOA K ON S.MAKHOA = K.MAKHOA
WHERE S.MASV IN (SELECT MANHOMTRUONG FROM NHOM_SV)
AND K.TENKHOA = N'Công nghệ thông tin'
--K1: 1 ROWS

--Bài cá nhân_Lê Huỳnh Sao Mai
--HAVING
--18. Hiển thị các địa bàn (DIABAN) có sinh viên tham gia từ ít nhất 2 khoa khác nhau, 
--kèm theo số lượng khoa và số lượng sinh viên tại mỗi địa bàn.
SELECT 
    DIABAN.MADB, 
    DIABAN.TENDB, 
    COUNT(DISTINCT SINHVIEN.MAKHOA) AS SoLuongKhoa, 
    COUNT(SINHVIEN.MASV) AS SoLuongSV
FROM DIABAN
JOIN SINHVIEN ON DIABAN.MADB = SINHVIEN.MADB
GROUP BY DIABAN.MADB, DIABAN.TENDB
HAVING COUNT(DISTINCT SINHVIEN.MAKHOA) >= 2
--KQ: 3 ROWS

--19. Hiển thị các nhóm sinh viên (NHOM_SV) có tổng khối lượng công việc (KHOILUONGCV) được 
--phân công ít nhất 1, kèm theo tên giáo viên hướng dẫn, tổng khối lượng công việc và số
--lượng công việc được phân công, chỉ tính các công việc diễn ra vào buổi sáng hoặc chiều.
SELECT NHOM_SV.MANHOM, NHOM_SV.TENNHOM, GIAOVIEN.TENGV, 
    SUM(CONGVIEC.KHOILUONGCV) AS TongKhoiLuongCV, 
    COUNT(PHANCONG.MACV) AS SoLuongCV
FROM NHOM_SV
JOIN GIAOVIEN ON NHOM_SV.MAGV = GIAOVIEN.MAGV
JOIN PHANCONG ON NHOM_SV.MANHOM = PHANCONG.MANHOM
JOIN CONGVIEC ON PHANCONG.MACV = CONGVIEC.MACV
WHERE PHANCONG.BUOICV IN (N'Sáng', N'Chiều')
GROUP BY NHOM_SV.MANHOM, NHOM_SV.TENNHOM, GIAOVIEN.TENGV
HAVING SUM(CONGVIEC.KHOILUONGCV) >= 1
--KQ: 8 ROWS

--SUBQUERY
--20. Tìm các sinh viên có thành tích và thuộc nhóm được phân công công việc vào buổi sáng
SELECT DISTINCT S.TENSV, S.MASV, N.TENNHOM
FROM SINHVIEN S
JOIN NHOM_SV N ON S.MANHOM = N.MANHOM
WHERE S.MASV IN (
    SELECT TT.MASV
    FROM THANHTICH TT)
AND N.MANHOM IN (
    SELECT P.MANHOM
    FROM PHANCONG P
    WHERE P.BUOICV = N'Sáng')
--KQ: 3 ROWS

--LIỆT KÊ NHIỀU BẢNG
--21. Liệt kê tên sinh viên, tên khoa, tên giáo viên hướng dẫn, tên ấp, và tên công việc được 
--phân công, chỉ bao gồm các sinh viên thuộc nhóm có thành tích và công việc được thực hiện 
--vào buổi sáng hoặc buổi chiều
SELECT SV.TENSV, K.TENKHOA, GV.TENGV, A.TENAP, CV.TENCV
FROM SINHVIEN SV
JOIN KHOA K ON SV.MAKHOA = K.MAKHOA
JOIN NHOM_SV NSV ON SV.MANHOM = NSV.MANHOM
JOIN GIAOVIEN GV ON NSV.MAGV = GV.MAGV
JOIN THANHTICH TT ON SV.MASV = TT.MASV
JOIN PHANCONG PC ON NSV.MANHOM = PC.MANHOM
JOIN CONGVIEC CV ON PC.MACV = CV.MACV
JOIN NHADAN ND ON NSV.MANHOM = ND.MANHOM
JOIN AP A ON ND.MAAP = A.MAAP
WHERE PC.BUOICV IN (N'Sáng', N'Chiều')
ORDER BY SV.TENSV
--KQ: 3 ROWS

--UPDATE
--22. Cập nhật mã địa bàn của các sinh viên thuộc nhóm có nhóm trưởng tên 'Ngô Ngọc Trinh' thành 'DB1'
UPDATE SINHVIEN
SET MADB = 'DB1'
WHERE MANHOM IN (
    SELECT MANHOM
    FROM NHOM_SV
    WHERE MANHOMTRUONG IN (
        SELECT MASV
        FROM SINHVIEN
        WHERE TENSV = N'Ngô Ngọc Trinh'))
--KQ: 1 ROWS

--DELETE
--23. Xóa công việc có mã công việc = 'CV05'.
DELETE FROM CongViec
WHERE MACV = 'CV05'

--GROUP BY
--24. Đếm số lượng công việc được phân công cho mỗi địa bàn, chỉ bao gồm các địa bàn có nhà dân được hỗ trợ
--bởi nhóm có số lượng sinh viên lớn hơn 4, và hiển thị tên địa bàn cùng số lượng công việc.
SELECT DB.TENDB, COUNT(PC.MACV) AS SoLuongCongViec
FROM DIABAN DB
JOIN XA X ON DB.MADB = X.MADB
JOIN AP A ON X.MAXA = A.MAXA
JOIN NHADAN ND ON A.MAAP = ND.MAAP
JOIN NHOM_SV NSV ON ND.MANHOM = NSV.MANHOM
JOIN PHANCONG PC ON NSV.MANHOM = PC.MANHOM
WHERE NSV.SOLUONGSV > 4
GROUP BY DB.TENDB
ORDER BY SoLuongCongViec DESC
--KQ: 1 ROWS

--25. Tìm sinh viên thuộc nhóm có số lượng thành viên nhiều nhất.
SELECT SV.MASV, SV.TENSV, SV.MANHOM
FROM SINHVIEN SV
WHERE 
    SV.MANHOM = (
        SELECT TOP 1 MANHOM
        FROM NHOM_SV
        ORDER BY SOLUONGSV DESC)
--KQ: 1 ROWS

--Bài cá nhân_Nguyễn Thị Thùy Ngân
--CÂU TRUY VẤN KẾT NỐI NHIỀU BẢNG
--26. Liệt kê công việc tại xã Nhơn Đức và tên ấp.
SELECT C.TENCV, A.TENAP
FROM CONGVIEC C
JOIN PHANCONG P ON C.MACV = P.MACV
JOIN NHADAN N ON P.MANHOM = N.MANHOM
JOIN AP A ON N.MAAP = A.MAAP
JOIN XA X ON A.MAXA = X.MAXA
WHERE X.TENXA = N'Xã Nhơn Đức'
--KQ: 1 ROWS

--CÂU UPDATE
--27. Tăng khối lượng công việc của CV01 lên 1.
UPDATE CONGVIEC
SET KHOILUONGCV = KHOILUONGCV + 1
WHERE MACV = 'CV01'
--KQ: 1 ROWS

--CÂU DELETE
--28. Xóa phân công công việc của nhóm N04.
DELETE FROM PHANCONG
WHERE MANHOM = 'N04'

--CÂU SUB QUERY
--29. Liệt kê sinh viên thuộc nhóm tham gia công việc CV02.
SELECT S.MASV, S.TENSV
FROM SINHVIEN S
JOIN PHANCONG P ON S.MANHOM = P.MANHOM
WHERE P.MACV = 'CV02'
--KQ: 1 ROWS

--CÂU BẤT KỲ
--30. Liệt kê nhà dân tại xã Phước Vĩnh An.
SELECT N.MAND, N.DIACHI, N.TENCHUHO
FROM NHADAN N
JOIN AP A ON N.MAAP = A.MAAP
JOIN XA X ON A.MAXA = X.MAXA
WHERE X.TENXA = N'Xã Phước Vĩnh An'
--KQ: 2 ROWS

--31. Liệt kê các địa bàn có tổng số lượng sinh viên trong các nhóm tham gia chiến dịch mùa hè xanh lớn hơn 5.
SELECT DB.MADB, DB.TENDB
FROM DIABAN DB
JOIN SINHVIEN SV ON DB.MADB = SV.MADB
JOIN NHOM_SV NSV ON SV.MANHOM = NSV.MANHOM
GROUP BY DB.MADB, DB.TENDB
HAVING SUM(NSV.SOLUONGSV) > 5
--KQ: 4 ROWS

--32. Liệt kê các xã có số lượng nhà dân được hỗ trợ bởi các nhóm sinh viên lớn hơn 1.
SELECT XA.MAXA, XA.TENXA
FROM XA
JOIN AP ON XA.MAXA = AP.MAXA
JOIN NHADAN ND ON AP.MAAP = ND.MAAP
GROUP BY XA.MAXA, XA.TENXA
HAVING COUNT(ND.MAND) > 1
--KQ: 2 ROWS

--33. Liệt kê các nhóm sinh viên có ngày làm việc sớm nhất (NGAYCV trong PHANCONG) trước ngày '2025-06-03'.
SELECT NSV.MANHOM, NSV.TENNHOM
FROM NHOM_SV NSV
JOIN PHANCONG PC ON NSV.MANHOM = PC.MANHOM
GROUP BY NSV.MANHOM, NSV.TENNHOM
HAVING MIN(PC.NGAYCV) < '2025-06-03'
--KQ: 2 ROWS

--34. Liệt kê các công việ có ngày kết thúc muộn nhất (NGAYKT) sau ngày '2025-06-14'.
SELECT CV.MACV, CV.TENCV
FROM CONGVIEC CV
JOIN PHANCONG PC ON CV.MACV = PC.MACV
GROUP BY CV.MACV, CV.TENCV
HAVING MAX(CV.NGAYKT) > '2025-06-14'
--KQ: 2 ROWS

--Bài cá nhân_Đỗ Thành Nhân
--CÂU TRUY VẤN KẾT NỐI NHIỀU BẢNG
--35. Liệt kê các công việc được thực hiện tại Gò Vấp
SELECT C.TENCV
FROM CONGVIEC C
JOIN PHANCONG P ON C.MACV = P.MACV
JOIN NHADAN N ON P.MANHOM = N.MANHOM
JOIN AP A ON N.MAAP = A.MAAP
JOIN XA X ON A.MAXA = X.MAXA
JOIN DIABAN D ON X.MADB = D.MADB
WHERE D.TENDB = N'Gò Vấp'
--KQ: 2 ROWS

--CÂU GROUP BY
--36. Tính tổng khối lượng công việc của các xã có tên bắt đầu bằng chữ T 
SELECT SUM(C.KHOILUONGCV) AS TONGKHOILUONG
FROM CONGVIEC C
JOIN PHANCONG P ON C.MACV = P.MACV
JOIN NHADAN N ON P.MANHOM = N.MANHOM
JOIN AP A ON N.MAAP = A.MAAP
JOIN XA X ON A.MAXA = X.MAXA
WHERE X.TENXA LIKE N'T%'
--KQ: 1 ROWS

--CÂU SUB QUERY
--37. Tìm các nhóm có ít nhất 1 thành viên đạt thành tích "Hoàn thành xuất sắc nhiệm vụ"
SELECT DISTINCT N.MANHOM, N.TENNHOM
FROM NHOM_SV N
JOIN SINHVIEN S ON N.MANHOM = S.MANHOM
JOIN THANHTICH T ON S.MASV = T.MASV
WHERE T.TENTT = N'Hoàn thành xuất sắc nhiệm vụ'
--KQ: 1 ROWS


--CÂU BẤT KỲ
--38. Tìm nhóm có thời gian bắt đầu công việc sớm nhất
SELECT N.MANHOM, N.TENNHOM, MIN(C.NGAYBD) AS NGAYBATDAU
FROM NHOM_SV N
JOIN PHANCONG P ON N.MANHOM = P.MANHOM
JOIN CONGVIEC C ON P.MACV = C.MACV
GROUP BY N.MANHOM, N.TENNHOM
HAVING MIN(C.NGAYBD) = (SELECT MIN(NGAYBD) FROM CONGVIEC)
--KQ: 1 ROWS

--39. Liệt kê các xã có tổng số hộ dân nhiều hơn 1 và ít nhất một hộ thuộc nhóm sinh viên đã nhận thành tích
SELECT XA.MAXA, XA.TENXA, COUNT(ND.MAND) AS SoHoDan
FROM XA
JOIN AP ON XA.MAXA = AP.MAXA
JOIN NHADAN ND ON AP.MAAP = ND.MAAP
WHERE ND.MANHOM IN (
    SELECT SV.MANHOM
    FROM SINHVIEN SV
    JOIN THANHTICH TT ON SV.MASV = TT.MASV)
GROUP BY XA.MAXA, XA.TENXA
HAVING COUNT(ND.MAND) > 1
--KQ: 1 ROWS

--40. Liệt kê địa bàn có hơn 1 sinh viên và có sinh viên thuộc khoa Cơ khí:
SELECT DB.MADB, DB.TENDB, COUNT(SV.MASV) AS SoLuongSinhVien
FROM DIABAN DB
JOIN SINHVIEN SV ON DB.MADB = SV.MADB
JOIN KHOA K ON K.MAKHOA=SV.MAKHOA
WHERE K.TENKHOA = N'Cơ Khí'
GROUP BY DB.MADB, DB.TENDB
HAVING COUNT(SV.MASV) >= 1
--KQ: 1 ROWS

--41. Tìm các nhóm có số lượng sinh viên lớn hơn số lượng trung bình của các nhóm
SELECT n.MANHOM, n.TENNHOM, n.SOLUONGSV
FROM NHOM_SV n
WHERE n.SOLUONGSV > (
    SELECT AVG(SOLUONGSV)
    FROM NHOM_SV)
--KQ: 5 rows

--42. Tìm các nhóm có ít nhất 1 thành viên đạt thành tích "Hoàn thành xuất sắc nhiệm vụ"
SELECT NHOM_SV.*
FROM NHOM_SV
WHERE MANHOM IN (
    SELECT MANHOM
    FROM SINHVIEN as SV
	JOIN THANHTICH as TT on SV.MASV =TT.MASV
	WHERE TT.TENTT= N'Hoàn thành xuất sắc nhiệm vụ')
--KQ: 1 ROWS

--BÀI CÁ NHÂN - NGUYỄN NGỌC PHƯƠNG THÙY
--CÂU TRUY VẤN KẾT NỐI NHIỀU BẢNG
--43. Hiển thị thông tin sinh viên và tên khoa của các thành viên trong nhóm 7 hoạt động ở Thủ Đức và có thành tích "Có sáng kiến tốt"
SELECT S.MASV, S.TENSV, K.TENKHOA
FROM SINHVIEN S
JOIN KHOA K ON S.MAKHOA = K.MAKHOA
JOIN THANHTICH T ON S.MASV = T.MASV
JOIN DIABAN D ON S.MADB = D.MADB
WHERE S.MANHOM = 'N07'
AND D.TENDB = N'Thủ Đức'
AND T.TENTT = N'Có sáng kiến tốt'
--KQ: 0 ROWS

--CÂU GROUP BY
--44. Thống kê số lượng sinh viên của mỗi khoa tham gia chiến dịch mùa hè xanh
SELECT K.TENKHOA, COUNT(S.MASV) AS SOSINHVIEN
FROM KHOA K
JOIN SINHVIEN S ON K.MAKHOA = S.MAKHOA
GROUP BY K.TENKHOA
--KQ: 10 ROWS

--45. Thống kê số lượng công việc theo địa bàn
SELECT D.TENDB, COUNT(P.MACV) AS SOCONGVIEC
FROM DIABAN D
JOIN XA X ON D.MADB = X.MADB
JOIN AP A ON X.MAXA = A.MAXA
JOIN NHADAN N ON A.MAAP = N.MAAP
JOIN PHANCONG P ON N.MANHOM = P.MANHOM
GROUP BY D.TENDB
--KQ: 4 ROWS

--CÂU SUB QUERY
--46. Hiển thị thông tin các nhóm sinh viên có số lượng sinh viên nhiều hơn số lượng sinh viên trung bình của tất cả các nhóm
SELECT N.MANHOM, N.TENNHOM, N.SOLUONGSV
FROM NHOM_SV N
WHERE N.SOLUONGSV > (SELECT AVG(SOLUONGSV) FROM NHOM_SV)
--KQ: 5 ROWS

--47. Tìm các nhóm sinh viên có số lượng sinh viên lớn hơn 4 
-- và có nhiều hơn 1 công việc được phân công
SELECT N.MANHOM, N.TENNHOM, N.SOLUONGSV, COUNT(PC.MACV) AS SoLuongCongViec
FROM NHOM_SV N
JOIN PHANCONG PC ON N.MANHOM = PC.MANHOM
GROUP BY N.MANHOM, N.TENNHOM, N.SOLUONGSV
HAVING N.SOLUONGSV > 4 AND COUNT(PC.MACV) > 1
--KQ: 0 ROWS

--48. Thống kê số lượng sinh viên của mỗi khoa tham gia chiến dịch mùa hè xanh
SELECT k.MAKHOA, k.TENKHOA, COUNT(sv.MASV) AS SoLuongSinhVien
FROM KHOA k
LEFT JOIN SINHVIEN sv ON k.MAKHOA = sv.MAKHOA
GROUP BY k.MAKHOA, k.TENKHOA
--KQ: 10 ROWS

--49. Tính tổng số công việc được phân công theo từng ngày
SELECT NGAYCV, COUNT(*) AS SoLuongPhanCong
FROM PHANCONG
GROUP BY NGAYCV
--KQ: 10 ROWS

--50. Liệt kê công việc có khối lượng lớn nhất
SELECT TENCV
FROM CONGVIEC
WHERE KHOILUONGCV = (
    SELECT MAX(KHOILUONGCV)
    FROM CONGVIEC)
--KQ: 1 ROWS
