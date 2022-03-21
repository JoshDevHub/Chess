# Chess

A command line game of Chess built with Ruby

![Screenshot of the word 'chess' in ascii text](https://raw.githubusercontent.com/JoshDevHub/Chess/main/media/intro_screenshot.png)

![Screenshot of the game board with pieces in starting positions](https://raw.githubusercontent.com/JoshDevHub/Chess/main/media/starting_board_image.png)

## Table of Contents
* [Description](#description)
* [Getting Started and Installing](#getting-started-and-installing)
* [Features](#features)
* [Potential Improvements](#potential-improvements)
* [Acknowledgements](#acknowledgements)

## Description

This is a CLI program that allows two players to participate in a game of Chess. This was done as part of the curriculum at [TheOdinProject](https://theodinproject.com), an open source curriculum for learning web development. This project specifically is the final project in the Ruby curriculum and is meant to demonstrate the learner's proficiency with the language and various programming fundamentals.

The rules of Chess can be read about [here](https://en.wikipedia.org/wiki/Chess). Most of them have been implemented in my project, though not all (more on this in the Improvements section).

I learned a ton through the production of this. This is the first project where I used a factory pattern, a null object pattern, inheritance at a larger scale, ANSI escape sequences for coloring and manipulating terminal output, and too many subtleties to name regarding both the Ruby language and the RSpec testing framework.

## Getting Started and Installing
### How to Play

The easiest way to play is to visit my REPL of this project on [replit](https://replit.com/@jmsmith1018/Chess#main.rb). Just press the RUN button and the script will start up.

If you have Ruby installed, you can also clone this repo and run it locally by simply typing `$ ruby main.rb` from the project's root directory.

### How to Run the Tests

You must clone the repo to run the tests, as I do not have replit setup to use RSpec 3.11. After cloning, `cd` into the root folder and run `$ bundle install` to install the project's dependencies. Then type `$ bundle exec rspec` to run the project's tests.

### The Rules of Chess

Chess is an abstract strategy board game. Two players, one controlling the white pieces and the other with the black pieces, compete against each other to see who can checkmate the other player's king. If you are unfamiliar with the rules of Chess, I recommend reading [Rules section of Chess's Wikipedia page](https://en.wikipedia.org/wiki/Chess#Rules). My Feature and Improvement section will assume some familiarity with many of the game's rules, such as the general flow of the game loop, each piece type and their move options, castling, en passant capture, pawn promotion, check, and various ways the game can end.

## Features

### Dual Move Interface

I included two options for users to choose from when it comes to moving their pieces:
1. The user can enter an origin square followed by Enter/Return to get a list of moves to choose from for the piece at the origin square. The user can then enter the target square to execute their desired move. The board is also reprinted with a black dot on empty squares the piece can move to, and red highlighting on squares where a piece can be captured. Users can type 'back' to be taken back to the origin selection menu in the event that they change their mind while looking through a piece's possible moves.
![gif of list interface](https://raw.githubusercontent.com/JoshDevHub/Chess/main/media/move_list_demo.gif)
2. The user can enter an origin square and a target square together in one line. For example, the move done above using the move list interface can instead be done by just typing `d5g2`
![gif of inline interface](https://raw.githubusercontent.com/JoshDevHub/Chess/main/media/move_inline_demo.gif)

So why did I do it this way? I did some light research with other Odin students' Chess projects (not looking at code, just playing and getting a feel for their UI/UX on the command line) and noticed that the 1st option I listed above was the way just about everyone did it. I knew I wanted to build this interface for a couple of reasons:
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

Players are alerted at the beginning of a turn if their King has been placed in check. The player doesn't have the option of using moves that do not escape the check, as these are considered illegal moves in Chess. Additionally, even if the player does not begin a turn in check, there can be situations where moving a piece could open up an attack on their King from an opponent piece. In accordance with the rules, these moves are also prevented by my game.
#### **En Passant Capture**

![gif demonstrating en passant](https://raw.githubusercontent.com/JoshDevHub/Chess/main/media/en_passant_demo.gif)

When a pawn double moves and ends on a square directly adjacent to an enemy pawn, the opponent can capture that pawn 'en passant' (in passing) for the next move. To execute this in my game, just move the attacking pawn to the square directly behind the pawn to be captured. The captured pawn will be removed from the board.

This capture has a slight UI difference compared to other capture moves. Usually capture squares are highlighted red, but this appears as a normal move. This is partially due to my implementation of capture squares making this highlighting difficult in this context, but there's also ambiguity here for which square should be highlighted. Should it be the square the captured pawn is on, or the square the attacking pawn is moving to? Hard to say, and the biggest chess sites -- [chess.com](https://chess.com) and [lichess.org](https://lichess.org) -- also highlight this as a 'normal' move in their UIs.
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


## Potential Improvements

There are definitely several improvements I want to make in the future, especially if I'm to include this in a portfolio. My main focus will be moving on in the Odin curriculum, where studying Rails awaits me. However, I do plan to schedule some time every week to review this project's codebase alongside other resources and ideate ways to accomplish some of the improvements listed here. When I have a good attack plan, I'll revisit the project to try implementing some of these changes.

### General Refactoring

I'd like to refactor certain sections of the code to be more elegant, readable, and object-oriented. Numerous aspects of my design could be improved, and my plan now is to review other Chess projects and study different patterns that I could possibly incorporate into my own project. Not only will this cleanup my codebase, but I think it'll be excellent practice with refactoring and design patterns. Hopefully I can also guide these refactorings in a way that makes adding the features in the Features to Add section more comfortable.

### Test Coverage

Although I do have around 400 total unit tests in this project, some components lack proper coverage. The big one is my `Chess` class, which integrates all of the project's classes together in service of running the game. Because this class is mostly about running scripts that query and command other classes, I feel that it would work better with integration testing, something I've yet to study. When I do get experience with integration testing, I'd like to come back and properly test this class.

### Work Flow

This is more of a lesson learned than something I can improve, but sometimes I suffered from a disorganized work flow during the production of this. Something I feel I could definitely make better use of is git branching. I mostly kept to just using the `main` branch for the development of this project, and it's more clear to me now the advantages of building on `dev` and `feature` branches. I intend to make better use of branches in my future projects and in this one should I return to it.

### Features to Add

A non-exhaustive list of features that could be fun to add in.

#### **Simple Computer Player**

Currently my game only works with humans controlling both players. A good potential feature would be to allow a human player to go against a simple computer AI. Now as I've said earlier, I'm pretty familiar with chess, so I know how deep the rabbit hole goes on developing chess engines. The best engines are capable of beating the best human players in the world, and they're products of vast amounts of work and research. Any AI I build would be very simple in comparison, possibly as simple as just getting the computer to pick randomly from among its legal moves. But even this would give a single user playing my game more entertainment than just playing against themselves.
#### **Tracking Material**

One component of the UIs on the two big Chess sites -- [chess.com](https://chess.com) and [lichess.org](https://lichess.org) -- is a 'material scoreboard' of sorts. In chess, each piece is considered to have a 'value' relative to the other pieces. A pawn is worth 1 point of material, a knight or bishop is worth 3, a rook is worth 5, and a queen is worth 9. Any time you capture an opponent's piece, you gain that piece's points. The UI can track which player is ahead in material and by how much. Because of the importance of material, this feedback is useful for analyzing which side is currently winning the match (although of course, it's not the only factor in determining this). I think this would be a great feature to add, and it would have a nice side effect of making the following feature easier to incorporate as well.

#### **Draw By Insufficient Material**
This is the one endgame state I did not initially implement. Draws by insufficient material emerge when neither side has enough pieces to checkmate the opposing King. Although the game will eventually end to the fifty-move-rule or repetitions, certain piece combos are known to give no checkmate chances and the game can just be declared a draw on the spot. This is definitely a nice quality of life improvement for users, as they can avoid playing out the useless moves to draw. It's also just in the rules for most competitions, so it'd be good to feature this.

#### **Highlighting Last Move**

Many Chess UIs will highlight the origin and target squares of the last move. An example can be seen from this lichess screenshot where the square the pawn started on and the square it ended on are both highlighted.

![image of highlighting the last move on a board](https://raw.githubusercontent.com/JoshDevHub/Chess/main/media/square_highlight_example.png)

 This offers a pleasant user experience as you may not be paying close attention to the board when the opponent moves their piece, and you therefore might waste time trying to figure out how the board has changed.
#### **Move History**

A complete move history is also a common feature of Chess UIs. Even when playing over the board in official competitions, players will log by hand every move made in the game. These are useful for players to look back and study/analyze their play. But even for more casual play, I think it's fun to look back and see the history of the game. This would probably be one of the more complex features to add in.

#### **Load from FEN**

Another feature that could be nice for players is to have an option to load a new game directly from a [FEN string](https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation). On one hand, this wouldn't be too complicated to implement, since my existing serialization with saves and loads already uses FEN strings under the hood. But if I allow a user to input any FEN string of their choosing, I'd probably need to do at least some validating to make sure it won't immediately crash my game.


## Acknowledgements

### The Odin Project
[The Odin Project](https://theodinproject.com) is an open source curriculum for learning web development. This project was done as part of the said curriculum, and the Odin community has taught me, or given me the tools to learn, virtually everything I know about programming. I also want to specifically acknowledge everyone in the Ruby channels of the Odin Project discord :heart:

### TextKool
[TextKool](https://textkool.com/en/ascii-art-generator?hl=default&vl=default&font=Red%20Phoenix&text=Your%20text%20here%20) was used to generate the ascii text of the project.

### Chess.com
[Chess](https://chess.com) is a platform for playing Chess and is typically where I play. My board's color scheme is inspired by one of the board themes on their site.

### Lichess
[Lichess](https://lichess.org) is an open source platform for playing Chess. Its Study section, where you can create custom game situations and extract a FEN from them, proved pretty valuable for me testing various aspects of my game's functionality.