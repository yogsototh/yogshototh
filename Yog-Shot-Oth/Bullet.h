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
    int collisionDistance;
}
@property (assign) MainLayer *father;

- (id)initWithStartPosition:(CGPoint)fromPosition toPosition:(CGPoint)toPosition withSpeed:(CGFloat)speed andMainLayer:(MainLayer*)mainLayer;
- (void)update:(ccTime)dt;

@end
