# Overview

This is an app that can be used to help you score a game of scrabble. You can play up to a 4 player game, and input words as you play, not worrying about the score, the app will keep track of that for you. It includes bingo functionality, letter and word multiplier functionality, and a word check based on the [Enable word list](https://www.bananagrammer.com/2013/12/the-amazing-enable-word-list-project.html). Other, smaller word lists are also included.

# Architecture

This is a monorepo that contains moth the frontend and backend code for the app. The frontend is a flutter app, and the backend is a django app.

## Frontend

The frontend is a flutter app developed mainly for iOS. The code is organized by features and tries to follow CLEAN architecture principles. More notes available inside the `client/readme.md` .

## Backend

The backend module contains several different django 'apps' including `accounts`, `api`, `common`, and `gemini` for google gemini api integration. It is set up to use docker and uses a customized django authentication system. 
