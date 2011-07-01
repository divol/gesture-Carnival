//
//  Info.m
//  gesture-recognition_test
//
//  Created by jdivol on 29/06/11.
/*
 *	This work is based on Action Script Mouse Gesture Recognizer
 *	
 *	from Didier Brun
 * 	@link		http://www.bytearray.org/?p=91
 
 * 	This class is under RECIPROCAL PUBLIC LICENSE.
 * 	http://www.opensource.org/licenses/rpl.php
 * 
 * 	Please, keep this header and the list of all authors
 */

#import "Info.h"


@implementation Info

@synthesize  lastPoint;
@synthesize  rect;
@synthesize  minx;
@synthesize  maxx;
@synthesize  miny;
@synthesize  maxy;
@synthesize   moves;
@synthesize   cost;


- (void)dealloc
{
    self.moves=nil;
    [super dealloc];
}


@end
