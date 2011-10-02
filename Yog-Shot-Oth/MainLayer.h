//
//  mainLayer.h
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 24/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface MainLayer : CCLayer {
    CGSize winSize;
    CCSprite *starship;
    CCTexture2D *bulletTexture;
    NSMutableArray *bullets;
    CCTexture2D *enemyTexture;
    NSMutableArray *enemis;
    CGPoint initialTouch;
    CGPoint lastTouch;

}
-(CGFloat) restrictValue:(CGFloat)value Between:(CGFloat)minValue And:(CGFloat)maxValue;
@end
