#!/bin/bash
# upload files or data
curl -O -L https://raw.githubusercontent.com/FariusGitHub/API_database/main/add_data.sh
curl -O -L https://raw.githubusercontent.com/FariusGitHub/API_database/main/flask_app.py
curl -O https://raw.githubusercontent.com/FariusGitHub/API_database/main/bootstrap.html

# INSTALL MYSQL
sudo apt update
sudo apt install mysql-server -y
sudo systemctl start mysql
sudo systemctl enable mysql

# INSTALL PYTHON AND ASSOCIATED LIBRARIES
sudo apt update
sudo apt upgrade -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt install python3.10 -y
sudo apt install python3-pip -y
pip install flask
pip install mysql-connector-python

# CREATE NEW USER farius
sudo mysql -u root <<EOF
USE mysql;
CREATE USER 'farius'@'localhost' IDENTIFIED BY 'Project5';
GRANT ALL PRIVILEGES ON *.* TO 'farius'@'localhost';
FLUSH PRIVILEGES;
exit
EOF

# CREATE nhl TABLE AND LOAD DATA
mysql -u farius -pProject5 <<EOF
USE mysql;
CREATE TABLE nhl (
    PlayerName VARCHAR(25),
    Team VARCHAR(3),
    Pos VARCHAR(2),
    Games INT,
    GOverall INT,
    AOverall INT,
    Pts INT,
    PlusMinus INT,
    PIM INT,
    SOG INT,
    GWG INT,
    GPP INT,
    APP INT,
    GSH INT,
    ASH INT,
    Hits INT,
    BS INT
);

INSERT INTO nhl (PlayerName, Team, Pos, Games, GOverall, AOverall, Pts, PlusMinus, PIM, SOG, GWG, GPP, APP, GSH, ASH, Hits, BS) VALUES
('Connor McDavid', 'EDM', 'C', 82, 64, 89, 153, 22, 36, 352, 11, 21, 50, 4, 3, 89, 40),
('David Pastrnak', 'BOS', 'RW', 82, 61, 52, 113, 34, 38, 407, 13, 18, 19, 0, 0, 91, 33),
('Mikko Rantanen', 'COL', 'RW', 82, 55, 50, 105, 15, 82, 306, 9, 13, 24, 0, 0, 77, 41),
('Leon Draisaitl', 'EDM', 'C', 80, 52, 76, 128, 7, 24, 247, 11, 32, 30, 1, 1, 66, 40),
('Brayden Point', 'TB', 'C', 82, 51, 44, 95, 2, 7, 235, 9, 20, 10, 0, 0, 37, 37),
('Tage Thompson', 'BUF', 'C', 78, 47, 47, 94, 4, 39, 295, 7, 20, 14, 1, 0, 55, 26),
('Jason Robertson', 'DAL', 'LW', 82, 46, 63, 109, 37, 20, 313, 7, 13, 28, 0, 0, 57, 19),
('Jack Hughes', 'NJ', 'C', 78, 43, 56, 99, 10, 6, 336, 6, 9, 22, 0, 0, 12, 30),
('Alex Ovechkin', 'WAS', 'LW', 73, 42, 33, 75, -16, 48, 294, 3, 14, 11, 0, 0, 188, 23),
('Mark Scheifele', 'WPG', 'C', 81, 42, 26, 68, -16, 43, 206, 10, 12, 10, 0, 0, 50, 38),
('Nathan MacKinnon', 'COL', 'C', 71, 42, 69, 111, 29, 30, 366, 9, 12, 22, 0, 0, 53, 40),
('Carter Verhaeghe', 'FLA', 'C', 81, 42, 31, 73, 10, 46, 275, 2, 7, 6, 0, 0, 29, 31),
('Adrian Kempe', 'LA', 'C', 82, 41, 26, 67, 22, 55, 250, 6, 11, 9, 3, 0, 119, 32),
('William Nylander', 'TOR', 'C', 82, 40, 47, 87, 10, 28, 293, 5, 9, 19, 0, 0, 18, 26),
('Jared McCann', 'SEA', 'LW', 79, 40, 30, 70, 18, 14, 210, 3, 7, 9, 3, 0, 65, 28),
('Timo Meier', 'NJ', 'LW', 78, 40, 26, 66, -19, 43, 327, 5, 17, 6, 0, 0, 154, 37),
('Kirill Kaprizov', 'MIN', 'LW', 67, 40, 35, 75, 4, 35, 261, 6, 17, 15, 0, 0, 66, 28);
exit;
EOF
