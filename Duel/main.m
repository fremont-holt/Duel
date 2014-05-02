//
//  main.m
//  Duel
//
//  Created by Tim Holt on 4/30/14.
//  Copyright (c) 2014 Tim Holt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "console.h"
#import <math.h>

int action;
int atckType;
int opHealth;
int opAttack;
int opID;
int str;
int turnCount;
int userSpd;
int userHealth;
NSString *opName;
NSString *userName;

//creates random opponent
void chooseOpponent() {
    sranddev();
    opID = rand() % 3 + 1;
    if (opID == 1) {
        opName = @"Dobby the House Elf";
        opHealth = 3;
        opAttack = 1;
    }
    else if (opID == 2){
        opName = @"Macho Man";
        opHealth = 15;
        opAttack = 3;
    }
    else if (opID == 3){
        opName = @"Mike Tyson";
        opHealth = 19;
        opAttack = 5;
    }
    else if (opID == 4){
        opName = @"Rammus";
        opHealth = 25;
        opAttack = 2;
    }
}

//enemy says something when they miss an attack
void enemyMiss(){
    if (opID == 1) {
        NSLog(@"Stupid! Stupid! Stupid Dobby!");
    } else if (opID == 2) {
        NSLog(@"On balance off balance, doesn't matter...");
    } else if (opID == 3) {
        NSLog(@"I'll bite your ear next time");
    } else if (opID == 4) {
        NSLog(@"Ok...");
    }
}

//enemy says something when they win
void enemyWin(){
    if (opID == 1) {
        NSLog(@"Dobby is a free elf!");
    } else if (opID == 2) {
        NSLog(@"Ohhhhhhh yeaaaaaahhhhhh Macho Man is the champ once again!");
    } else if (opID == 3) {
        NSLog(@"Baddest man on the planet punk!");
    } else if (opID == 4) {
        NSLog(@"Yep");
    }
}

//enemy says something when they land a hit
void enemyHit() {
    if (opID == 1) {
        NSLog(@"A sock? For Dobby?");
    } else if (opID == 2) {
        NSLog(@"Snap into a slim jim!!");
    } else if (opID == 3) {
        NSLog(@"Everybody has a plan until they get punched in the face.");
    } else if (opID == 4) {
        NSLog(@"Ok...");
    }
}

//enemy says something when they hace lost
void enemyLoss(){
    if (opID == 1) {
        NSLog(@"You musn't be angry...Dobby did it for the best...");
    } else if (opID == 2) {
        NSLog(@"I say I'm a million percent. That is better than a hundred percent! But you bested me this time...");
    } else if (opID == 3) {
        NSLog(@"I felt like I was 120 years old. I feel like Rip Van Winkle right now.");
    } else if (opID == 4) {
        NSLog(@"Ok...");
    }
}

//calculates the damage done to opponent with strong attack
void userStrAttack(int userStr){
    int damage;
        damage = rand() % 9 + 1;
        if (damage != 0) {
            opHealth = opHealth - damage * userStr;
            NSLog(@"%@ has been hit for %i damage!", opName, damage);
            NSLog(@"%@ has %i health remaining!", opName, opHealth);
        } else {
            NSLog(@"The attack has missed!");
            NSLog(@"%@ has %i health remaining!", opName, opHealth);
        }
}

//calculates the damage done to opponent with speedy attack
void userSpdAttack(int userSpd){
    int damage;
    while (userSpd > 0) {
        damage = rand() % 5 + 1;
        if (damage != 0) {
            opHealth = opHealth - damage;
            NSLog(@"%@ has been hit for %i damage!", opName, damage);
            NSLog(@"%@ has %i health remaining!", opName, opHealth);
        } else {
            NSLog(@"The attack has missed!");
            NSLog(@"%@ has %i health remaining!", opName, opHealth);
        }
        userSpd -= 1;
    }
}

// initializes user's name and strength values
void userCreation(NSString *name){
    userName = name;
    userSpd = rand() % 3 + 1;
    str = rand() % 2 + 1;
    userHealth = rand() % 20 + 1;
}

//enemy attacks
void userWait(){
    int damage;
    if (damage != 0) {
        userHealth = userHealth - damage * opAttack;
        NSLog(@"%@ has been hit for %i damage!", userName, damage);
        enemyHit();
        NSLog(@"%@ has %i health remaining!", userName, userHealth);
    } else {
        NSLog(@"The attack has missed!");
        NSLog(@"%@ has %i health remaining!", userName, userHealth);
        enemyMiss();
    }
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        chooseOpponent();
        userName = getStringFromConsole(@"Welcome to the battle arena! Enter your name:");
        userCreation(userName);
        NSLog(@"Today's match up is %@ vs %@", userName, opName);
        NSLog(@"%@ has %i health, %i speed and %i strength", userName, userHealth, userSpd, str);
        action = getIntegerFromConsole(@"Type 1 to attack or 0 to wait");
        while (opHealth > 0 && userHealth > 0) {
            if (action == 1) {
                atckType = getIntegerFromConsole(@"Type 0 for speed attack or 1 for strong attack:");
                if (atckType == 0) {
                    userSpdAttack(userSpd);
                } else if (atckType == 1){
                    userStrAttack(str);
                }
                action = 0;
            } else if (action == 0) {
                userWait();
                action = 1;
            } else {
                NSLog(@"That is not allowed in the battle arena, this is your final warning summoner...");
            }
            
        }
        if (opHealth < 0) {
            NSLog(@"By Azura! By Azura! The grand champion!!! Congradulations!");
        } else {
            NSLog(@"You are dead... %@ is the grand champion!", opName);
        }
        
    }
    return 0;
}

