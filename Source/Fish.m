//
//  Fish.m
//  ReverseIceFishing
//
//  Created by Nahom Hailu on 08/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Fish.h"

@implementation Fish
-(void)didLoadFromCCB
{
    self.physicsBody.collisionType = @"Fishy";
    
    _NewFish= false;
    
}

@end
