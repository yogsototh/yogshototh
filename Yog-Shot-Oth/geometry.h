//
//  geometry.h
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreGraphics/CGBase.h>	// CGFloat
#import <CoreGraphics/CGGeometry.h>	// CGPoint

#ifndef Yog_Shot_Oth_geometry_h
#define Yog_Shot_Oth_geometry_h

CGFloat yrestrict(CGFloat value, CGFloat min, CGFloat max);
CGPoint ccpRestrict(CGPoint pos, CGSize size, CGSize window);

#endif
