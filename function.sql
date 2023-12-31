-- функція має повертати кількість зароблених очок за штрафні гравця за його іменем
create function getPlayerTotalFreeShots (name_player varchar)
returns int as $$
begin
	return (
	select free_shots
	from player
	left outer join playerstats on player.player_id = playerstats.player_id
	where player.player_name = name_player
	);
end;
$$ language plpgsql;

select getPlayerTotalFreeShots ('Kobe Bryant');