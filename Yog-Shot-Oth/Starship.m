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
    self.positionAtTouchBegan = sprite.position;
    self.initialTouch = [self positionFromTouch:touch];
    self.lastTouch = self.initialTouch;
}

-(void)touchEnded:(UITouch *)touch {}

-(void)touchMoved:(UITouch *)touch {
    //Simply store the touch location for later processing by the
    self.lastTouch = [self positionFromTouch:touch];
}

-(CGPoint)findTouchIn:(NSSet *)touches closestTo:(CGPoint)targetPosition {
    CGPoint closest;
    CGPoint position;
    CGFloat minDist=winSize.width + winSize.height;
    for (UITouch *touch in touches) { 
        position=[self positionFromTouch:touch];
        if (ccpDistance(position, targetPosition) < minDist)
            closest = position;
    }
    return closest;
}

-(void)touchesOccured:(NSSet *)touches {
    //Simply store the touch location for later processing by the
    NSLog(@"Multiple touches occured");
    self.lastTouch = [self findTouchIn:touches closestTo:lastTouch];
}

-(void)update:(ccTime)dt {
    sprite.position = ccpAdd(self.positionAtTouchBegan, ccpSub(self.initialTouch, self.lastTouch));

    sprite.position = ccpRestrict(sprite.position,sprite.boundingBox.size,winSize);
}

@end
