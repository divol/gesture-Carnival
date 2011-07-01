//
//  Info.h
//  gesture-recognition_test
//
//  Created by jdivol on 29/06/11.
//
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

#import <Foundation/Foundation.h>


@interface Info : NSObject {
    CGPoint lastPoint;
    CGRect rect;
    float minx;
    float maxx;
    float miny;
    float maxy;
    NSMutableArray *moves;
    unsigned int cost;
}
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) float minx;
@property (nonatomic, assign) float maxx;
@property (nonatomic, assign) float miny;
@property (nonatomic, assign) float maxy;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, retain) NSMutableArray *moves;
@property (nonatomic, assign) unsigned int cost;

@end
