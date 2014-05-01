//
//  main.m
//  Duel
//
//  Created by Tim Holt on 4/30/14.
//  Copyright (c) 2014 Tim Holt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "console.m"
#import "console.h"
#import <math.h>

int action;
int opHealth;
int opAttack;
int str;
int userHealth;
NSString *opName;
NSString *userName;

//creates random opponent
void chooseOpponent() {
    int selector;
    sranddev();
    selector = rand() % 3 + 1;
    if (selector == 1) {
        opName = @"Dobby the House Elf";
        opHealth = 3;
        opAttack = 1;
    }
    else if (selector == 2){
        opName = @"Macho Man";
        opHealth = 5;
        opAttack = 2;
    }
    else if (selector == 3){
        opName = @"Mike Tyson";
        opHealth = 10;
        opAttack = 5;
    }
    else if (selector == 4){
        opName = @"Rammus";
        opHealth = 15;
        opAttack = 3;
    }
}

//calculates the damage done to opponent
void userAttack(int userStr){
    int damage;
    damage = rand() % 5 + 1;
    if (damage != 0) {
        opHealth = opHealth - damage * userStr;
        NSLog(@"%@ has been hit for %i damage!", opName, damage);
    } else {
        NSLog(@"The attack has missed!");
    }
}

// initializes user's name and strength values
void userCreation(NSString *name){
    userName = name;
    str = rand() % 2 + 1;
    userHealth = rand() % 20 + 1;
}

void userWait(){
    int damage;
    if (damage != 0) {
        userHealth = userHealth - damage * opAttack;
        NSLog(@"%@ has been hit for %i damage!", userName, damage);
    } else {
        NSLog(@"The attack has missed!");
    }
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        chooseOpponent();
        userName = getStringFromConsole(@"Welcome to the battle arena! Enter your name:");
        userCreation(userName);
        NSLog(@"Today's match up is %@ vs %@", userName, opName);
        NSLog(@"%@ has %i health and %i strength", userName, userHealth, str);
        while (opHealth > 0 || userHealth > 0) {
            action = getIntegerFromConsole(@"Type 1 to attack or 0 to wait");
            if (action == 1) {
                userAttack(str);
            } else if (action == 0) {
                userWait();
            } else {
                NSLog(@"That is not allowed in the battle arena, this is your final warning summoner...");
            }
            
        }
        if (opHealth == 0) {
            NSLog(@"By Azura! By Azura! The grand champion!!! Congradulations!");
        } else {
            NSLog(@"You are dead... %@ is the grand champion!", opName);
        }
        
    }
    return 0;
}

