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

        // Initialize starship
        starship = [[Starship alloc] initWithWinSize:winSize];
        [self addChild:starship.sprite z:1];

        // initialize enemies
        // Load textures in cache
        enemyTexture = [[CCTextureCache sharedTextureCache] addImage:@"Panou.png"];
        enemis = [[NSMutableArray alloc] initWithCapacity:INITIAL_ALLOC_ENEMY_NUMBER];
        CCSprite *enemy;
        for (int i=0; i<INITIAL_ALLOC_ENEMY_NUMBER; i++) {
            enemy = [[CCSprite alloc] initWithTexture:enemyTexture];
            [enemis addObject:enemy];
            enemy.position = ccp(
                                 (100*i) % (int)winSize.width,
                                 100 + (rand() % ((int)winSize.height - 100)));
            [self addChild:enemy];
        }

        // alloc bullets
        // Load textures in cache
        bulletTexture = [[CCTextureCache sharedTextureCache] addImage:@"Bullet.png"];
        bullets = [[NSMutableArray alloc] initWithCapacity:INITIAL_ALLOC_BULLET_NUMBER];

        // Alloc pause message
        pauseMessage = [[CCSprite alloc] initWithFile:@"Pause.png"];
        pauseMessage.position = ccp(winSize.width/2, winSize.height/2);
        [pauseMessage runAction:[CCFadeOut actionWithDuration: 0]];
        [self addChild:pauseMessage z:10];

        
        self.isTouchEnabled = YES;
        
        [self schedule:@selector(nextFrame:)];
        
    }
    
    return self;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if ([touches count]>1) {
        [starship touchesOccured:touches];
    }
    UITouch *touch=[touches anyObject];
    [starship touchBegan:touch];
    [pauseMessage runAction:[CCFadeOut actionWithDuration: 0]];
    [[CCDirector sharedDirector] resume];
}


- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    [starship touchEnded:touch];
    [pauseMessage runAction:[CCFadeIn actionWithDuration: 0]];
    [[CCDirector sharedDirector] pause];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [starship touchMoved:touch];
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
    [starship update:dt];
    for (CCSprite *enemy in enemis) {
        [self updateEnemy:enemy by:dt];
    }
}

- (void)updateEnemy:(CCSprite *)enemy by:(ccTime)dt
{
    int speed = 40;
    int enemywidthdiv2 = 40;
    int enemyheightdiv2= 40;
    enemy.position = ccp(enemy.position.x + speed*dt,
                         enemy.position.y + speed*dt);
    if (enemy.position.x > winSize.width + enemywidthdiv2)
        enemy.position = ccp(-enemywidthdiv2,enemy.position.y);
    if (enemy.position.y > winSize.height + enemyheightdiv2)
        enemy.position = ccp(enemy.position.x, -enemyheightdiv2);
}

- (void) dealloc 
{
    [starship release];
    [bullets release];
    [enemis release];
    [super dealloc];
}

@end
