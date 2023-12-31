-- тригер який автоматично вставляє в таблицю team_id після наданню назви команди, а також інформує в консоль про успішність
create function addTeam()
returns trigger as $$
begin
	new.team_id := coalesce((select max(team_id) from team), 0) + 1;
	raise notice 'Команда додана успішно: ID = %, Назва = %', new.team_id, new.team_name;
	return new;
end;
$$ language plpgsql;

create trigger teamInsertTrigger
before insert on team
for each row
execute function addTeam();

insert into team (team_name) values ('Opanasiuk Ruslan Team');

select *
from team;