select * from portfolio_project..Data1;

select * from portfolio_project..Data2;

--populaton of india

select sum(population) as population from portfolio_project..Data2;


--dataset for rajasthan and gujrat

select * from portfolio_project..Data1 where state in ('Rajasthan', 'Gujarat');


--overall average growth

select AVG(growth)*100 as Avg_growth from portfolio_project..Data1;


--average growth per states

select state, AVG(growth)*100 as Avg_growth from portfolio_project..Data1 group by state;


--average sex ratio per state

select state, round(AVG(sex_ratio), 0) as Avg_sex_ratio from portfolio_project..Data1 group by state;


--top 5 state showing highest average growth rate

select top 5 state , AVG(growth)*100 as Avg_growth from portfolio_project..Data1 group by state order by Avg_growth desc;


--bottom 3 state showing lowest average sex ratio

select top 3 state, round(AVG(sex_ratio), 0) as Avg_sex_ratio from portfolio_project..Data1 group by state order by Avg_sex_ratio;


 
 -- states having average literacy rate>70

 select state, round(AVG(literacy), 0) as Avg_literacy from portfolio_project..Data1 group by state having round(AVG(literacy), 0)>70 order by Avg_literacy desc;



 --top and bottom 3 states with average literacy
 

 drop table if exists #topstates
 create table #topstates
 ( state nvarchar(255),
 topstates float

 )

 insert into #topstates
 select top 3 state, round(AVG(literacy), 0) as Avg_literacy from portfolio_project..Data1 group by state order by Avg_literacy desc;

 select * from #topstates;



  drop table if exists #bottomstates
 create table #bottomstates
 ( state nvarchar(255),
 bottomstates float

 )

 insert into #bottomstates
 select top 3 state, round(AVG(literacy), 0) as Avg_literacy from portfolio_project..Data1 group by state order by Avg_literacy;

 select * from #bottomstates;


 --union operator

 select * from (select * from #topstates) a

 union

select* from (select * from #bottomstates) b;




--states starting with letter a or b

select distinct state from portfolio_project..Data1 where state like 'a%' or state like 'b%'; 


--states starting with r and ending with n

select distinct state from portfolio_project..Data1 where state like 'r%' and state like '%n';




--joining tables and calculating number of male and female

select c.district, c.state, round(population/(sex_ratio+1), 0) males, round((population*sex_ratio)/(sex_ratio+1), 0) females from
(select a.district, a.state, sex_ratio/1000 sex_ratio, population from portfolio_project..Data1 a inner join portfolio_project..Data2 b on a.district = b.district) c;



--calculating total literate and illiterate people

select d.district, d.state, round(literacy*population, 0) literate_people, round((1-literacy)*population, 0) illerate_people from
(select a.district, a.state, literacy/100 literacy, population from portfolio_project..Data1 a inner join portfolio_project..Data2 b on a.district = b.district) d;



--population in previous census by state

select d.state, sum(previous_population) previous_population, sum(current_population) current_population from
(select c.state, c.district, round(population/(1+growth), 0) previous_population, population current_population from
(select a.state, a.district, growth, population from portfolio_project..Data1 a inner join portfolio_project..Data2 b on a.district = b.district) c) d group by d.state;



--top 3 district in each state by literacy rate

select a. * from
(select state, district, rank() over(partition by state order by literacy desc) rank from portfolio_project..Data1) a where rank in (1, 2, 3);