create or replace package ut_tennis
is

    PROCEDURE ut_setup;
    
    PROCEDURE ut_teardown;

    PROCEDURE ut_score_increase_std_point;

    PROCEDURE ut_score_deuce_advantage;

    PROCEDURE ut_score_winning_points;

END;
/

show err

create or replace package body ut_tennis
is

    type points_list is varray(12) of pls_integer;

    type scorecard is record (
        game_points             points_list,
        player1_name            varchar2(30),
        player2_name            varchar2(30)
    );

    function set_game_scorecard(
        game_points  in points_list,
        player1_name in varchar2,
        player2_name in varchar2
        )
    return scorecard
    is
        game_scorecard      scorecard;
    begin
        game_scorecard.game_points := game_points;
        game_scorecard.player1_name := player1_name;
        game_scorecard.player2_name := player2_name;
        return game_scorecard;
    end;

    function play_game(game_scorecard in scorecard) return tennis_game.id%type
    is

        game_id                 tennis_game.id%type;
        game_result             varchar2(100);
        total_points            pls_integer;
        point_winner_name       varchar2(30);

    BEGIN

        dbms_output.put_line('*******************************');

        game_id := tennis.new_game(game_scorecard.player1_name, game_scorecard.player2_name);

        dbms_output.put_line('game_id : ' || game_id);

        total_points := game_scorecard.game_points.count;
        dbms_output.put_line('Number of points : ' || total_points);

        for point in 1..total_points loop
            dbms_output.put_line('Point ' || point || ' won by player ' || game_scorecard.game_points(point));

            if game_scorecard.game_points(point) = 1 then
                point_winner_name := game_scorecard.player1_name;
            else
                point_winner_name := game_scorecard.player2_name;
            end if;

            tennis.mark_point(game_id, point_winner_name);

        end loop;

        tennis.end_game(game_id);

        return game_id;

    END play_game;

    PROCEDURE ut_setup
    IS
    BEGIN
         null;
    END;

    PROCEDURE ut_teardown
    IS
    BEGIN
         null;
    END;

    PROCEDURE ut_score_increase_std_point
    is
        game_id                 tennis_game.id%type;
    begin

       game_id := play_game(set_game_scorecard(points_list(),'Djoco','Roger'));

       utAssert.eq (
          'Should return "Love All" when game scorecard marks nothing',
          tennis.display_game_score(game_id),
          'Love All'
       );

       game_id := play_game(set_game_scorecard(points_list(1),'Djoco','Roger'));

       utAssert.eq (
          'Should return "Fifteen Love" when game scorecard marks player1',
          tennis.display_game_score(game_id),
          'Fifteen Love'
       );


       game_id := play_game(set_game_scorecard(points_list(2,2),'Djoco','Roger'));

       utAssert.eq (
          'Should return "Thirty Love" when game scorecard marks player2, player2',
          tennis.display_game_score(game_id),
          'Love Thirty'
       );


       game_id := play_game(set_game_scorecard(points_list(1,1,2,2),'Djoco','Roger'));

       utAssert.eq (
          'Should return "Thirty All" when game scorecard marks player1, player1, player2, player2',
          tennis.display_game_score(game_id),
          'Thirty All'
       );


       game_id := play_game(set_game_scorecard(points_list(1,2,1,2,2),'Djoco','Roger'));

       utAssert.eq (
          'Should return "Thirty Forty" when game scorecard marks player1, player2, player1, player2, player2',
          tennis.display_game_score(game_id),
          'Thirty Forty'
       );

    end;

    PROCEDURE ut_score_deuce_advantage
    is
        game_id                 tennis_game.id%type;
    begin

       game_id := play_game(set_game_scorecard(points_list(1,1,2,2,1,2,1,2),'Djoco','Roger'));

       utAssert.eq (
          'Should return "Deuce" when game scorecard marks player1, player1, player2, player2, player1, player2, player1, player2',
          tennis.display_game_score(game_id),
          'Deuce'
       );

       game_id := play_game(set_game_scorecard(points_list(1,1,2,2,1,2,1,2),'Djoco','Roger'));

       utAssert.eq (
          'Should return "Deuce" when game scorecard marks player1, player1, player2, player2, player1, player2, player1, player2',
          tennis.display_game_score(game_id),
          'Deuce'
       );

       game_id := play_game(set_game_scorecard(points_list(1,1,2,2,1,2,1),'Djoco','Roger'));

       utAssert.eq (
          'Should return "Advantage Djoco" when game scorecard marks player1, player1, player2, player2, player1, player2, player1',
          tennis.display_game_score(game_id),
          'Advantage Djoco'
       );

       game_id := play_game(set_game_scorecard(points_list(1,1,2,2,1,2,2),'Djoco','Roger'));

       utAssert.eq (
          'Should return "Advantage Roger" when game scorecard marks player1, player1, player2, player2, player1, player2, player2',
          tennis.display_game_score(game_id),
          'Advantage Roger'
       );

    end;

    PROCEDURE ut_score_winning_points
    is
        game_id                 tennis_game.id%type;
    begin

       game_id := play_game(set_game_scorecard(points_list(1,1,2,2,1,2,2,2),'Djoco','Roger'));

       utAssert.eq (
          'Should return "Roger wins" when game scorecard marks player1, player1, player2, player2, player1, player2, player2, player2',
          tennis.display_game_score(game_id),
          'Roger wins'
       );

       game_id := play_game(set_game_scorecard(points_list(1,1,2,1,1),'Djoco','Roger'));

       utAssert.eq (
          'Should return "Djoco wins" when game scorecard marks player1, player1, player2, player1, player1',
          tennis.display_game_score(game_id),
          'Djoco wins'
       );

    end;

END ut_tennis;
/

show err