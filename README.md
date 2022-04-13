# Knight Travails

## Introduction

Now you’re a pro with DFS and BFS. Let’s try using our search algorithms on a real problem.

For this project, you’ll need to use a data structure that’s similar (but not identical) to a binary tree. For a summary of a few different examples, reference this article.

A knight in chess can move to any square on the standard 8x8 chess board from any other square on the board, given enough turns (don’t believe it? See this animation). Its basic move is two steps forward and one step to the side. It can face any direction.


## Assignment

Your task is to build a function knight_moves that shows the simplest possible way to get from one square to another by outputting all squares the knight will stop on along the way.


    1. Put together a script that creates a game board and a knight.
    2. Treat all possible moves the knight could make as children in a tree. Don’t allow any moves to go off the board.
    3. Decide which search algorithm is best to use for this case. Hint: one of them could be a potentially infinite series.
    4. Use the chosen search algorithm to find the shortest path between the starting square (or node) and the ending square. Output what that full path looks like, e.g.:


