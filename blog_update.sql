-- Age schema.sql run kora thakle ekhon eta run koro
alter table posts add column if not exists slug text unique;
alter table posts add column if not exists tags text;
