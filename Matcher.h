//
//  Matcher.h
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

#import <Foundation/Foundation.h>
#import "Info.h"

@interface Matcher : NSObject {
    NSString  * name;
    
}

-(id)initWithName:(NSString *) nom;

-(unsigned int)match:(Info *) info;



-(unsigned int)gMatch:(Info *) info;
-(unsigned int)qMatch:(Info *) info;
-(unsigned int)dMatch:(Info *) info;
-(unsigned int)pMatch:(Info *) info;
-(unsigned int)oMatch:(Info *) info;
-(unsigned int)sixMatch:(Info *) info;
-(unsigned int)fiveMatch:(Info *) info;
-(unsigned int)sMatch:(Info *) info;


@end
