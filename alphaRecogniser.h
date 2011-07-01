//
//  alphaRecogniser.h
//  gesture-recognition_test
//
//  Created by jdivol on 27/06/11.
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
#import "pattern.h"
#import "Info.h"

@interface alphaRecogniser : NSObject {
    NSMutableArray * points;
    NSArray *patterns;
    float sectorRad ;
    NSMutableArray *anglesMap;					// Angles map 
    
    Info * globalInfos;

}
// events 
-(void)startRecognition:(CGPoint) p;
-(void)addToRecognition:(CGPoint) p;
-(pattern *)stopRecognition:(CGPoint) p;
-(void)addMove:(float) dx dy:(float)dy;
-(void)buildAnglesMap;
-(pattern *)matchGesture;
//algo
-(int)costLeven:(NSArray*)a   comparedTo:(NSArray*)b;
- (int) costLeven3: (NSArray *) stringA comparedTo:(NSArray *) stringB;
//test
-(void)testAllGestures;
@end
