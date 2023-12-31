import psycopg2
import pandas as pd

username = 'Ruslan'
password = '123'
database = 'lab6_DB'
host = 'localhost'
port = '5432'

data = pd.read_csv('nba.csv')
playerstats = data[['total_points', 'total_games', 'points_per_game', 'three_points_goals', 'free_shots', 'field_goals', 'player', 'position']]

all_teams = []
for el in data['teams']:
    for i in el.split('\n'):
        all_teams.append(i.split(' (')[0])
u_teams = sorted(list(set(all_teams)))

all_player = list(data['player'])

pit = data[['player', 'teams']]


conn = psycopg2.connect(user=username, password=password, dbname=database, host=host, port=port)
cur = conn.cursor()



for index in range(len(u_teams)):
    cur.execute("""
        INSERT INTO team (team_name,team_id)
        VALUES (%s, %s)
    """, (u_teams[index], index+1))

for index, row in playerstats.iterrows():
    cur.execute("""
        INSERT INTO player (player_id, player_name, pos)
        VALUES (%s, %s, %s)
        RETURNING player_id;
    """, (index+1, row['player'], row['position']))

    player_id = cur.fetchone()[0]

    cur.execute("""
        INSERT INTO playerstats (rank_id, total_points, total_games, points_per_game, three_points_goals, free_shots, field_goals, player_id)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s);
    """, (index + 1, row['total_points'], row['total_games'], row['points_per_game'], row['three_points_goals'], row['free_shots'], row['field_goals'], player_id))

for index, row in pit.iterrows():
    p = all_player.index(row['player'])+1
    for i in row['teams'].split('\n'):
        cur.execute("""
            INSERT INTO playersinteams (player_id, team_id)
            VALUES (%s, %s)
        """, (p, u_teams.index(i.split(' (')[0])+1))
        
conn.commit()

cur.close()
conn.close()
