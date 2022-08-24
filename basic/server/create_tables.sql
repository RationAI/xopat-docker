alter user postgres with password 'postgres';
create database annotations_db;
​
\c annotations_db
​
create table if not exists annotations (
    id serial primary key,
    tissue_id integer,
    data varchar
);
​
create table if not exists tissues (
    id serial primary key,
    path varchar unique not null,
    abs_path varchar unique
);
​
alter table annotations
add constraint fk_tissues
foreign key (tissue_id) references tissues(id);
​