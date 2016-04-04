create or replace package tennis
is

    function new_game(player1_name in varchar2, player2_name in varchar2) return integer;

    procedure mark_point(game_id in integer, player_name in varchar2);

    procedure end_game(game_id in integer);

    function display_game_score(game_id in integer) return varchar2;

end tennis;
/

show err


create or replace package body tennis
is

    type t_score is varray(2) of number;

    function get_score(game_id in integer) return t_score;
    function game_is_won(game_score in t_score) return boolean;
    function get_game_winner(game_id in integer) return tennis_game.winner%type;
    function get_player_name(game_id in integer, player_index in integer) return varchar2;
    function render_score(game_id in integer) return varchar2;
    function evaluate_score(game_id in integer) return varchar2;

    procedure end_game(game_id in integer)
    is
        winner          tennis_game.winner%type;
    begin

        winner := get_game_winner(game_id);

        update tennis_game
        set end_date = sysdate,
            winner = end_game.winner
        where id = game_id
          and end_date is null;

    end;

    function new_game(player1_name in varchar2, player2_name in varchar2) return integer
    is
        game_id                 pls_integer := null;
    begin

        insert into tennis_game
            (
            id        ,
            start_date,
            player1   ,
            player2
            )
        values
            (
            tennis_seq.nextval,
            sysdate,
            player1_name,
            player2_name
            )
        returning id into game_id;

        return game_id;

    end;

    function get_score(game_id in integer) return t_score
    is
        game_score      t_score := t_score(0,0);
    begin

        dbms_output.put_line('get_score entree : ' || game_score(1) || ';' || game_score(2));

        select
            nvl(sum(player1_point),0),
            nvl(sum(player2_point),0)
          into
            game_score(1),
            game_score(2)
          from
            tennis_point
         where
            game_id = get_score.game_id;

        dbms_output.put_line('get_score : ' || game_score(1) || ';' || game_score(2));

        return game_score;

    end;

    function game_is_won(game_score in t_score) return boolean
    is
    begin

        if (game_score(1) >= 4 or game_score(2) >= 4)
            and
           (abs(game_score(1) - game_score(2)) >= 2)
        then
            return true;
        else
            return false;
        end if;

    end;

    function get_game_winner(game_id in integer) return tennis_game.winner%type
    is

        game_score          t_score := t_score();
        winner              tennis_game.winner%type := null;

    begin

        game_score := get_score(game_id);

        if game_is_won(game_score)
        then

            if game_score(1) > game_score(2)
            then
                winner := get_player_name(game_id, 1);
            else
                winner := get_player_name(game_id, 2);
            end if;

        end if;

        return winner;

    end;

    function get_player_name(game_id in integer, player_index in integer) return varchar2
    is
       player1_name        tennis_game.player1%type;
       player2_name        tennis_game.player2%type;

    begin

         select
                player1,
                player2
           into
                player1_name,
                player2_name
           from
                tennis_game
          where id = game_id;

         if player_index = 1
         then 
               return player1_name;
         else
               return player2_name;
         end if;

    end;

    function render_score(game_id in integer) return varchar2
    is

       game_score             t_score := t_score();

       RENDER_0               constant varchar2(4) := 'Love';
       RENDER_1               constant varchar2(7) := 'Fifteen';
       RENDER_2               constant varchar2(6) := 'Thirty';
       RENDER_3               constant varchar2(5) := 'Forty';

       function render_standard_point return varchar2
       is
          player1_rendered_score          varchar2(15) := null;
          player2_rendered_score          varchar2(15) := null;
       begin 

          case game_score(1) when 0 then player1_rendered_score := RENDER_0;
                                when 1 then player1_rendered_score := RENDER_1;
                                when 2 then player1_rendered_score := RENDER_2;
                                when 3 then player1_rendered_score := RENDER_3;
               else null;
          end case;

          case game_score(2) when 0 then player2_rendered_score := RENDER_0;
                                when 1 then player2_rendered_score := RENDER_1;
                                when 2 then player2_rendered_score := RENDER_2;
                                when 3 then player2_rendered_score := RENDER_3;
               else null;
          end case;
         
          if game_score(1) = game_score(2) then
             return player1_rendered_score || ' All';
          else
             return player1_rendered_score || ' ' || player2_rendered_score;
          end if;

       end render_standard_point;

       function render_special_point return varchar2
       is

          rendered_special_point          varchar2(30) := null;
          diff                            pls_integer := null;

       begin 

          diff := game_score(1) - game_score(2);

          case when diff = 0 then rendered_special_point := 'Deuce';
               when diff = 1 then rendered_special_point := 'Advantage ' || get_player_name(game_id, 1);
               when diff = -1 then rendered_special_point := 'Advantage ' || get_player_name(game_id, 2);
               when diff >= 2 then rendered_special_point := get_player_name(game_id, 1) || ' wins';
               when diff <= -2 then rendered_special_point := get_player_name(game_id, 2) || ' wins';
               else null;
          end case;
         
          return rendered_special_point;

       end render_special_point;

    begin

        game_score := get_score(game_id);

        if game_score(1) >= 4 or game_score(2) >= 4
        then
            return render_special_point;
        else
           return render_standard_point;
        end if;

    end;

    function evaluate_score(game_id in integer) return varchar2
    is

        game_score          t_score := t_score();
        score_plain_text    varchar2(100) := null;

    begin

        game_score := get_score(game_id);

        if game_is_won(game_score)
        then
            dbms_output.put_line('Game is won');
            score_plain_text := render_score(game_id);
            end_game(game_id);
            return score_plain_text;
        end if;

        dbms_output.put_line(game_score(1)||':'||game_score(2));

        return score_plain_text;

    end;

    procedure mark_point(game_id in integer, player_name in varchar2)
    is
        game_score      varchar2(100) := null;
    begin

        insert into tennis_point
            (
            game_id       ,
            point_sort    ,
            player1_point ,
            player2_point
            )
        select
            mark_point.game_id,
            tennis_seq.nextval,
            decode(player1, player_name, 1, 0),
            decode(player2, player_name, 1, 0)
          from
            tennis_game
         where
            id = mark_point.game_id;

        game_score := evaluate_score(game_id);
                
    end;

    function display_game_score(game_id in integer) return varchar2
    is

        score_plain_text    varchar2(100) := null;

    begin

        score_plain_text := render_score(game_id);

        return score_plain_text;

    end;

end tennis;
/

show err