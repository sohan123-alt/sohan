create table profile(id int primary key default 1,name text,title text,bio text,photo text,email text,github text,linkedin text,location text);
create table projects(id bigserial primary key,sort int default 0,title text,url text,github text,image text,description text,tech text,featured boolean default false);
create table skills(id bigserial primary key,sort int default 0,name text,category text,level int default 80);
create table experience(id bigserial primary key,sort int default 0,company text,logo text,role text,type text,start text,"end" text,description text);
create table education(id bigserial primary key,sort int default 0,school text,degree text,start text,"end" text,result text,description text);
create table papers(id bigserial primary key,sort int default 0,title text,authors text,venue text,year text,status text,abstract text,pdf text,doi text,tags text);
create table posts(id bigserial primary key,slug text unique,tags text,title text,cover text,excerpt text,body text,date text,published boolean default false);
create table messages(id bigserial primary key,name text,email text,message text,created_at timestamptz default now());
do $$ declare t text; begin
 foreach t in array array['profile','projects','skills','experience','education','papers','posts','messages'] loop
  execute format('alter table %I enable row level security',t);
  execute format('create policy "admin_all" on %I for all to authenticated using(true) with check(true)',t);
  if t not in ('posts','messages') then execute format('create policy "public_read" on %I for select using(true)',t); end if;
 end loop; end $$;
create policy "public_read" on posts for select using(published);
create policy "public_send" on messages for insert to anon with check(true);
