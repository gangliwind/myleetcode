SELECT n.Dname as Department ,m.Name as Employee , m.Salary as Salary
FROM Employee m,
(SELECT Salary,y.DepartmentId,x.Name as Dname 
from Department x left outer join 
                    (select DepartmentId,Salary,rank 
											from 
												(select heyf_tmp.DepartmentId,heyf_tmp.Salary,@rownum:=@rownum+1 ,
														if(@pdept=heyf_tmp.DepartmentId,@rank:=@rank+1,@rank:=1) as rank,@pdept:=heyf_tmp.DepartmentId
												from 
														(select   distinct  Salary,DepartmentId from Employee order by DepartmentId,Salary desc) heyf_tmp ,
														(select @rownum :=0 , @pdept := null ,@rank:=0) a 
											) result
										WHERE rank<=3) y
                    on x.Id = y.DepartmentId
) n
WHERE m.DepartmentId=n.DepartmentId and m.Salary=n.Salary