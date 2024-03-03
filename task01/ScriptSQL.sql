--Отримати всі завдання певного користувача. 
--Використайте SELECT для отримання завдань конкретного користувача за його user_id.
select * from tasks where user_id = 2


--Вибрати завдання за певним статусом. 
--Використайте підзапит для вибору завдань з конкретним статусом, наприклад, 'new'.
select * from tasks where status_id = (select id from status where "name" = 'new')



--Оновити статус конкретного завдання.
--Змініть статус конкретного завдання на 'in progress' або інший статус.
update tasks set status_id = (select id from status where "name" = 'in progress') where tasks.id = 8



--Отримати список користувачів, які не мають жодного завдання. 
--Використайте комбінацію SELECT, WHERE NOT IN і підзапит.
select * from users where id not in (select user_id from tasks)
 


--Додати нове завдання для конкретного користувача. 
--Використайте INSERT для додавання нового завдання.
insert into tasks (title,description,status_id, user_id)
values ('new task', 'abababalamaga', (select id from status where "name" = 'new'), 5)

--select * from tasks where user_id = 5

--Отримати всі завдання, які ще не завершено. 
--Виберіть завдання, чий статус не є 'завершено'.
select * from tasks where status_id in (select id from status where "name" <> 'completed')


--Видалити конкретне завдання. 
--Використайте DELETE для видалення завдання за його id.
delete from tasks where id = 1


--Знайти користувачів з певною електронною поштою. 
--Використайте SELECT із умовою LIKE для фільтрації за електронною поштою.
select * from users where email like 'd%'


--Оновити ім'я користувача. 
--Змініть ім'я користувача за допомогою UPDATE.
update users set fullname = 'Taras Berezovets' where id = 1


--Отримати кількість завдань для кожного статусу. 
--Використайте SELECT, COUNT, GROUP BY для групування завдань за статусами.
select count(tasks.id), status.name 
from tasks left join status on tasks.status_id = status.id 
group by status.name  


--Отримати завдання, які призначені користувачам з певною доменною частиною електронної пошти. 
--Використайте SELECT з умовою LIKE в поєднанні з JOIN, щоб вибрати завдання, призначені користувачам, 
--чия електронна пошта містить певний домен (наприклад, '%@example.com').
select * from tasks left join users on tasks.user_id = users.id 
where users.email like '%@example.net'


--Отримати список завдань, що не мають опису. Виберіть завдання, у яких відсутній опис.
select * from tasks where description = ''


--Вибрати користувачів та їхні завдання, які є у статусі 'in progress'. 
--Використайте INNER JOIN для отримання списку користувачів та їхніх завдань із певним статусом.
select *
from (
	select users.fullname, tasks.title, tasks.description, status.name
	from ((tasks
	inner join users on tasks.user_id = users.id )
	inner join status on tasks.status_id = status.id )
)
where name = 'in progress'


--Отримати користувачів та кількість їхніх завдань. 
--Використайте LEFT JOIN та GROUP BY для вибору користувачів та підрахунку їхніх завдань.
select users.fullname, count(tasks.id)
from tasks left join users on tasks.user_id = users.id 
group by users.fullname



