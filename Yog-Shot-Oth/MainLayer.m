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
        // Load textures in cache
        bulletTexture = [[CCTextureCache sharedTextureCache] addImage:@"Bullet.png"];
        enemyTexture = [[CCTextureCache sharedTextureCache] addImage:@"Yogsototh.png"];
        
        winSize = [[CCDirector sharedDirector] winSize];
        
        starship = [[CCSprite alloc] initWithFile:@"Vaisseau.png"];
        starship.position = ccp(40, 40);
        [self addChild:starship];
        
        enemis = [[NSMutableArray alloc] initWithCapacity:INITIAL_ALLOC_ENEMY_NUMBER];
        bullets = [[NSMutableArray alloc] initWithCapacity:INITIAL_ALLOC_BULLET_NUMBER];
 
        CCSprite *enemy;
        for (int i=0; i<INITIAL_ALLOC_ENEMY_NUMBER; i++) {
            enemy = [[CCSprite alloc] initWithTexture:enemyTexture];
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

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    initialTouch=[touch locationInView:[touch view]];
    initialTouch.y = winSize.height - initialTouch.y;
    [[CCDirector sharedDirector] resume];
}


- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[CCDirector sharedDirector] pause];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //Simply store the touch location for later processing by the
    lastTouch = [touch locationInView: [touch view]];
    lastTouch.y = winSize.height-lastTouch.y;
}


-(CGFloat) restrictValue:(CGFloat)value Between:(CGFloat)minValue And:(CGFloat)maxValue
{
    if (value>=maxValue) {
        return maxValue;
    }
    if (value<=minValue) {
        return minValue;
    }
    return value;
}

-(CGPoint) restrictPoint:(CGPoint)point inside:(CGSize)size 
{
    point.x = [self restrictValue:point.x Between:0.0 And:size.width];
    point.y = [self restrictValue:point.y Between:0.0 And:size.height];
    return point;
}

- (void) nextFrame:(ccTime)dt
{
    CGPoint newpos;
    newpos.x = lastTouch.x;// - initialTouch.x;
    newpos.y = lastTouch.y;// - initialTouch.y;
    
    starship.position = [self restrictPoint:newpos inside:winSize];
}


- (void) dealloc 
{
    [starship release];
    [bullets release];
    [enemis release];
    [super dealloc];
}

@end
