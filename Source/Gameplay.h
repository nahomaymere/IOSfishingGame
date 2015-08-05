//
//  Gameplay.h
//  ReverseIceFishing
//
//  Created by Nahom Hailu on 09/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Gameplay : CCNode<CCPhysicsCollisionDelegate>
    {
        bool mTouchBegan;
        
       // CCNode* fish;
        
    }
@property( nonatomic,assign ) int score;
@end
