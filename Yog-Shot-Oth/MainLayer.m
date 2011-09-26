//
//  mainLayer.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 24/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainLayer.h"
#import "Constants.h"

@implementation MainLayer

- (id)init
{
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
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
        
    }
    
    return self;
}

- (void) dealloc 
{
    [starship release];
    [bullets release];
    [enemis release];
    [super dealloc];
}

@end
