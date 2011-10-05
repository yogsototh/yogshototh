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
        enemyTexture = [[CCTextureCache sharedTextureCache] addImage:@"Panou.png"];
        
        winSize = [[CCDirector sharedDirector] winSize];
        
        starship = [[CCSprite alloc] initWithFile:@"Starship.png"];
        starship.position = ccp(40, 40);
        [self addChild:starship z:1];
        
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

-(CGPoint) positionFromTouch:(UITouch *)touch
{
    CGPoint position=[touch locationInView:[touch view]];
    position.x = winSize.width - position.x; // SHOULD UNDERSTAND WHY
    return position;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    initialTouch = [self positionFromTouch:touch];
    lastTouch = initialTouch;
    starshipPositionAtTouchBegan = starship.position;
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
    lastTouch = [self positionFromTouch:touch];
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

- (CGPoint) point:(CGPoint)p1 minus:(CGPoint)p2
{
    return CGPointMake(p1.x - p2.x, p1.y - p2.y);
}

- (CGPoint) point:(CGPoint)p1 plus:(CGPoint)p2
{
    return CGPointMake(p1.x+p2.x, p1.y+p2.y);
}

- (void) nextFrame:(ccTime)dt
{
    starship.position = [self restrictPoint: ccpAdd(starshipPositionAtTouchBegan, 
                                                    ccpSub(initialTouch, lastTouch))
                                     inside:winSize];
}


- (void) dealloc 
{
    [starship release];
    [bullets release];
    [enemis release];
    [super dealloc];
}

@end
