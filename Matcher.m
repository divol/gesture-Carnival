//
//  Matcher.m
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

#import "Matcher.h"


@implementation Matcher



-(id)initWithName:(NSString *) nom{
    if ((self = [super init])){
        name = [NSString stringWithString:nom];
        [name retain];
    }
    return self;
}

-(unsigned int)match:(Info *) info
{
    NSInvocation *anInvocation;
    SEL sel = NSSelectorFromString(name);
    unsigned int result=10000;
    
    if (sel){
        NSMethodSignature * aSignature = [Matcher instanceMethodSignatureForSelector:sel];
        if (aSignature){
            anInvocation = [NSInvocation invocationWithMethodSignature:aSignature];
            
            [anInvocation setSelector:sel];
            
            [anInvocation setTarget:self];
            
            [anInvocation setArgument:&info atIndex:2];
            
            [anInvocation invoke];
            
            [anInvocation getReturnValue:&result];
        }
    }
    
    return result;
}

- (void)dealloc
{
    [name release];
    [super dealloc];
}





///////////////// matching functions

-(unsigned int)gMatch:(Info *) info{
 //   var py:Number=(infos.lastPoint.y-infos.rect.y)/(infos.rect.height);
//    return py>.3 ? infos.cost : 10000;
    
    float py = (info.lastPoint.y -info.rect.origin.y)/(info.rect.size.height);
     return py>0.3f ? info.cost : 10000;

}
-(unsigned int)qMatch:(Info *) info{
  //  var py:Number=(infos.lastPoint.y-infos.rect.y)/(infos.rect.height);
   // return py<.3 ? infos.cost : 10000;

    
    float py = (info.lastPoint.y -info.rect.origin.y)/(info.rect.size.height);
    return py<0.3f ? info.cost : 10000;
}
-(unsigned int)dMatch:(Info *) info{
    //			var py:Number=(infos.lastPoint.y-infos.rect.y)/(infos.rect.height);
    //return py>.8 ? infos.cost : 10000;
    
    float py = (info.lastPoint.y -info.rect.origin.y)/(info.rect.size.height);
    return py>0.8f ? info.cost : 10000;

}
-(unsigned int)pMatch:(Info *) info{
    //			var py:Number=(infos.lastPoint.y-infos.rect.y)/(infos.rect.height);
//    return py<.7 ? infos.cost : 10000;
    float py = (info.lastPoint.y -info.rect.origin.y)/(info.rect.size.height);
    return py<0.7f ? info.cost : 10000;

    

}
-(unsigned int)oMatch:(Info *) info{
    //			var py:Number=(infos.lastPoint.y-infos.rect.y)/(infos.rect.height);
    //return py<.3 ? infos.cost : 10000;
    
    float py = (info.lastPoint.y -info.rect.origin.y)/(info.rect.size.height);
    return py<0.3f ? info.cost : 10000;


}
-(unsigned int)sixMatch:(Info *) info{
 //   var py:Number=(infos.lastPoint.y-infos.rect.y)/(infos.rect.height);
 //   return py>.3 ? infos.cost : 10000;
    float py = (info.lastPoint.y -info.rect.origin.y)/(info.rect.size.height);
    return py>0.3f ? info.cost : 10000;

}
-(unsigned int)fiveMatch:(Info *) info{
    //			var pos:int=infos.moves.join("").indexOf("111");
    //return pos==-1 ? infos.cost : 10000;
    
    return info.cost;

}
-(unsigned int)sMatch:(Info *) info{
   // var pos:int=infos.moves.join("").indexOf("111");
    //return pos>-1 ? infos.cost : 10000;
     return 10000;
}
@end
