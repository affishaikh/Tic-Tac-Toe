#! /usr/bin/awk
BEGIN{
  print "Welcome to TIC TAC TOE";
  player="";
  print "Enter player name";
  getline player;
  player_symbol="X";
  print player"'s symbol is " "\'"player_symbol"\'";
  bot_symbol="O";
  turn=0;
  print "Hit enter to start the game";
  winningConditions = "123,456,789,147,258,369,159,357";
  split(winningConditions, winningConditionsArr, ",");
  fieldSpaces = "         ";
  split(fieldSpaces, field, "");
  srand();
};

{
  print_board();
  exit;
}

function print_board(){
  print field[1]"|"field[2]"|"field[3];
  print "------";
  print field[4]"|"field[5]"|"field[6];
  print "------";
  print field[7]"|"field[8]"|"field[9];
  print "____________________________"
  checkWinLoose();
  decideTurn();
}

function checkWinLoose() {
  for(traverser = 1; traverser<=8; traverser++){
    split(winningConditionsArr[traverser], winFields, "");
    if(field[winFields[1]] == field[winFields[2]] && field[winFields[1]] == field[winFields[3]] && field[winFields[1]] == "X"){
      print player " wins";
      exit;
    } else if(field[winFields[1]] == field[winFields[2]] && field[winFields[1]] == field[winFields[3]] && field[winFields[1]] == "O"){
      print "Bot wins";
      exit;
    }
  }
  if(turn == 9){
    print "Match Draw";
    exit;
  }
}


function decideTurn() {
  turn++;
  if((turn%2)==1)
  {
    print player"'s turn. Press a number between 1-9"
    do{
      getline fieldNumber
      playerMoves[length(playerMoves) + 1]=fieldNumber;
      if(field[fieldNumber]!=" ")
      {
         print "You have entered into wrong field\n Enter Again."
      }
    }while(field[fieldNumber]!=" ")
    field[fieldNumber]=player_symbol
    print_board();
  } else if (turn == 2){
    botFirstTurn();
  } else {
    botLastAttack();
  }
}

function botLastAttack() {
  botMoved ="false";
  for(traverser = 1; traverser <= 8 && botMoved == "false" ; traverser ++)
  {
    if(winningConditionsArr[traverser] ~ botMoves[length(botMoves)])
    {
      split(winningConditionsArr[traverser], botPossibleMoveArr, "");
      if(field[botPossibleMoveArr[1]] == "O" && field[botPossibleMoveArr[1]] == field[botPossibleMoveArr[2]] && field[botPossibleMoveArr[3]] == " ")
      {
        botPlayedAt = botPossibleMoveArr[3];
        field[botPlayedAt]=bot_symbol;    
        botMoves[length(botMoves)+1]= botPlayedAt;
        botMoved = "true";
        break;
      }  
      else if(field[botPossibleMoveArr[2]] == "O" && field[botPossibleMoveArr[2]] == field[botPossibleMoveArr[3]] && field[botPossibleMoveArr[1]] == " ")
      {
        botPlayedAt = botPossibleMoveArr[1];
        field[botPlayedAt]=bot_symbol;    
        botMoves[length(botMoves)+1]= botPlayedAt;
        botMoved = "true";
        break;
      }  
      else if(field[botPossibleMoveArr[1]] == "O" && field[botPossibleMoveArr[1]] == field[botPossibleMoveArr[3]] && field[botPossibleMoveArr[2]] == " ")
      {
        botPlayedAt = botPossibleMoveArr[2];
        field[botPlayedAt]=bot_symbol;    
        botMoves[length(botMoves)+1]= botPlayedAt;
        botMoved = "true";
        break;
      }  
    } 
  }
  if(botMoved == "false"){
    botTurn1();
  } else {
  print_board();
  }
}


function botFirstTurn() {
  botPossibleMoves = "1379";
  split(botPossibleMoves, botPossibleMovesArr, "");
  if(playerMoves[length(playerMoves)] == 5){
    botFirstMove = botPossibleMovesArr[int(rand()*4)+1];
    field[botFirstMove] = bot_symbol;
    botMoves[length(botMoves)+1] = botFirstMove; 
    print_board();
  } else {
    field[5] = bot_symbol;
    botMoves[length(botMoves)+1] = 5; 
    print_board();
  }
}

function botTurn1(){
  botMoved ="false";
  for(traverser = 1; traverser <= 8 && botMoved == "false" ; traverser ++)
  {
    if(winningConditionsArr[traverser] ~ playerMoves[length(playerMoves)])
    {
      split(winningConditionsArr[traverser], botPossibleMoveArr, "");
      if(field[botPossibleMoveArr[1]] == "X" && field[botPossibleMoveArr[1]] == field[botPossibleMoveArr[2]] && field[botPossibleMoveArr[3]] == " ")
      {
        botPlayedAt = botPossibleMoveArr[3];
        field[botPlayedAt]=bot_symbol;    
        botMoves[length(botMoves)+1]= botPlayedAt;
        botMoved = "true";
        break;
      }  
      else if(field[botPossibleMoveArr[2]] == "X" && field[botPossibleMoveArr[2]] == field[botPossibleMoveArr[3]] && field[botPossibleMoveArr[1]] == " ")
      {
        botPlayedAt = botPossibleMoveArr[1];
        field[botPlayedAt]=bot_symbol;    
        botMoves[length(botMoves)+1]= botPlayedAt;
        botMoved = "true";
        break;
      }  
      else if(field[botPossibleMoveArr[1]] == "X" && field[botPossibleMoveArr[1]] == field[botPossibleMoveArr[3]] && field[botPossibleMoveArr[2]] == " ")
      {
        botPlayedAt = botPossibleMoveArr[2];
        field[botPlayedAt]=bot_symbol;    
        botMoves[length(botMoves)+1]= botPlayedAt;
        botMoved = "true";
        break;
      }  
    } 
  }
  if(botMoved == "false"){
    botAttack();
  } else {
  print_board();
  }
}

function botAttack() {
  botMoved ="false";
  for(traverser = 1; traverser <= 8 && botMoved == "false" ; traverser ++)
  {
    if(winningConditionsArr[traverser] ~ botMoves[length(botMoves)])
    {
      split(winningConditionsArr[traverser], botPossibleMovesArr, "");
      if(field[botPossibleMovesArr[1]] == "O" && field[botPossibleMovesArr[2]] == " " && 
         field[botPossibleMovesArr[3]] == " ") {
        botPlayedAt = botPossibleMovesArr[3];
        field[botPlayedAt] = bot_symbol;
        botMoves[length(botMoves)+1] = botPlayedAt;
        botMoved = "true";
        break;
      }
      if(field[botPossibleMovesArr[1]] == " " && field[botPossibleMovesArr[2]] == "O" && 
         field[botPossibleMovesArr[3]] == " ") {
        botPlayedAt = botPossibleMovesArr[1];
        field[botPlayedAt] = bot_symbol;
        botMoves[length(botMoves)+1] = botPlayedAt;
        botMoved = "true";
        break;
      }
      if(field[botPossibleMovesArr[1]] == " " && field[botPossibleMovesArr[2]] == " " &&
         field[botPossibleMovesArr[3]] == "O") {
        botPlayedAt = botPossibleMovesArr[1];
        field[botPlayedAt] = bot_symbol;
        botMoves[length(botMoves)+1] = botPlayedAt;
        botMoved = "true";
        break;
      }
    }
  }
  if(botMoved == "false"){
    botTurn2();
  }else {
  print_board();
}
}
function botTurn2() {
  botMoved ="false";
  for(traverser = 1; traverser <= 8 && botMoved == "false" ; traverser ++)
  {
    if(winningConditionsArr[traverser] ~ playerMoves[length(playerMoves)])
    {
      split(winningConditionsArr[traverser], botPossibleMovesArr, "");
      for(traverserBot = 1; traverserBot <= 3; traverserBot++)
      {
        if(field[botPossibleMovesArr[traverserBot]] == " ")
        {
          botPlayedAt = botPossibleMovesArr[traverserBot];
          field[botPlayedAt] =  bot_symbol;    
          botMoves[length(botMoves)+1]= botPlayedAt;
          botMoved = "true";
          break;
        }  
      }  
    }
  }
  if(botMoved == "false"){
    for(traverser = 1; traverser <= 9 && botMoved == "false"; traverser++){
      if(field[traverser] == " "){
        field[traverser] = bot_symbol;
        botMoves[length(botMoves)+1]= traverser;
        botMoved = "true";
      }
    }
    if(botMoved == "true"){
      print_board();
    }
  }
  print_board();
}
