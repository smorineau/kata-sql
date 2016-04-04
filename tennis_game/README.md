# Tennis Kata

Tennis is a ball and racquet game that is scored in an interesting way. Instead of scoring the game using consecutive integers to denote number of points won by the players, it uses the scoring system : Love (0), Fifteen (15), Thirty (30), Forty (40), and All to denote equality. The rules as described by Wikipedia are: 

1. A game is won by the first player to have won at least four points in total and at least two points more than the opponent.

2. The running score of each game is described in a manner peculiar to tennis: scores from zero to three points are described as "love", "fifteen", "thirty", and "forty" respectively.

3. If at least three points have been scored by each player, and the scores are equal, the score is "deuce".

4. If at least three points have been scored by each side and a player has one more point than his opponent, the score of the game is "advantage" for the player in the lead.

## Feature : Scoring a Game in Real Time

We want a program that can be used to score a game in real time. To begin with, we're going to need a way to :

* update the score when a player wins a point
* see what the current score is at any time
* know if there is a winner based on the current score and the rules above.

## Examples

Given the score is Love All (0:0)
When the server wins a point
Then the score is Fifteen Love (15:0)

Given the score is Thirty Fifteen (30:15)
When the server wins a point
Then the score is Forty Love (40:15)

Given the score is Forty All (40:40)
When the receiver wins a point
Then the score should be Advantage receiver

Given the score is Advantage server
When the receiver wins a point
Then the score should be Deuce

Given the score is Forty Thirty (40:30)
When the server wins a point
Then the server should win
