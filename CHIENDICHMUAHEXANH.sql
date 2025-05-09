create database CHIENDICHMUAHEXANH
on primary (name = 'muahexanh', filename='D:\muahexanh.mdf')
log on (name='muahexanhlog', filename='D:\muahexanh.ldf')
go
use CHIENDICHMUAHEXANH
go
create table KHOA(
MAKHOA char(3) constraint Pk_MAKHOA primary key,
TENKHOA nvarchar(50) not null,
NAMTL datetime 
)
go
create table DIABAN(
MADB char(3) constraint Pk_MADB primary key,
TENDB nvarchar(50) not null
)
go
create table NHOM_SV(
MANHOM char(3) constraint Pk_MANHOM primary key,
TENNHOM nvarchar(30) not null,
SOLUONGSV smallint check (SOLUONGSV between 3 and 6),
MANHOMTRUONG char(4) not null
)
go
create table THANHTICH(
MATT char(4) primary key,
TENTT nvarchar(50) not null,
GHICHU nvarchar(100)
)
go
create table SINHVIEN(
MASV char(4) constraint Pk_MASV primary key,
TENSV nvarchar(50) not null,
MAKHOA char(3) constraint Fk_SV_KHOA references KHOA(MAKHOA) not null,
MANHOM char(3) constraint Fk_SV_NHOM references NHOM_SV(MANHOM) not null,
MADB char(3) constraint Fk_SV_DIABAN references DIABAN(MADB) not null,
MATT char(4) constraint Fk_SV_THANHTICH references THANHTICH(MATT) not null
)
go 
CREATE TABLE BANQUANLY (
MABQL char(5) CONSTRAINT Pk_MABQL PRIMARY KEY,
MADOITRUONG char(4) REFERENCES SINHVIEN(MASV) not null,
MADOIPHO char(4) REFERENCES SINHVIEN(MASV) not null
)
go
create table XA(
MAXA char(4) not null,
TENXA nvarchar(30) not null,
MADB char(3) constraint Fk_XA_DIABAN references DIABAN(MADB) not null,
MABQL char(5) constraint Fk_QUANLY_XA references BANQUANLY(MABQL) not null
primary key (MAXA, MADB)
)
go
create table GIAOVIEN(
MAGV char(4) constraint Pk_MAGV primary key,
TENGV nvarchar(50) not null,
MAKHOA char(3) constraint Fk_GIAOVIEN_KHOA references KHOA(MAKHOA) not null,
MABQL char(5) constraint Fk_GV_BQL references BANQUANLY(MABQL) not null
)
go
create table AP(
MAAP char(4) not null,
TENAP nvarchar(50) not null,
MAXA char(4) not null,
MADB char(3) not null,
constraint Fk_AP_XA foreign key (MAXA,MADB) references XA(MAXA,MADB),
primary key (MAAP,MAXA)
)
go
create table NHADAN(
MAND char(4) not null,
DIACHI nvarchar(50) not null,
TENCHUHO nvarchar(50) not null,
MAAP char(4) not null,
MAXA char(4) not null,
constraint Fk_NHADAN_AP foreign key (MAAP,MAXA) references AP(MAAP,MAXA),
MANHOM char(3) constraint Fk_NHANDAN_NHOM references NHOM_SV(MANHOM) not null,
primary key (MAND,MAAP)
)
go
create table CONGVIEC(
MACV char(4) constraint Pk_MACV primary key,
TENCV nvarchar(30) not null,
KHOILUONGCV smallint check (KHOILUONGCV between 1 and 3),
NGAYBD date not null,
NGAYKT date not null,
MAAP char(4) not null,
MAXA char(4) not null,
constraint Fk_CONGVIEC_AP foreign key (MAAP,MAXA) references AP(MAAP,MAXA)
)
go
create table BUOICV(
MACV char(4) constraint Fk_CV_BUOI references CONGVIEC(MACV) not null,
NGAYCV date not null,
BUOICV nvarchar(10) check (BUOICV in (N'sáng', N'chiều', N'tối')) not null,
CONSTRAINT PK_BUOICV PRIMARY KEY (MACV, BUOICV)
)
go
create table PHANCONG(
MANHOM char(3) not null,
MACV char(4) not null,
NGAYCV date not null,
BUOICV nvarchar(10) check (BUOICV in (N'Sáng', N'Chiều', N'Tối')) not null,
CONSTRAINT UQ_Nhom_Ngay_Buoi UNIQUE (MANHOM, NGAYCV, BUOICV),
FOREIGN KEY (MANHOM) REFERENCES NHOM_SV(MANHOM),
FOREIGN KEY (MACV) REFERENCES CONGVIEC(MACV),
FOREIGN KEY (MACV, BUOICV) REFERENCES BUOICV(MACV, BUOICV)
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
insert into NHOM_SV values
('N01', N'Nhóm 1',3, 'SV01'),
('N02', N'Nhóm 2',4, 'SV02'),
('N03', N'Nhóm 3',5, 'SV04'),
('N04', N'Nhóm 4',6, 'SV06'),
('N05', N'Nhóm 5',4, 'SV03'),
('N06', N'Nhóm 6',3, 'SV07'),
('N07', N'Nhóm 7',6, 'SV10'),
('N08', N'Nhóm 8',6, 'SV05'),
('N09', N'Nhóm 9',5, 'SV08'),
('N10', N'Nhóm 10',4, 'SV06')
go
insert into THANHTICH VALUES
('TT01', N'Hoàn thành xuất sắc nhiệm vụ', N'Sinh viên dẫn đầu nhóm trong việc xây nhà tình thương'),
('TT02', N'Tham gia đầy đủ', N'Tham dự đủ các buổi sinh hoạt và hoạt động tình nguyện'),
('TT03', N'Có sáng kiến tốt', N'Đề xuất mô hình “Đổi rác lấy cây xanh” tại địa phương'),
('TT04', N'Tích cực hỗ trợ nhóm', N'Luôn hỗ trợ đồng đội trong các hoạt động dọn dẹp môi trường'),
('TT05', N'Được dân khen ngợi', N'Nhận thư cảm ơn từ trưởng ấp vì giúp đỡ người dân sửa chữa nhà cửa')
go
insert into SINHVIEN values
('SV01', N'Nguyễn Văn An', 'K01','N01', 'DB1', 'TT01'),
('SV02', N'Trần Thị Bích', 'K02', 'N03', 'DB2', 'TT02'),
('SV03', N'Lê Văn Chung', 'K05', 'N05', 'DB3', 'TT03'),
('SV04', N'Phạm Thị Dung', 'K03', 'N02', 'DB4', 'TT04'),
('SV05', N'Võ Văn Nam', 'K07', 'N04', 'DB5', 'TT05'),
('SV06', N'Huỳnh Thị Linh', 'K04', 'N08', 'DB5', 'TT05'),
('SV07', N'Đỗ Văn Giàu', 'K08', 'N10', 'DB4', 'TT04'),
('SV08', N'Lý Thị Hoa', 'K06', 'N07', 'DB3', 'TT03'),
('SV09', N'Tống Văn Nhân', 'K10', 'N06', 'DB2', 'TT02'),
('SV10', N'Ngô Ngọc Trinh', 'K09', 'N09', 'DB1', 'TT01')
go
alter table NHOM_SV
add constraint Fk_SV_NHOMTRUONG foreign key (MANHOMTRUONG) references SINHVIEN(MASV)
go
insert into BANQUANLY values
('BQL01', 'SV01', 'SV05'),
('BQL02', 'SV02', 'SV04'),
('BQL03', 'SV03', 'SV03'),
('BQL04', 'SV04', 'SV02'),
('BQL05', 'SV05', 'SV01')
go
insert into XA values
('XA01', N'Xã Tân Phú Trung', 'DB1', 'BQL01'),
('XA02', N'Xã Phước Vĩnh An', 'DB2', 'BQL02'),
('XA03', N'Xã Trung Lập Hạ', 'DB3', 'BQL03'),
('XA04', N'Xã Bình Mỹ', 'DB4', 'BQL04'),
('XA05', N'Xã Nhơn Đức', 'DB5', 'BQL05')
go
insert into GIAOVIEN values
('GV01', N'Nguyễn Văn Nam','K01', 'BQL01'),
('GV02', N'Đỗ Thị Lan', 'K02', 'BQL02'),
('GV03', N'Lê Văn Hưng', 'K03', 'BQL03'),
('GV04', N'Nguyễn Thị Hoa', 'K04', 'BQL04'),
('GV05', N'Lê Văn Long', 'K05', 'BQL05'),
('GV06', N'Nguyễn Thị Yến', 'K06', 'BQL04'),
('GV07', N'Nguyễn Văn Tuấn', 'K07', 'BQL02'),
('GV08', N'Lê Thị Nhung', 'K08', 'BQL01'),
('GV09', N'Nguyễn Văn Đạt', 'K09', 'BQL03'),
('GV10', N'Nguyễn Thị Phượng', 'K10', 'BQL05')
go
insert into AP values
('AP01', N'Ấp 1', 'XA01', 'DB1'),
('AP02', N'Ấp 2', 'XA02', 'DB2'),
('AP03', N'Ấp 3', 'XA03', 'DB3'),
('AP04', N'Ấp 4', 'XA04', 'DB4'),
('AP05', N'Ấp 5', 'XA05', 'DB5'),
('AP06', N'Ấp 6', 'XA05', 'DB5'),
('AP07', N'Ấp 7', 'XA04', 'DB4'),
('AP08', N'Ấp 8', 'XA03', 'DB3'),
('AP09', N'Ấp 9', 'XA02', 'DB2'),
('AP10', N'Ấp 10','XA01', 'DB1')
go
insert into NHADAN values
('ND01', N'123 đường A', N'Nguyễn Văn A', 'AP01', 'XA01', 'N01'),
('ND02', N'456 đường B', N'Lê Thị B', 'AP05', 'XA05', 'N06'),
('ND03', N'78/9 đường C', N'Trần Văn C', 'AP03', 'XA03', 'N05'),
('ND04', N'101 đường D', N'Đỗ Thị D', 'AP08', 'XA03', 'N10'),
('ND05', N'202 đường A', N'Phạm Văn E', 'AP02', 'XA02', 'N03'),
('ND06', N'303F đường C', N'Huỳnh Văn G', 'AP09', 'XA02', 'N08')
go
INSERT INTO CONGVIEC VALUES
('CV01', N'Xây cầu bê tông', 1, '2025-06-01', '2025-06-10', 'AP01', 'XA01'),
('CV02', N'Sửa đường', 1, '2025-06-05', '2025-06-07', 'AP02', 'XA02'),
('CV03', N'Dọn vệ sinh', 1, '2025-06-03', '2025-06-05', 'AP03', 'XA03'),
('CV04', N'Phát quang bụi rậm', 1, '2025-06-04', '2025-06-06', 'AP04', 'XA04'),
('CV05', N'Trồng cây xanh', 1, '2025-06-07', '2025-06-08', 'AP05', 'XA05'),
('CV06', N'Dạy học thiếu nhi', 1, '2025-06-02', '2025-06-15', 'AP06', 'XA05'),
('CV07', N'Tuyên truyền bảo vệ môi trường', 1, '2025-06-09', '2025-06-09', 'AP07', 'XA04'),
('CV08', N'Phát tờ rơi phòng chống dịch', 1, '2025-06-10', '2025-06-10', 'AP08', 'XA03'),
('CV09', N'Tổ chức trò chơi cho trẻ em', 1, '2025-06-11', '2025-06-13', 'AP09', 'XA02'),
('CV10', N'Hỗ trợ tiêm vắc-xin', 1, '2025-06-14', '2025-06-15', 'AP10', 'XA01')
go
INSERT INTO BUOICV VALUES
('CV01', '2025-06-01', N'sáng'),
('CV02', '2025-06-02', N'chiều'),
('CV03', '2025-06-03', N'sáng'),
('CV04', '2025-06-04', N'tối'),
('CV05', '2025-06-05', N'chiều'),
('CV06', '2025-06-06', N'sáng'),
('CV07', '2025-06-07', N'tối'),
('CV08', '2025-06-08', N'sáng'),
('CV09', '2025-06-09', N'chiều'),
('CV10', '2025-06-10', N'sáng')
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
Select * from THANHTICH
Select * from SINHVIEN
Select * from BANQUANLY
Select * from XA
Select * from GIAOVIEN
Select * from AP
Select * from NHADAN
Select * from CONGVIEC
Select * from BUOICV
Select * from PHANCONG