//
//  YSprite.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 27/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "YSprite.h"
#import "geometry.h"

@implementation YSprite 

@synthesize sprite;
@synthesize lastTime;
@synthesize damage;

// Accessor for state
-(SpriteState)state { return state; }
-(void)state:(SpriteState)newState { 
    if (newState == state) return;
    state=newState;
    [self startAnimation:[self animationForState:state]]; 
}

// Accessor for life
-(int)life { return life; }
-(void)setLife:(int)newLifeValue {
    life=newLifeValue;
    if (life<=0) {
        self.state = DESTROYED;
    }
}

- (void)initialize {
    // Child should instanciante this function
    [NSException raise:@"uninstancied function" format:@"la fonction initialize est invalide"];

    // -- Instantiate animation names
    // -- All cocos2d related code should be done in master.
    // animations=[[NSArray alloc] initWithObjects:
    //                  @"sprite1basic",
    //                  @"sprite1damaged",
    //                  @"sprite1destroying",
    //                  @"sprite1destroyed", nil];
}

- (id)initWithMaster:(id)masterObject {
    self = [super init];
    if (self) {
        self.master = masterObject;
        [self initialize];
        [self addChild:sprite];
        [self setLife:1];
        [self setDamage:0];
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
