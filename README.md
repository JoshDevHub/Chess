# Chess

A command line game of Chess built with Ruby

![Animated Chess Gif](https://raw.githubusercontent.com/JoshDevHub/Chess/main/media/example.gif)

## Description

This is a CLI program that allows two players to participate in a game of Chess. This was done as part of the curriculum at [TheOdinProject](https://theodinproject.com), an open source curriculum for learning web development. This project specifically is the final project in the Ruby curriculum and is meant to demonstrate the learner's proficiency with the language and various programming fundamentals.

The rules of Chess can be read about [here](https://en.wikipedia.org/wiki/Chess). Most of them have been implemented in my project, though not all (more on this in the Improvements section).

I learned a ton through the production of this. This is the first project where I used a factory pattern, a null object pattern, inheritance at a larger scale, ANSI escape sequences for coloring and manipulating terminal output, and too many subtleties to name regarding both the Ruby language and the RSpec testing framework.

## How to Play

The easiest way to play is to visit my REPL of this project on [replit](https://replit.com/@jmsmith1018/Chess#main.rb). Just press the RUN button and the script will start up.

You can also clone this repo and run it locally by simply typing `$ruby main.rb` from the project's root directory.

## The Rules of Chess

Chess is an abstract strategy board game. Two players, one controlling the white pieces and the other with the black pieces, compete against each other to see who can checkmate the other player's king. I've written up a brief glossary for people unfamiliar with the rules of the game, as understanding a lot of these rules will be important for understanding the features and playing the game as a user of this project:

#### **Bishop**
Each player is given two Bishop pieces to start the game. These pieces can move diagonally any number of uninterrupted squares.

#### **Capture**
Capturing is when a piece moves onto a square occupied by one of the opponent's pieces. When this occurs, the opponent's piece is said to be 'captured' or 'taken', and is removed from the board. There is a special case of capturing called En Passant Capture that doesn't involve two pieces of opposite colors on the same square.

#### **Castling**
Castling is a special move involving the King and one of the two Rooks. Three conditions must be met for this move to be possible:
1. The King and the participating Rook must not have moved off their initial squares at any point.
2. The squares between the King and the participating Rook must be empty.
3. The squares that the King travels through on the move, as well as the square the King currently stands on, must not be under attack by any enemy pieces.

If these conditions are met, then the player can employ a Castling move. This involves moving the King two squares in the direction of the participating Rook and moving the Rook to the square on the other side of the King from the Rook's perspective.

#### **Check**
A state of play where one's king is under attack. If you begin a turn in check, you must use this turn to escape it. Further, *any* move that would leave your king in check is considered illegal. If you have no move that would escape check, then you are considered to be Checkmated, and the game is over. If you are not currently in check but have no moves that would avoid it, then the game will end in a Stalemate.

#### **Checkmate**
Checkmate is the ultimate goal of the game, and it emerges from two conditions being fulfilled: a player's king is under attack (also known as being in 'Check') and the player has no way to escape this attack. When this happens, the game ends and the player delivering Checkmate is declared the winner.

#### **Draw**
A Draw is when neither player wins the match. This can emerge from a Stalemate, the Fifty-Move-Rule, Insufficient Material, or Repetitions.

#### **Draw-by-Repetition**
This is a drawn game state that gets declared when the exact same board position has been reached a certain number of times. The required number repetitions for envoking this rule is typically either 3 or 5, depending on the governing body for the competition. My game uses the 3-fold rule.

#### **En Passant Capture**
When a pawn makes a double move, it can be vulnerable to something called En Passant Capture during the opponent's following turn. If the opponent has a pawn directly adjacent to the left or right of a pawn that just made a double move, they can capture the pawn during this turn with a normal diagonal pawn capture move. This move can be confusing since unlike any other capture, the capturing piece and the captured piece aren't using the same square.

#### **Fifty-Move-Rule**
The fifty move rule is a rule where if the players get through fifty turns without a pawn advance or a piece capture, the game ends in a draw.

#### **Insufficient Material**
A drawn game state where neither player has enough pieces to checkmate the opposing King. An example of such a situation is King vs. King endgame, where it is impossible for either side to deliver checkmate. When games reach these positions, a draw is declared.

#### **King**
Each player is given one King, and it is the most important piece on the board. Checkmating the King is the key goal of the game, so its safety from the enemy pieces is vital to success. The King can move one square in any direction. Under certain circumstances, a King may also participate with a Rook in a Castling move.

#### **Knight**
Each player is given two Knight pieces to start the game. Despite their name, knights are traditionally depicted as horses. They have an unusual movement technique where they move two squares in a cardinal direction followed by a 90 degree turn and step to another square. This is often said to make a pattern like a capital 'L.' They are also the only piece that can 'jump' over pieces in their path while moving.

#### **Move**
Players take turns executing moves of their pieces. Each piece has a specific moveset that must be adhered to.

#### **Pawn**
Each player is given 8 Pawn pieces to the start the game. To the untrained eye, they seem like a simple piece, but their behavior varies more considerably than any other piece on the board. Pawns may move one square forward unless they are in their initial positions, where they can optionally move two squares forward. Pawns cannot capture enemy pieces directly in front of them, but they can capture on the two squares diagonally in front of them. They're also the only pieces involved in En-Passant capture and in the Promotion mechanic.

#### **Promotion**
If a pawn reaches the back rank on the opponent's side of the board, the player gets the option to 'promote' the pawn to a different piece. The player can choose a Queen, Rook, Bishop, or Knight.

#### **Queen**
Each player is given one Queen piece to begin the game. It is the most powerful piece in the game of Chess, and it is capable of moving any number of uninterrupted squares in all directions (vertically, horizontally, and diagonally).

#### **Rook**
Each player is given two Rooks (the castle shaped pieces) to start the game. They're considered very powerful pieces, capable of moving any number of continous, unblocked squares both vertically and horizontally along the board. Under certain cirumstances, they can also collaborate with the King in a move called 'Castling'.

#### **Square**
A single cell on the game board. There are 64 squares in total on a traditional chess board, and each of then is named according to their file(horizontal position) and rank(vertical position). A file is notated by the letters A-H and rank by numbers 1-8.

#### **Stalemate**
Stalemate is a game state where a player is not currently in Check but they begin their turn with no legal moves. When this happens, the game ends in a draw.

## Features

### Dual Move Interface

I included two options for users to choose from when it comes to moving their pieces:
1. The user can enter an origin square and a target square together in one line (eg. e2e4)
2. The user can enter an origin square followed by Enter/Return to get a list of moves to choose from for the piece at the origin square. The user can then enter the target square to execute their desired move.

So why did I do it this way? I did some light research with other Odin students' Chess projects (not looking at code, just playing and getting a feel for their UI/UX on the command line) and noticed that the 2nd option I listed above was the way just about everyone did it. I knew I wanted to build this interface for a couple of reasons:
1. It's friendly for users who don't know the ins and outs of Chess and how all the pieces move. It'll additionally be familiar to any Odin students who want to review my project and its code.
2. It presents a nice design challenge, particularly the aspect where I reprint the board with the move possibilities and captures highlighted to aide the user in visualizing their moves.

However, I am an experienced Chess player and have been playing the game since I was a kid. Anyone very familiar with the game and how the pieces move will find this interface clunky. So I also developed the move interface where you can just enter a move in one line, skipping the second step entirely to make for a smooth, uninterrupted user experience.

### Every Piece and Move

I've implemented every piece along with their unique movesets. This includes some of the more complicated and obscure moves, such as the pawn double move, en passant capture, castling, and pawn promotion. The game also accurately checks for move legality, preventing the players from doing things like moving a piece in a way that would leave their own King in check.

#### **Castling**

![demonstration of castling](https://raw.githubusercontent.com/JoshDevHub/Chess/main/media/castle_demo.gif)

Assuming the necessary criteria exist for a player to execute a castling move, players have the option of entering a castling square for their King to move to. If this move is chosen, the game will automatically move the participating Rook to the correct square.

#### **Check**

![image of a white king in check](https://raw.githubusercontent.com/JoshDevHub/Chess/main/media/check_image.png)

Players are alerted at the beginning of a turn if their King has been placed in check. The player doesn't have the option of using moves that do not escape the check, as this is considered an illegal move in Chess. Additionally, even if the player does not begin a turn in check, there can be situations where moving a piece could open up an attack on their King from an opponent piece. In accordance with the rules, these moves are also prevented by my game.
#### **En Passant Capture**

![gif demonstrating en passant](https://raw.githubusercontent.com/JoshDevHub/Chess/main/media/en_passant_demo.gif)

When a pawn double moves and ends on a square directly adjacent to an enemy pawn, the opponent can capture that pawn 'en passant' (in passing) for the next move. To execute this in my game, just move the attacking pawn to the square directly behind the pawn to be captured. The captured pawn will be removed from the board.

This capture has a slight UI difference compared to other capture moves. Usually capture squares are highlighted red, but this appears as a normal move. This is partially due to my implementation of capture squares making this highlighting difficult in this context, but there's also ambiguity here for which square should be highlighted. Should it be the square the captured pawn is on, or the square the attacking pawn is moving to? Hard to say, and the biggest chess sites -- [chess.com](https://chess.com) and [lichess.com](https://lichess.com) -- also highlight this as a 'normal' move in their UIs.
#### **Pawn Double Move**

![image of pawn double move option](https://raw.githubusercontent.com/JoshDevHub/Chess/main/media/double_pawn_move.png)

A pawn in its initial position can move two squares forward instead of one, assuming these squares are unobstructed by other pieces. My game will give players this option when the pawns are in their starting positions.

#### **Pawn Promotion**

![gif demonstrating pawn promotion](https://raw.githubusercontent.com/JoshDevHub/Chess/main/media/promotion_demo.gif)

When a pawn reaches the opponent's back rank, they'll get a message explaining promotion and a menu of pieces to choose from. After selecting one of these pieces, the pawn will be replaced by the chosen piece.

### Saving/Loading

While in the move selection interface, players have the option of typing `save` to save their game and resume it at a later time. The game is saved to one of five save slots in the `/saved_games` directory, and the save file will include the names of the participating players.

To load a previously saved game, a players just need to respond with `2` in the game's opening prompt. They will then get a list of saves to choose from and can select a game to resume.

### Win and Draw States

Most win and draw states have been implemented in my game. Checkmate, Stalemate, Fifty-Move Draws, and the Threefold-Repetition draw are all checked for. The game will end when one of these states is reached and a message will be sent to the player regarding which one has triggered the end of the game. If the game has ended in Checkmate, the display will also name the winner of the game.

The one draw state my game does not include is Insufficient Material. I would like to add this in eventually (see Improvements section).


## Improvements

1. General refactoring for readability and improved object orientation
2. Occasionally I had a disorganized work flow during the production of this. One thing that'd really help is making better use of git branches, something I intend to do for all future projects.
3. Possible Features
    - tracking move history
    - tracking material points
    - implementing draw by insufficient material