-- compression
select "column", type, encoding
from pg_table_def where tablename = 'usersauto' and schemaname='table_design_demo';

ANALYSE COMPRESSION usersauto;

create table users_custom_compression(
  userid integer not null distkey sortkey,
  username char(8) encode zstd,
  firstname varchar(30) encode zstd,
  lastname varchar(30) encode zstd,
  city varchar(30),
  state char(2),
  email varchar(100),
  phone char(14),
  likesports boolean,
  liketheatre boolean,
  likeconcerts boolean,
  likejazz boolean,
  likeclassical boolean,
  likeopera boolean,
  likerock boolean,
  likevegas boolean,
  likebroadway boolean,
  likemusicals boolean);

-- inserting records from users
insert into users_custom_compression
select * from users

select "column", type, encoding
from pg_table_def where tablename = 'users_custom_compression' and schemaname='table_design_demo';

ANALYSE COMPRESSION users_custom_compression;