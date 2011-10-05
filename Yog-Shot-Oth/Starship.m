//
//  Starship.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 05/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Starship.h"
#import "cocos2d.h"

@implementation Starship


-(id)init
{
    self = [super init];
    if (self) {
        // Initialization code here
    }
    return self;
}

- (id)initWithFile:(NSString *)file winSize:(CGSize)winSize
{
   [self initWithFile:@"Starship.png"];
    self.position = ccp(winSize.width/2, 50);
    return self;
}

@end
