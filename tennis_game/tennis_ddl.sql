drop sequence tennis_seq;
drop table tennis_point;
drop table tennis_game;

create table tennis_game(
id                  integer,
    constraint pk_tennis_game primary key(id),
start_date          date,
end_date            date,
player1             varchar2(30),
player2             varchar2(30),
winner              varchar2(30)
)
;

create table tennis_point(
game_id             integer not null,
    constraint fk_tennis_point_game_id foreign key(game_id) references tennis_game(Id),
point_sort          integer not null,
player1_point       integer not null,
    constraint ck_tp_play1_pts check(player1_point in (0,1)),
player2_point       integer not null,
    constraint ck_tp_play2_pts check(player2_point in (0,1))
)
;

create sequence tennis_seq;

/*
var game_id number
call tennis.new_game('Djoko','Roger') into :game_id;
print game_id
select * from tennis_game;

var mark_ret varchar2
call tennis.mark_point(1,'Djoko') into :mark_ret;
print mark_ret
select * from tennis_point;
*/