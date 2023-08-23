# SQL-project

## Data Source:

Table 1 = Data1

`District: nvarchar(255)
 State: nvarchar(255)
 Growth: float
 Sex_Ratio: float
 Literacy: float`

 Table 2 = Data2

 `District: nvarchar(255)
  State: nvarchar(255)
  Area_Km2: float
  Population: float`


  Q1. What is total population of india?

  `select sum(population) as population from portfolio_project..Data2;`

  Q2. Present the data related to Rajasthan and Gujarat.

  `select * from portfolio_project..Data1 where state in ('Rajasthan', 'Gujarat');`

  Q3. What is overall avgerage growth?

  `select AVG(growth)*100 as Avg_growth from portfolio_project..Data1;`

  Q4. What is average growth per state?

  `select state, AVG(growth)*100 as Avg_growth from portfolio_project..Data1 group by state;`

  Q5. What is average sex ratio per state?

  `select state, round(AVG(sex_ratio), 0) as Avg_sex_ratio from portfolio_project..Data1 group by state;`

  Q6. What are the top 5 states showing highest average growth rate?

  `select top 5 state , AVG(growth)*100 as Avg_growth from portfolio_project..Data1 group by state order by Avg_growth desc;`

  Q7. What are the bottom 3 states showing lowest average sex ratio?

  `select top 3 state, round(AVG(sex_ratio), 0) as Avg_sex_ratio from portfolio_project..Data1 group by state order by Avg_sex_ratio;`

  Q8. What are the states having average literacy rate>70?

   `select state, round(AVG(literacy), 0) as Avg_literacy from portfolio_project..Data1 group by state having round(AVG(literacy), 0)>70 order by Avg_literacy desc;`

   Q9. What are the top and bottom 3 states with average literacy rate?

   `drop table if exists #topstates
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

select * from (select * from #topstates) a

 union

select* from (select * from #bottomstates) b;`

Q10. What are the states starting with letter a or b?

`select distinct state from portfolio_project..Data1 where state like 'a%' or state like 'b%';`

Q11. What are the states starting with r and ending with n?

`select distinct state from portfolio_project..Data1 where state like 'r%' and state like '%n';`

Q12. Calculate the number of male and female.

`select c.district, c.state, round(population/(sex_ratio+1), 0) males, round((population*sex_ratio)/(sex_ratio+1), 0) females from
(select a.district, a.state, sex_ratio/1000 sex_ratio, population from portfolio_project..Data1 a inner join portfolio_project..Data2 b on a.district = b.district) c;`

Q13. Calculte the total literate and illerate people.

`select d.district, d.state, round(literacy*population, 0) literate_people, round((1-literacy)*population, 0) illerate_people from
(select a.district, a.state, literacy/100 literacy, population from portfolio_project..Data1 a inner join portfolio_project..Data2 b on a.district = b.district) d;`

Q14. What is the population in previous census per state?

`select d.state, sum(previous_population) previous_population, sum(current_population) current_population from
(select c.state, c.district, round(population/(1+growth), 0) previous_population, population current_population from
(select a.state, a.district, growth, population from portfolio_project..Data1 a inner join portfolio_project..Data2 b on a.district = b.district) c) d group by d.state;`

Q15. What are the top 3 district in each state by literacy rate?

`select a. * from
(select state, district, rank() over(partition by state order by literacy desc) rank from portfolio_project..Data1) a where rank in (1, 2, 3);`









  




`select AVG(growth)*100 as Avg_growth from portfolio_project..Data1;`
