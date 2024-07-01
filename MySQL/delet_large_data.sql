create table animal(
    id int(11) not NULL AUTO_INCREMENT,
    name varchar(20) DEFAULT NULL,
    age int(11) DEFAULT NULL,
    PRIMARY KEY (id)
)engine=InnoDB AUTO_INCREMENT=1 DEFAULT CHARASET=utf8 collate=utf8_bin;

INSERT INTO `pilipa_dds`.`student` (`id`, `name`, `age`) VALUES ('1', 'cat', '12');
INSERT INTO `pilipa_dds`.`student` (`id`, `name`, `age`) VALUES ('2', 'dog', '13');
INSERT INTO `pilipa_dds`.`student` (`id`, `name`, `age`) VALUES ('3', 'camel', '25');
INSERT INTO `pilipa_dds`.`student` (`id`, `name`, `age`) VALUES ('4', 'cat', '32');
INSERT INTO `pilipa_dds`.`student` (`id`, `name`, `age`) VALUES ('5', 'dog', '42');

--
select name,count(1)
from student
group by name
having count(1) > 1;

-- error
delete
from student
where name in(
    select name
    from student
    group by name
    having count(1)>1
)


-- optimize
select *
from student
where id not in (
    select t.id
    from (select min(id) as id from student group by name) t
)


delete
from student
where id not in(
    select t.id 
    from (select min(id) as id from sudent group by name )t
);







