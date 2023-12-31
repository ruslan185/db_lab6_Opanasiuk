CREATE TABLE Player
(
  player_id INT NOT NULL,
  player_name VARCHAR NOT NULL,
  pos VARCHAR NOT NULL,
  PRIMARY KEY (player_id)
);

CREATE TABLE PlayerStats
(
  rank_id INT NOT NULL,
  player_id INT NOT NULL,
  total_points INT NOT NULL,
  total_games INT NOT NULL,
  points_per_game INT NOT NULL,
  three_points_goals INT NOT NULL,
  free_shots INT NOT NULL,
  field_goals INT NOT NULL,
  PRIMARY KEY (rank_id),
  FOREIGN KEY (player_id) REFERENCES Player(player_id)
);

CREATE TABLE Team
(
  team_name VARCHAR NOT NULL,
  team_id INT NOT NULL,
  PRIMARY KEY (team_id)
);

CREATE TABLE PlayersInTeams
(
  player_id INT NOT NULL,
  team_id INT NOT NULL,
  PRIMARY KEY (player_id, team_id),
  FOREIGN KEY (player_id) REFERENCES Player(player_id),
  FOREIGN KEY (team_id) REFERENCES Team(team_id)
); 
