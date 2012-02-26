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

@synthesize lastTime;
@synthesize damage;
@synthesize controller;

// Accessor for state
-(SpriteState)state { return state; }
-(void)setState:(SpriteState)newState { 
    if (newState == state) return;
    state=newState;
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

- (id)initWithController:(id)controllerObject {
    self = [super init];
    if (self) {
        self.controller = controllerObject;
        [self initialize];
        [self setLife:1];
        [self setDamage:0];
        [self setState:OK];
    }
    return self;
}


- (void)update:(yTime)dt {}
- (void)shoot {}
- (void)collisionWith:(YSprite *)collider {
    self.life = life - collider.damage;
}
- (void) dealloc { [super dealloc]; }

@end
