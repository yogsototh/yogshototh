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

@implementation Starship


-(id)init
{
    self = [super init];
    if (self) {
        // Initialization code here
    }
    return self;
}
@synthesize positionAtTouchBegan;
@synthesize initialTouch;
@synthesize lastTouch;
@synthesize sprite;

- (id)initWithWinSize:(CGSize)winSizeGiven
{
    self = [super init];
    if (self) {
        winSize = winSizeGiven;
        firstTouch = nil;
        sprite = [CCSprite spriteWithFile:@"Starship-aile.png"];
        sprite.position = ccp(winSize.width/2, 50);
        self.positionAtTouchBegan         = sprite.position;
        self.initialTouch       = self.positionAtTouchBegan;
        self.lastTouch          = self.positionAtTouchBegan;
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

-(void)update:(ccTime)dt {
    sprite.position = ccpAdd(self.positionAtTouchBegan, ccpSub(self.initialTouch, self.lastTouch));

    sprite.position = ccpRestrict(sprite.position,sprite.boundingBox.size,winSize);
}

@end
