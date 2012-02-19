//
//  Enemy.h
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 27/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"
#import "Starship.h"
#import "MainLayer.h"

@interface Enemy : CCNode
{
    MainLayer *father;
    CCSprite *sprite;
    CGSize winSize;
    CGPoint speed;
    Starship *target;
    ccTime   lastTime;
    int life;
    SpriteState state;
}
@property (readonly) CCSprite *sprite;
@property (assign)   ccTime lastTime;
@property (assign)   SpriteState state;

- (void)initialize;
- (id)initWithParent:(MainLayer *)parentScene;
- (void)shootTo:(CGPoint)position withSpeed:(CGFloat)bulletSpeed;
- (void)shoot;
- (void)update:(ccTime)dt;
- (void)collisionOccured;
@end
