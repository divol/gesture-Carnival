//
//  pattern.h
//  gesture-recognition_test
//
//  Created by divol on 28/06/11.
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
#import "Info.h"

@interface pattern : NSObject {
    NSString* name;
    NSString* pathpattern;
    NSString* matcher;
}
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* pathpattern;
@property (nonatomic, retain) NSString* matcher;

+(NSArray*)getConfiguredPatterns;

//init part
-(id)initWithParams:(NSString*) aname pattern:(NSString*)apattern matcher:(NSString*)amatcher;


-(unsigned int)match:(Info *) info;
-(NSArray*) pathpatternAsNumbers;
@end
