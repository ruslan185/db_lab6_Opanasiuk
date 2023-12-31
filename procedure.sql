-- процедура має повертати різницю зароблених очок за штрафні двох гравців за їх іменами
create procedure calcFreeShotsDiff (name_player1 varchar, name_player2 varchar)
language plpgsql as $$
begin 
	raise notice 'Difference: %',
		abs((
			select free_shots
			from player
			left outer join playerstats on player.player_id = playerstats.player_id
			where player.player_name = name_player1
		) - (
			select free_shots
			from player
			left outer join playerstats on player.player_id = playerstats.player_id
			where player.player_name = name_player2
		));
end;
$$;

call calcFreeShotsDiff ('Kobe Bryant', 'Michael Jordan');