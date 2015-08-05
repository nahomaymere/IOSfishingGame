//
//  GameOver.m
//  ReverseIceFishing
//
//  Created by Nahom Hailu on 06/02/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameOver.h"
#import "Gameplay.h"


@implementation GameOver
{
    CCLabelTTF* _scoreAnounce;
     Gameplay *Currentgame;
}
-(void)didLoadFromCCB{
    self.userInteractionEnabled=true;
   
     [_scoreAnounce setString:[NSString stringWithFormat:@"You scored %i",Currentgame.score]];
}
-(void)viewdidAppear{}
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CCScene *MenuScene=[CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector]replaceScene:MenuScene];
}

@end
