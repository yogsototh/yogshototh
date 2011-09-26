//
//  mainLayer.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 24/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainLayer.h"
#import "Constants.h"
#import "CCTouchDispatcher.h"

@implementation MainLayer

- (id)init
{
    self = [super init];
    if (self) {
        winSize = [[CCDirector sharedDirector] winSize];
        
        starship = [[CCSprite alloc] initWithFile:@"Vaisseau.png"];
        starship.position = ccp(40, 40);
        [self addChild:starship];
        
        enemis = [[NSMutableArray alloc] initWithCapacity:INITIAL_ALLOC_ENEMY_NUMBER];
        bullets = [[NSMutableArray alloc] initWithCapacity:INITIAL_ALLOC_BULLET_NUMBER];
 
        CCSprite *enemy;
        for (int i=0; i<INITIAL_ALLOC_ENEMY_NUMBER; i++) {
            enemy = [[CCSprite alloc] initWithFile:@"Yogsototh.png"];
            [enemis addObject:enemy];
            enemy.position = ccp(
                                 (100*i) % (int)winSize.width,
                                 100 + (rand() % ((int)winSize.height - 100)));
            [self addChild:enemy];
        }
        self.isTouchEnabled = YES;
        [self schedule:@selector(nextFrame:)];
        
    }
    
    return self;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
     [[CCDirector sharedDirector] resume];
    return YES;
}


- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
     [[CCDirector sharedDirector] pause];
}

/*
- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}*/

- (void) nextFrame:(ccTime)dt
{
    starship.position = ccp((int)(starship.position.x + (winSize.width*dt) ) % ((int)winSize.width),40);
}


- (void) dealloc 
{
    [starship release];
    [bullets release];
    [enemis release];
    [super dealloc];
}

@end
