//
//  geometry.c
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#include "geometry.h"

CGFloat yrestrict(CGFloat value, CGFloat min, CGFloat max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}

CGPoint ccpRestrict(CGPoint pos, CGSize size, CGSize window) {
    CGPoint res;
    CGFloat halfwidth=size.width/2;
    CGFloat halfheight=size.height/2;
    res.x = yrestrict(pos.x, halfwidth, window.width - halfwidth);
    res.y = yrestrict(pos.y, halfheight, window.height - halfheight);
    return res;
}

BOOL youtsideSegment(CGFloat value, CGFloat min, CGFloat max) {
    if (value < min) return YES;
    if (value > max) return YES;
    return NO;
}

BOOL outOfWindow(CGPoint pos, CGSize size, CGSize windowSize) {
    CGFloat halfwidth=size.width/2;
    CGFloat halfheight=size.height/2;
    return youtsideSegment(pos.x, -halfwidth,  windowSize.width + halfwidth) ||
           youtsideSegment(pos.y, -halfheight, windowSize.height + halfheight);
}