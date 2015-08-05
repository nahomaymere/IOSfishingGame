//
//  Gameplay.m
//  ReverseIceFishing
//
//  Created by Nahom Hailu on 09/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "CCSprite.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "Fish.h"



@implementation Gameplay
{
    CCPhysicsNode *_physicsNode;
    CCLabelTTF *_myText;
    CCNode *_Tanktube;
    CCNode *_contentNode;
    CCNode *_levelNode;
    CCNode *_Shootbutton;
    CCNode *_powerbutton;
    CCNode *_FishingNet1;
    CCNode *_FishingNetDown;
    CCNode *_FishingNetUp;
    CCNode *_FishingNet4;
    
    CCSlider* _myslider;
    CCSlider* _myPowerSlider;
    CCButton* _Shootbuton;
    CCLabelTTF* _powerLabel;
    CCLabelTTF* _scoreLabel;
    CCLabelTTF* _lifeLabel;
    
    CGPoint velocity;
    CGPoint velocity1;
    CGPoint velocity2;
    CGRect  _Fish;
    
    float PreviousSliderValue;
    float CurrentSliderValue;
    float PreviousSliderValue2;
    float CurrentSliderValue2;
    int power;
    int score;
    int life;
    BOOL touchReleased;
    bool isGameOver;
    BOOL groundCollided;
    bool IncreaseScore;
    Fish* f;
    
}
-(void)didLoadFromCCB{
    self.userInteractionEnabled=TRUE;
    
    //[_levelNode addChild:Nets];
    //_physicsNode.debugDraw=TRUE;
    _myslider.sliderValue=0;
    PreviousSliderValue=_myslider.sliderValue;
    life=5;
    score=0;
    power=4000;
    _physicsNode.collisionDelegate=self;
    _myslider.sliderValue=0.5;
    
    
    velocity=CGPointMake(-3.f,0.f );
    
   velocity1=CGPointMake(2.5f,0.f );
 velocity2=CGPointMake(-4.f,0.f );
   // mTouchBegan=FALSE;
    isGameOver=false;
    IncreaseScore=false;
    
    
    
}
-(void)update:(CCTime)delta{
    
    CGRect InsideNet1=CGRectMake(_FishingNet1.position.x+0.5f, _FishingNet1.position.y+0.5, 30, 10);
    CGRect InsideNetUp=CGRectMake(_FishingNetUp.position.x+0.5f, _FishingNetUp.position.y+0.5, 30, 10);
    CGRect InsideNetDown=CGRectMake
    (_FishingNetDown.position.x+0.5f, _FishingNetDown.position.y+0.5, 30, 10);

    
    
    if (CGRectContainsPoint(InsideNet1,f.position ))
        {
            NSLog(@"Yeah just caught a fish");
            
            [self ScoreHandler];
            [self FishRemover:f];

            
        }
    if (CGRectContainsPoint(InsideNetUp,f.position ))
    {
        NSLog(@"Yeah just caught a fish");
      
        [self ScoreHandler];
          [self FishRemover:f];
    
        [_lifeLabel setString:[NSString stringWithFormat:@"Life %i",life]];
        
    }
    if (CGRectContainsPoint(InsideNetDown,f.position ))
    {
        NSLog(@"Yeah just caught a fish");
       
        [self FishRemover:f];
        [self ScoreHandler];
        
       
 
    }
   
   
 
    _FishingNet1.position=ccpAdd(_FishingNet1.position,velocity);
    _FishingNetUp.position=ccpAdd(_FishingNetUp.position,velocity1);
    _FishingNetDown.position=ccpAdd(_FishingNetDown.position,velocity2);
    
    if (mTouchBegan) {
        power+=150;
        [_powerLabel setString:[NSString stringWithFormat:@"%i",power]];
    }
   
    
    // Net in the middle
   if (_FishingNet1.position.x>700) {
        velocity=CGPointMake(-3.f,0.f );
    }
    if (_FishingNet1.position.x<300) {
        velocity=CGPointMake(3.f, 0.f);
    }
    
    //Upper Net
    if (_FishingNetUp.position.x>800) {
        velocity1=CGPointMake(-2.5f,0.f );
    }
    if (_FishingNetUp.position.x<500) {
        velocity1=CGPointMake(2.5f, 0.f);
    }
   
    //lower Net
    if (_FishingNetDown.position.x>700) {
        velocity2=CGPointMake(-4.,0.f );
    }
    if (_FishingNetDown.position.x<300) {
        velocity2=CGPointMake(4.f, 0.f);
    }
 

  //  NSLog(@" Net position is %f",_FishingNetDown.position.x);
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    mTouchBegan = TRUE;

    
    
   
    
    
}

-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    /*CCActionFollow *follow=[CCActionFollow actionWithTarget:_Tanktube  worldBoundary:self.boundingBox];
    [_contentNode runAction:follow];*/
    mTouchBegan = FALSE;
    touchReleased=true;
     [self launchFish];
    power=4000;
    
}



-(void)launchFish{
    f= (Fish*)[CCBReader load:@"Fish"];
    
    
    f.position=ccpAdd(_Tanktube.position, ccp(60 ,45));
    [_physicsNode addChild:f];
    f.NewFish=true;
    CGPoint launchDirection = ccp(CurrentSliderValue, CurrentSliderValue);
    CGPoint force = ccpMult(launchDirection, power);
    
    _Fish=CGRectMake(f.position.x, f.position.y, 50.f, 50.f);//creating a CGRECT containing the fish
    
    [f.physicsBody applyForce:force];
    self.position=ccp(0,0);
    CCActionFollow *follow=[CCActionFollow actionWithTarget:f  worldBoundary:self.boundingBox];
    [_contentNode runAction:follow];
    
}
-(void)retry{
    /*CCScene *Gameplay=[CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector]replaceScene:Gameplay];
    //isGameOver=TRUE;*/
    [[CCDirector sharedDirector ]replaceScene:[CCBReader loadAsScene:@"Gameplay"]];
    }
-(void)rotateTanktube{
    CCActionFollow *follow=[CCActionFollow actionWithTarget:_Tanktube  worldBoundary:self.boundingBox];
    [_contentNode runAction:follow];
    CurrentSliderValue=_myslider.sliderValue;
    if (CurrentSliderValue==0.5) {
        _Tanktube.rotation=4.0;
    }
    if (CurrentSliderValue==1) {
        _Tanktube.rotation=-7.0;
    }
    if (CurrentSliderValue==0) {
        _Tanktube.rotation=13;
    }
    if (CurrentSliderValue==0.25) {
        _Tanktube.rotation=10;
    }
        
    else if (CurrentSliderValue>PreviousSliderValue&&_Tanktube.rotation>-7.0) {
        _Tanktube.rotation-=0.5;
    }
    else if(CurrentSliderValue<PreviousSliderValue&&_Tanktube.rotation<13){
        _Tanktube.rotation+=0.5;
     
    }
    NSLog(@"sliderValue %f",CurrentSliderValue);
    NSLog(@"tanktuberotation %f",_Tanktube.rotation);
    
    PreviousSliderValue=CurrentSliderValue;
    
    }
/*-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair FishingNet:(CCNode *)nodeA Fishy:(CCNode *)nodeB
{
    CCLOG(@"Something collided with the Fishing net");
    float energy=[pair totalKineticEnergy];
    
    if (energy>2000.f) {
        [[_physicsNode space] addPostStepBlock:^{
           // [self FishRemoved:nodeB];
        } key:nodeB];
    }
  
}*/


-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair GroundCollider:(CCNode *)nodeA Fishy:(CCNode *)nodeB
{
    groundCollided=true;
    if (f.NewFish) {
        [self ReduceLifespan];
    }
    
    f.NewFish=false;
    
    return groundCollided;
}


-(void)FishRemoved:(CCNode *)Fishy{
    
}
-(void)FishRemover:(Fish *)CaughtFish{
     CCParticleSystem *coleff=(CCParticleSystem *)[CCBReader load:@"Collisioneffect"];
     coleff.autoRemoveOnFinish=TRUE;
    coleff.position=CaughtFish.position;
    [CaughtFish.parent addChild:coleff];
    [CaughtFish removeFromParent];
    CCActionFollow *follow=[CCActionFollow actionWithTarget:coleff  worldBoundary:self.boundingBox];
    [_contentNode runAction:follow];
    
   
}
-(void)ReduceLifespan
{
    
    life-=1;
    [_lifeLabel setString:[NSString stringWithFormat:@"Life %i",life]];
    if (life==0) {
        _score=score;
        CCScene *GameOverScene=[CCBReader loadAsScene:@"GameOver"];
        [[CCDirector sharedDirector]replaceScene:GameOverScene];
    }
}
-(void)ScoreHandler
{   if(f.NewFish)
    {
        
        score+=10;
        [_scoreLabel setString:[NSString stringWithFormat:@"SCORE %i",score]];
       
    }
     f.NewFish=false;
}



@end
