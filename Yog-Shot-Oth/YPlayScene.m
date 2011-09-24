//
//  YPlayScene.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 24/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YPlayScene.h"
#import "HelloWorldLayer.h"

@implementation YPlayScene

- (id)init
{
    self = [super init];
    if (self) {
        // 'layer' is an autorelease object.
        HelloWorldLayer *layer = [HelloWorldLayer node];
        
        // add layer as a child to scene
        [self addChild: layer];
        // Initialization code here.
    }
    
    return self;
}

@end
