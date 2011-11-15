//
//  Enemy.h
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 27/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
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
}

@property (readonly) CCSprite *sprite;
@property (assign)   ccTime lastTime;

- (id)initWithTexture:(CCTexture2D *)texture father:(MainLayer *)parentScene;
- (void)shootTo:(CGPoint)position;
- (void)update:(ccTime)dt;
@end
