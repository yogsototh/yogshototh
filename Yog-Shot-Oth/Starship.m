//
//  Starship.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 05/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Starship.h"
#import "cocos2d.h"
#import "CCSprite.h"
#import "geometry.h"
#import "SSBullet.h"

@implementation Starship


-(id)init
{
    self = [super init];
    if (self) {
        // Initialization code here
    }
    return self;
}
@synthesize father;
@synthesize positionAtTouchBegan;
@synthesize initialTouch;
@synthesize lastTouch;
@synthesize sprite;
@synthesize lastShotTime;

- (id)initWithWinSize:(CGSize)winSizeGiven
{
    self = [super init];
    if (self) {
        winSize = winSizeGiven;
        firstTouch = nil;
        sprite = [CCSprite spriteWithFile:@"pentacleOne.png"];
        sprite.position = ccp(winSize.width/2, 50);
        self.positionAtTouchBegan         = sprite.position;
        self.initialTouch       = self.positionAtTouchBegan;
        self.lastTouch          = self.positionAtTouchBegan;
        self.lastShotTime       = 0.0;
        [self addChild:sprite];
    }
    return self;
}

- (CGPoint) position {
    return sprite.position;
}

-(CGPoint) positionFromTouch:(UITouch *)touch
{
    CGPoint position=[touch locationInView:[touch view]];
    position.x = winSize.width - position.x; // SHOULD UNDERSTAND WHY
    return position;
}

-(void)touchBegan:(UITouch *)touch {
    if (firstTouch != nil) return;
    firstTouch = touch;
    self.positionAtTouchBegan = sprite.position;
    self.initialTouch = [self positionFromTouch:touch];
    self.lastTouch = self.initialTouch;
}

-(void)touchesOccured:(NSSet *)touches {
    //Simply store the touch location for later processing by the
    if (firstTouch != nil) return;    
    [self touchBegan:[touches anyObject]];
}


-(void)touchesEnded:(NSSet *)touches { 
    for (UITouch *touch in touches) {
        if (touch == firstTouch) {
            firstTouch=nil;
        }
    }
}

-(void)touchesMoved:(NSSet *)touches {
    //Simply store the touch location for later processing by the
    for (UITouch *touch in touches) {
        if (firstTouch == touch) {
            self.lastTouch = [self positionFromTouch:touch];
            return;
        }
    }
}

-(CGPoint)findTouchIn:(NSSet *)touches closestTo:(CGPoint)targetPosition {
    if ([touches count] == 1) {
        return [self positionFromTouch:[touches anyObject]];
    }
    CGPoint closest;
    CGPoint position;
    CGFloat minDist=INTMAX_MAX;
    CGFloat dist;
    for (UITouch *touch in touches) { 
        position=[self positionFromTouch:touch];
        dist=ccpDistance(position, targetPosition);
        if (dist < minDist) {
            closest = position;
            minDist = dist;
        }
    }
    return closest;
}

-(void)shot {
    SSBullet *newBullet = [[SSBullet alloc] initWithStartPosition:self.position withSpeed:ccp(0.0, 10.0) andMainLayer:father];

    [self.father addSSBullet:newBullet];
}

-(void)update:(ccTime)dt {
    // sensibility is 1.2
    sprite.position = ccpAdd(self.positionAtTouchBegan, ccpMult(ccpSub(self.initialTouch, self.lastTouch),1.2));

    sprite.position = ccpRestrict(sprite.position,sprite.boundingBox.size,winSize);
    lastShotTime += dt;
    if (lastShotTime > 0.1) {
        lastShotTime = 0;
        [self shot];
    }
}

@end
