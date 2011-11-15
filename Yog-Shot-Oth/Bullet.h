//
//  Bullet.h
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 14/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"
#import "MainLayer.h"

@interface Bullet : CCNode 
{
    MainLayer *parentLayer;
    CCSprite *sprite;
    CGSize winSize;
    CGPoint speed;
}
@property (assign) MainLayer *father;

- (id)initWithStartPosition:(CGPoint)fromPosition toPosition:(CGPoint)toPosition;
- (void)update:(ccTime)dt;

@end
