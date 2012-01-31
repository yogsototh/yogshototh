//
//  SSBullet.h
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 14/01/12.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"
#import "MainLayer.h"
#import "Bullet.h"

@interface SSBullet : Bullet

- (id)initWithStartPosition:(CGPoint)fromPosition withSpeed:(CGPoint)initSpeed andMainLayer:(MainLayer *)mainLayer;

@end
