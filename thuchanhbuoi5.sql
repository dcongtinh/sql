use qlctrinh

--cau1
select A.MSCN, A.HOTENCN, C.TENCT into tmp
from CONGNHAN as A, THAMGIA as B, CONGTRINH as C
where A.MSCN = B.MSCN and B.STTCT = C.STTCT

select A.MSCN, A.HOTENCN, B.TENCT from CONGNHAN  as A
left join tmp as B
on A.MSCN = B.MSCN

drop table tmp
--cau2
select A.MSCN, A.HOTENCN from CONGNHAN as A
except
	(select A.MSCN, A.HOTENCN
	from CONGNHAN as A, THAMGIA as B, CONGTRINH as C
	where A.MSCN = B.MSCN and B.STTCT = C.STTCT)
	
--cau3
select C.STTCT, C.TENCT, COUNT(A.MSCN) as SOLUONG into tmp
from CONGNHAN as A, THAMGIA as B, CONGTRINH as C
where A.MSCN = B.MSCN and B.STTCT = C.STTCT
group by C.STTCT, C.TENCT

select A.STTCT, A.TENCT, B.SOLUONG from CONGTRINH as A
left join tmp as B on A.STTCT = B.STTCT
drop table tmp

--cau4
select A.MSCN, A.HOTENCN, COUNT(C.STTCT) as SOLUONG into tmp
from CONGNHAN as A, THAMGIA as B, CONGTRINH as C
where A.MSCN = B.MSCN and B.STTCT = C.STTCT
group by A.MSCN, A.HOTENCN

select A.MSCN, A.HOTENCN, B.SOLUONG from CONGNHAN  as A
left join tmp as B
on A.MSCN = B.MSCN

drop table tmp
--cau5
select A.MSKTS, A.HOTENKTS, A.NOITN from KIENTRUCSU as A
except
select A.MSKTS, A.HOTENKTS, A.NOITN from KIENTRUCSU as A, THIETKE as B, CONGTRINH as C
where A.MSKTS = B.MSKTS and B.STTCT = C.STTCT

--cau6
select A.MSCT, A.TENCT from CONGTRINH as A
where A.KINHPHI >3500
except
select C.MSCT, C.TENCT from KIENTRUCSU as A, THIETKE as B,CONGTRINH as C
where A.MSKTS = B.MSKTS and B.STTCT = C.STTCT and C.KINHPHI > 3500

--cau7
select A.MSCH, A.TENCHU as SOLUONG from CHUNHAN as A
except
select A.MSCH, A.TENCHU as SOLUONG from CHUNHAN as A, CONGTRINH as B, CONGNHAN as C, THAMGIA as D
where A.MSCH = B.MSCH and C.MSCN = D.MSCN and D.STTCT = B.STTCT
group by A.MSCH, A.TENCHU

--cau8
select A.MSCN, A.HOTENCN, A.NGAYSINH into tmp from CONGNHAN as A
except
	(select A.MSCN, A.HOTENCN, A.NGAYSINH
	from CONGNHAN as A, THAMGIA as B, CONGTRINH as C
	where A.MSCN = B.MSCN and B.STTCT = C.STTCT) 
	
select MSCN, HOTENCN from tmp
where YEAR(NGAYSINH) = (select MAX(YEAR(NGAYSINH)) from tmp)

drop table tmp

--cau9
select distinct A.MSCT, A.TENTHAU from CHUTHAU as A, CONGTRINH as B
where A.MSCT = B.MSCT and B.TINHTHANH = 'Can Tho'

--cau10