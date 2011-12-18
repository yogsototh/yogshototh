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
    }
    return self;
}

- (void)shootTo:(CGPoint)position {
    Bullet *bullet = [[Bullet alloc] initWithStartPosition:sprite.position toPosition: position withSpeed:1.0 andMainLayer:father];
    [father addBullet:bullet];
    [bullet autorelease];
}

- (void)update:(ccTime)dt {
}

- (void)shoot {
}

- (void) dealloc
{
    [sprite release];
    [super dealloc];
}

@end
