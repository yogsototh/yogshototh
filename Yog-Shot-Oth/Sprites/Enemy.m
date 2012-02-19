//
//  Enemy.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 27/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "Bullet.h"
#import "geometry.h"

@implementation Enemy 

@synthesize sprite;
@synthesize lastTime;
@synthesize state;
-(int)life {
    return life;
}
-(void)setLife:(int)newLifeValue {
    life=newLifeValue;
    if (life<=0) {
        self.state = DESTROYED;
    }
}

- (void)initialize {
    [NSException raise:@"uninstancied function" format:@"la fonction initialize est invalide"];
}

- (id)initWithParent:(MainLayer *)parentScene {
    self = [super init];
    lastTime=0.0;
    if (self) {
        father = parentScene;
        [self initialize];
        [self addChild:sprite];
        [self setState:OK];
    }
    return self;
}

- (void)shootTo:(CGPoint)position withSpeed:(CGFloat)bulletSpeed {
    Bullet *bullet = [[Bullet alloc] initWithStartPosition:sprite.position toPosition: position withSpeed:bulletSpeed andMainLayer:father];
    [father addBullet:bullet];
    [bullet autorelease];
}

- (void)update:(ccTime)dt {
    if (self.state == DESTROYED) {
        [father removeEnemy:self];
    }
}
- (void)shoot {}
- (void)collisionOccured {
    [sprite setTexture:[[CCTextureCache sharedTextureCache] addImage:@"explode.png"]];
    self.life = life - 1;
}
- (void) dealloc
{
    [sprite release];
    [super dealloc];
}

@end
