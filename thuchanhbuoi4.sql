use qlctrinh

--cau1
select TINHTHANH into tmp from CONGTRINH as A, CHUTHAU as B
where A.MSCT = B.MSCT and B.TENTHAU = 'Hoang Cong Binh'

select distinct A.HOTENKTS, A.NOITN from KIENTRUCSU as A, THIETKE as B, CONGTRINH as C, tmp as D
where A.MSKTS = B.MSKTS and B.STTCT = C.STTCT and C.TINHTHANH = D.TINHTHANH and A.HOTENKTS LIKE 'Le %'

drop table tmp

--cau2
select C.STTCT, C.TENCT, C.KINHPHI from KIENTRUCSU as A, THIETKE as B, CONGTRINH as C
where A.MSKTS = B.MSKTS and B.STTCT = C.STTCT
and YEAR(GETDATE())-YEAR(A.NGAYSINH) = (select MAX((YEAR(GETDATE())-YEAR(NGAYSINH))) from KIENTRUCSU)

--cau3
select A.MSKTS, A.HOTENKTS from KIENTRUCSU as A, THIETKE as B, CONGTRINH as C, CHUNHAN as D
where A.MSKTS = B.MSKTS and B.STTCT = C.STTCT and C.MSCH = D.MSCH
and D.DIACHICHU = '101 Hai Ba Trung'

--cau4
select A.MSCT, COUNT(A.STTCT) as SOLUONG into tmp from CONGTRINH as A, CHUTHAU as B
where A.MSCT = B.MSCT
group by A.MSCT
having COUNT(A.STTCT) >= 3

select distinct C.STTCT, C.TENCT, C.KINHPHI from KIENTRUCSU as A, THIETKE as B, CONGTRINH as C, tmp as D
where A.MSKTS = B.MSKTS and B.STTCT = C.STTCT and C.MSCT = D.MSCT
and YEAR(GETDATE())-YEAR(A.NGAYSINH) <= 40

drop table tmp

--cau5
select distinct A.MSCN, A.HOTENCN from CONGNHAN as A, THAMGIA as B, CONGTRINH as C
where A.MSCN = B.MSCN and B.STTCT = C.STTCT
group by A.MSCN, A.HOTENCN, C.TINHTHANH
having COUNT(C.TINHTHANH) >= 2

--cau6
select C.TINHTHANH, COUNT(A.MSCN) as SOLUONG into tmp from CONGNHAN as A, THAMGIA as B, CONGTRINH as C
where A.MSCN = B.MSCN and B.STTCT = C.STTCT
group by C.TINHTHANH

select TINHTHANH from tmp
where SOLUONG = (select MAX(SOLUONG) from tmp)

drop table tmp

--cau7
select C.TINHTHANH, B.THULAO into tmp from KIENTRUCSU as A, THIETKE as B, CONGTRINH as C
where A.MSKTS = B.MSKTS and B.STTCT = C.STTCT and A.HOTENKTS = 'Le Kim Dung'

select distinct TINHTHANH from tmp
where THULAO = (select MIN(THULAO) from tmp)

drop table tmp
--cau8

select distinct A.HOTENKTS, D.HOTENCN, C.TENCT 
from KIENTRUCSU as A, THIETKE as B, CONGTRINH as C, CONGNHAN as D, THAMGIA as E
where A.MSKTS = B.MSKTS and B.STTCT = C.STTCT
and D.MSCN = E.MSCN and E.STTCT = E.STTCT
and YEAR(GETDATE())-YEAR(A.NGAYSINH)>  YEAR(GETDATE())-YEAR(D.NGAYSINH)

--cau9
select A.MSCN, A.HOTENCN, COUNT(C.STTCT) as SLCT from CONGNHAN as A, THAMGIA as B, CONGTRINH as C
where A.MSCN = B.MSCN and B.STTCT = C.STTCT and MONTH(A.NGAYSINH) = 5
group by A.MSCN, A.HOTENCN

--cau10
select C.STTCT, C.TENCT, COUNT(A.MSCN) as SOLUONG into tmp 
from CONGNHAN as A, THAMGIA as B, CONGTRINH as C
where A.MSCN = B.MSCN and B.STTCT = C.STTCT
group by C.STTCT, C.TENCT
having COUNT(A.MSCN) > 2

select D.STTCT, D.TENCT, D.SOLUONG, COUNT(A.MSCN) as SLNAM, (D.SOLUONG-COUNT(A.MSCN)) as SLNU
from CONGNHAN as A, THAMGIA as B, CONGTRINH as C, tmp as D
where A.MSCN = B.MSCN and B.STTCT = C.STTCT and C.STTCT = D.STTCT 
and A.PHAI = 'Nam'
group by D.STTCT, D.TENCT, D.SOLUONG

drop table tmp



 
