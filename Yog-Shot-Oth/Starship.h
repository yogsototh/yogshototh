//
//  Starship.h
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 05/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "MainLayer.h"

// TODO Limit movement to inside winSize

@interface Starship : CCNode
{
    
    MainLayer *father;
    CCSprite *sprite;
    CGSize winSize;

    CGPoint positionAtTouchBegan;
    CGPoint initialTouch;
    CGPoint lastTouch;
    UITouch *firstTouch;
    
    CGFloat lastShotTime;
}
@property (retain,readwrite) MainLayer *father;
@property (readonly) CCSprite *sprite;
@property CGPoint positionAtTouchBegan;
@property CGPoint initialTouch;
@property CGPoint lastTouch;
@property CGFloat lastShotTime;

- (id)initWithWinSize:(CGSize)winSize;
- (void)update:(ccTime)dt;
- (void)touchBegan:(UITouch *)touch;
- (void)touchesEnded:(NSSet *)touches;
- (void)touchesMoved:(NSSet *)touches;
- (void)touchesOccured:(NSSet *)touches;

- (CGPoint)position;

-(CGPoint)findTouchIn:(NSSet *)touches closestTo:(CGPoint)lastTouch;
@end
