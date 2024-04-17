-- create table student
-- (
--     id         serial primary key,
--     first_name varchar(50),
--     age        int
-- );
--
-- insert into student(first_name, age)
-- values ('Yzaat', 18);
-- values ('Nurmuhammed', 25);
-- values ('Adyl', 18);
-- values ('Sultan-Ali', 20);
--
-- select avg(age) or min(age)
-- from student;
--
-- select *
-- from student
-- where age < (select avg(age) from student);
--
-- create table developers
-- (
--     id                   serial primary key,
--     programming_language varchar[]
-- );
--
-- insert into developers(programming_language)
-- values ('{"Java", "JavaScript", "c#"}');
--
-- select *
-- from developers;
--
-- select programming_language[2:3]
-- from developers;
--
-- select programming_language[100]
-- from developers;
--
-- update developers
-- set programming_language[4] = 'Python';
-- update developers
-- set programming_language[100] = 'C++';
--
-- drop table student;
--
-- create type gender as enum ('MALE','FEMALE');
--
-- create type course as enum ('Java','JavaScript');
--
-- create table if not exists student
-- (
--     id     serial primary key,
--     name   varchar,
--     gender gender
-- );
--
--
-- alter table student
--     add column course course;
--
-- alter type course add value 'Python';
--
-- drop type course cascade;
--
-- alter type gender drop attribute = 'MALE';


CREATE TABLE users
(
    id        SERIAL PRIMARY KEY,
    username  VARCHAR(100) UNIQUE,
    email     VARCHAR(100) UNIQUE,
    join_date DATE,
    country   VARCHAR(100)
);

CREATE TABLE projects
(
    id           SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    description  TEXT,
    created_date DATE,
    user_id      INT REFERENCES users (id)
);


CREATE TABLE comments
(
    id           SERIAL PRIMARY KEY,
    comment_text TEXT,
    comment_date DATE,
    user_id      INT REFERENCES users (id),
    project_id   INT REFERENCES projects (id)
);

INSERT INTO users (username, email, join_date, country)
VALUES ('adyl_tolomushov', 'adyl@gmail.com', '2023-01-01', 'USA'),
       ('nurkyz_adilbekova', 'nurkyz.dev@gmail.com', '2023-02-05', 'Canada'),
       ('nurmuhammed_akimbekov', 'nurmuhammed.dev@gmail.com', '2023-03-10', 'Kyrgyzstan'),
       ('sabina_malikova', 'sabina.dev@gmail.com', '2023-04-15', 'Australia'),
       ('baktur_temirbekov', 'bektur@gmail.com', '2023-05-20', 'Germany'),
       ('eldiyar_avazbekov', 'eldiyar.dev@gmail.com', '2024-04-16', 'Kazakstan'),
       ('bekanzar_zholdoshbekov', 'beknazar.dev@gmail.com', '2023-01-20', 'China'),
       ('kudaiberdi_gapurov', 'kudaiberdi@gmail.com', '2024-02-03', 'France');


INSERT INTO projects (project_name, description, created_date, user_id)
VALUES ('Customer Relationship Management System', 'Description of Project 1', '2023-01-05', 5),
       ('Task Management', 'Description of Project 2', '2023-02-10', 4),
       ('LMS', 'Description of Project 3', '2023-03-15', 3),
       ('Online Marketplace Platform"', 'Description of Project 4', '2023-04-20', 2),
       ('Social Media ', 'Description of Project 5', '2023-05-25', 1);



INSERT INTO comments (comment_text, comment_date, user_id, project_id)
VALUES ('Comment 1 on Project 1', '2023-01-10', 2, 1),
       ('Comment 2 on Project 1', '2023-01-15', 3, 1),
       ('Comment 1 on Project 2', '2023-02-20', 4, 2),
       ('Comment 1 on Project 3', '2023-03-25', 5, 3),
       ('Comment 1 on Project 4', '2023-04-30', 1, 4),
       ('Comment 2 on Project 4', '2023-05-05', 2, 3),
       ('Comment 1 on Project 5', '2023-05-10', 3, 5),
       ('Comment 2 on Project 5', '2023-05-15', 4, 5),
       ('Comment 3 on Project 5', '2023-05-20', 5, 5),
       ('Comment 4 on Project 5', '2023-05-25', 1, 5);



-- 1. Колдонуучулардын бардык атын жана электрондук почталарын алыңыз:
-- Получить все имена пользователей и адреса электронной почты пользователей:
select username, email
from users;

-- 2. Бардык проектердин аталыштарын жана сүрөттөмөлөрүн алыңыз:
-- Получите все названия и описания проектов:
select project_name, description
from projects;
-- 3. Бардык комментарий тексттерин жана даталарын алуу:
-- Получить все тексты комментариев и даты:
select comments.comment_text, comment_date
from comments;

-- 4. Ар бир комментарий үчүн колдонуучу атын жана проектин аттарын алыңыз:
--  Получите имена пользователей и названия проектов для каждого комментария:
select username, project_name
from comments c
         inner join projects p on p.id = c.project_id
         inner join users u on c.user_id = u.id;

-- 5. Проектти түзгөн колдонуучулардын атын жана өлкөлөрүн алыңыз:
-- Получите имена пользователей и страны пользователей, создавших проекты:
select u.username, u.country
from users u
         inner join projects p on p.user_id = u.id;

-- 6. Проектин аталыштарын жана сүрөттөмөлөрүн, ошондой эле аларды түзгөн колдонуучулардын аттары
-- менен алыңыз:
-- Получите названия и описания проектов, а также имена пользователей, которые их создали:
select p.project_name, p.description, u.username
from projects p
         inner join users u on p.user_id = u.id;

-- 7. Канадада жашаган колдонуучулар тарабынан түзүлгөн проекттин аттарын алыңыз:
-- Получите названия проектов, созданных пользователями из Канады:

select *
from projects p
where p.user_id in (select id from users where country = 'Kyrgyzstan');

select username, project_name, country
from projects p
         inner join users u on p.user_id = u.id
where u.country = 'Canada';


-- 8. "LMS" деп аталган проектке комментарий берген колдонуучулардын аттарын алыңыз:
-- Получите имена пользователей, оставивших комментарии к проекту «LMS»:
select username
from users u
where u.id in
      (select c.user_id
       from comments c
       where c.project_id in
             (select p.id from projects p where p.project_name like ('LMS')));


-- 9. "2023-03-15" кийин түзүлгөн проекттерге комментарий берген
-- колдонуучулардын атын жана электрондук почталарын алыңыз:
-- Получите имена пользователей и адреса электронной почты пользователей,
-- которые прокомментировали проекты, созданные после 15 марта 2023 г.
select id, username, email
from users u
where u.id in
      (select c.user_id
       from comments c
       where c.project_id in
             (select p.id from projects p where p.created_date > '2023-03-15'));

select u.username, email, p.created_date, project_name
from users u
         inner join comments c on u.id = c.user_id
         inner join projects p on p.id = c.project_id
where p.created_date > '2023-03-15';


-- 10. Комментарийлердин саны 2ден көп болгон проекттердин аталыштарын жана сүрөттөмөлөрүн алыңыз:
-- Получите названия и описания проектов, в которых количество     комментариев больше 2:
select project_name, description
from projects p
where p.id in (select c.project_id from comments c group by project_id having count(*) > 1);

select p.project_name, p.description, count(c.*) as comment_count
from comments c
         inner join projects p on c.project_id = p.id
group by p.project_name, p.description
having count(c.*) > 1;

-- 11. Эч бир проектке комментарий бербеген колдонуучулардын атын алуу:
-- Получите имена пользователей, которые не комментировали ни один проект:
select username
from users u
where u.id not in
      (select distinct c.user_id from comments c);

select u.username
from users u
         left join projects p on p.user_id = u.id;

-- 12. Канададан келген колдонуучулар тарабынан түзүлгөн проекттерге комментарий берген
-- колдонуучулардын атын алуу:
-- Получите имена пользователей, которые прокомментировали проекты, созданные пользователями из Канады:
select distinct u.username
from users u
where u.id in
      (select c.user_id
       from comments c
       where c.project_id in
             (select p.id
              from projects p
              where p.user_id in
                    (select id from users where u.country = 'Canada')));

select distinct u.username
from users u
         inner join comments c on u.id = c.user_id
         inner join projects p on c.project_id = p.id
where u.country = 'Canada';

-- 13. Колдонуучунун почталары "dev" камтылган проекттин аталыштарын жана сүрөттөмөлөрүн алыңыз:
-- Получите имена и описания проектов, где `почта` пользователя содержит «dev»:
select project_name, description
from projects p
where p.user_id
          in (select u.id
              from users u
              where u.email like '%dev%');


select project_name, description
from projects p
         inner join users u on p.user_id = u.id
where u.email ilike '%dev%';

-- 14. Колдонуучу сайтка кошулганга чейин проекттерге комментарий берген проектердин аталыштарын алыңыз:
-- Получите названия проектов, в которых пользователь прокомментировал проект перед тем,
-- как присоединиться к сайту:
select project_name, created_date
from projects p
where p.user_id in
      (select c.user_id
       from comments c
       where c.comment_date <=
             (select u.join_date from users u where p.user_id = u.id));



select project_name, join_date, comment_date
from projects p
         inner join comments c on p.id = c.project_id
         inner join users u on p.user_id = u.id
where u.join_date > c.comment_date;



























