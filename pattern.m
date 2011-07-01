//
//  pattern.m
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

#import "pattern.h"
#import "Matcher.h"


@implementation pattern
@synthesize name;
@synthesize pathpattern;
@synthesize matcher;

+(NSArray*)getConfiguredPatterns{
    NSString *defaultsFilePath = [[NSBundle mainBundle] pathForResource:@"patterns" ofType:@"plist"] ;
    NSArray *arr=[NSArray arrayWithContentsOfFile:defaultsFilePath] ;
    
    NSMutableArray *result= [[NSMutableArray alloc]initWithCapacity:[arr count]];
  
    for (NSDictionary *pat in arr){
        NSString* name =[pat objectForKey:@"name"];
        NSString* pathpattern=[pat objectForKey:@"pattern"];;
        NSString* matcher=[pat objectForKey:@"matcher"];;

        pattern *p = [[pattern alloc]initWithParams:name pattern:pathpattern matcher:matcher];
        [result addObject:p];
        [p release];
    }
    return  [result autorelease] ;
    
   
    
}

//init part
-(id)initWithParams:(NSString*) aname pattern:(NSString*)apattern matcher:(NSString*)amatcher{

    if ((self = [super init])){
        self.name =[aname retain ];
        self.pathpattern=[apattern retain ];
        self.matcher=[amatcher retain ];

    }
    return self;
}




-(NSArray*) pathpatternAsNumbers{
     NSMutableArray *result= [NSMutableArray array];
    
    for (NSUInteger i=0;i< self.pathpattern.length;i++){
        unichar ch = [self.pathpattern characterAtIndex:i];
        
        switch (ch) {
            case '0':
            {
                [result addObject:[NSNumber numberWithInt:0]];
            }
                break;
            case '1':
            {
                [result addObject:[NSNumber numberWithInt:1]];
            }
                break;
            case '2':
            {
                [result addObject:[NSNumber numberWithInt:2]];
            }
                break;
            case '3':
            {
                [result addObject:[NSNumber numberWithInt:3]];
            }
                break;
            case '4':
            {
                [result addObject:[NSNumber numberWithInt:4]];
            }
                break;
            case '5':
            {
                [result addObject:[NSNumber numberWithInt:5]];
            }
                break;
            case '6':
            {
                [result addObject:[NSNumber numberWithInt:6]];
            }
                break;
            case '7':
            {
                [result addObject:[NSNumber numberWithInt:7]];
            }
                break;
            case '8':
            {
                [result addObject:[NSNumber numberWithInt:8]];
            }
                break;
            case '9':
            {
                [result addObject:[NSNumber numberWithInt:9]];
            }
                break;
            default:
                break;
        }
    }
    
    return result;
}


-(unsigned int)match:(Info *) info{
    Matcher* m =[[ Matcher alloc]initWithName:self.matcher];
    
    unsigned int result = [m match:info];
    
       NSLog(@"match pattern,y (%@,%f)",self.name, result*1.0f );
    
    [m release];
    return result;
}
- (void)dealloc
{
    self.name =nil;
    self.pathpattern=nil;
    self.matcher=nil;
    
    [super dealloc];
}

@end
