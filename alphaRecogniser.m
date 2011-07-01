//
//  alphaRecogniser.m
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

#import "alphaRecogniser.h"

#define DEFAULT_NB_SECTORS 8 // Number of sectors
#define DEFAULT_TIME_STEP 20 // Capture interval in ms
#define DEFAULT_PRECISION 8 // Precision of catpure in pixels 8
#define DEFAULT_FIABILITY 30 // Default fiability level

@implementation alphaRecogniser

/*
 NSValue *val = [points objectAtIndex:0];
 CGPoint p = [val CGPointValue];

 */

-(id)init{
    if ((self =  [super init])){
        points = [[NSMutableArray alloc]init];
        patterns = [pattern getConfiguredPatterns];
        [patterns retain];
        sectorRad= M_PI*2/DEFAULT_NB_SECTORS;
        anglesMap = [[NSMutableArray alloc]init];
        [self buildAnglesMap];
        globalInfos = [[Info alloc]init];
     //   [self testAllGestures];
    }
    return self;
}


//


-(void)startRecognition:(CGPoint) p{
    
    //[points addObject:[NSValue valueWithCGPoint:p]];
    
    globalInfos.lastPoint=p;
    globalInfos.rect = CGRectInfinite;
    globalInfos.moves=[[NSMutableArray alloc]init];
    globalInfos.minx = MAXFLOAT; 
    globalInfos.miny =MAXFLOAT;
    globalInfos.maxx = -1.0f * MAXFLOAT;
    globalInfos.maxy=-1.0f * MAXFLOAT;

}
-(void)addToRecognition:(CGPoint) p{
    
    
    float difx = p.x -globalInfos.lastPoint.x;
    float dify =p.y -globalInfos.lastPoint.y;
    
    float sqDist =difx*difx+dify*dify;
    float sqPrec =DEFAULT_PRECISION*DEFAULT_PRECISION;
    if (sqDist>sqPrec){
        [points addObject:[NSValue valueWithCGPoint:p]];

        [self addMove:(difx) dy:dify];
        globalInfos.lastPoint=p;
        
        
        if (p.x<globalInfos.minx)
                globalInfos.minx=p.x;
        
        if (p.x>globalInfos.maxx)
             globalInfos.maxx=p.x;
        
        if (globalInfos.lastPoint.y<globalInfos.miny)
            globalInfos.miny=p.y;
        if (globalInfos.lastPoint.y>globalInfos.maxy)
            globalInfos.maxy=p.y;

        
    }
}

-(pattern *)stopRecognition:(CGPoint) p{
    //[points addObject:[NSValue valueWithCGPoint:p]];
    
    return [self matchGesture];
}



-(pattern *)matchGesture{
    unsigned int bestCost=1000000;
    unsigned int cost;
    pattern * bestGesture =NULL;
    
    
    globalInfos.rect = CGRectMake(globalInfos.minx,globalInfos.miny,globalInfos.maxx-globalInfos.minx,globalInfos.maxy-globalInfos.miny);
    for (pattern *p in patterns){
       // cost = [self costLevenC:[p pathpatternAsNumbers]  comparedTo:globalInfos.moves];
        // cost = [self costLeven:[p pathpatternAsNumbers]  comparedTo:globalInfos.moves];
         cost = [self costLeven3:[p pathpatternAsNumbers]  comparedTo:globalInfos.moves];
        
        
       
        
        if (cost<=DEFAULT_FIABILITY){
            /*
            if ([[p matcher] isEqualToString:@""]){
                globalInfos.cost=cost;
                cost=[p match:globalInfos];
            }
             */
            if (cost<bestCost){
                bestCost=cost;
                bestGesture=p;
                 
            }
        
        }
    }
    
    if (bestGesture){
        //got the HOLY GRAAL
        NSLog (@"You Write %@", [bestGesture name]);
         NSLog (@"found %@", [bestGesture pathpatternAsNumbers]);
        NSLog (@"entry %@", globalInfos.moves);
    }
    
    return bestGesture;
}

-(void)addMove:(float) dx dy:(float)dy{
    
    float angle = atan2f(dy,dx) + sectorRad/2.0f;
    
   
    
    if (angle<0.0f)angle+=M_PI*2.0f;
    
    unsigned int no = floor(angle/(M_PI*2.0f)*100.0f);
    unsigned int before=-1;
    if ([globalInfos.moves count] !=0)
        before = [[globalInfos.moves objectAtIndex:[globalInfos.moves count]-1]intValue];
    if ([[anglesMap objectAtIndex:no]intValue] != before)
        [globalInfos.moves addObject:[anglesMap objectAtIndex:no]];
    
    
}
-(void)buildAnglesMap{
    
     float step = M_PI*2.0f/100.0f;
    
    // memorize sectors
    float sector;
    for (float i =-sectorRad/2.0f;i<=(M_PI*2.0f)-(sectorRad/2.0f);i+=step){
        sector=floor((i+sectorRad/2.0f)/sectorRad);
        [anglesMap addObject:[NSNumber numberWithInt:sector]];
    }
}

-(NSNumber *)difAngle:(NSNumber *)a withNumber:(NSNumber *)b{
    unsigned int dif = abs([a intValue]-[b intValue]);
    if (dif>DEFAULT_NB_SECTORS/2)dif=DEFAULT_NB_SECTORS-dif;
    
    
    return [NSNumber numberWithInt:dif];
}
/**
 *	return a filled 2D table
 */
-(NSMutableArray *)fill2DTable:(unsigned int)width  height:(unsigned int)height value :(int)value{
    
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (unsigned int i=0; i<width ; i++){
        NSMutableArray *seconde = [[NSMutableArray alloc]init];
        for (unsigned int j=0; j<height ; j++){
            [seconde addObject:[NSNumber numberWithInt:value]];
        }
        [result addObject:seconde];
        [seconde release];
    }
    return [result autorelease];
}


-(void)testAllGestures{
    NSLog(@"in test");
    
  
     for (pattern *entry in patterns){
         unsigned int bestCost=1000000;
         unsigned int cost;
         pattern * bestGesture =NULL;

            for (pattern *p in patterns){
                  cost = [self costLeven3:[p pathpatternAsNumbers]  comparedTo:[entry pathpatternAsNumbers]];
                
                
                if (cost<=DEFAULT_FIABILITY){
                    if (cost<bestCost){
                        bestCost=cost;
                        bestGesture=p;
                        
                    }                    
                }
            }
             
            if (bestGesture){
                //got the HOLY GRAAL
                NSLog (@"Pattern is (%@)  i found (%@)", [entry name],[bestGesture name]);
            }
      }
        
        
}



//algo
 
// 2 arrays of NSNUmber
-( int)costLeven:(NSArray*)a   comparedTo:(NSArray*)b{
    NSNumber *firstvalue = [a objectAtIndex:0];
    
    // point
    if ([firstvalue intValue]==-1){
        return ([b count]==0)  ? 0 : 100000;
    }
    
    // precalc difangles
    NSMutableArray * d =[self fill2DTable:[a count]+1 height:[b count]+1 value:0];
    
    NSMutableArray * w = [NSMutableArray arrayWithArray:d];
    
    
    for (unsigned int i=1; i<=[a count] ; i++){
        for (unsigned int j=1; j<[b count] ; j++){
            NSMutableArray *seconde = [d objectAtIndex:i];
            NSNumber *number = [self difAngle:[a objectAtIndex:i-1]  withNumber:[b objectAtIndex:j-1]];
            [seconde replaceObjectAtIndex:j withObject:number];
            
        }
    }
    // max cost
    NSNumber *number100000 =[NSNumber numberWithInt:100000]; 
    
     NSMutableArray *seconde = [w objectAtIndex:0];
    for (unsigned int y =1; y<[b count];y++){
    
       
        [seconde replaceObjectAtIndex:y withObject:number100000];

    }
    for (unsigned int x =1; x<[a count];x++){
        
        NSMutableArray *tierce = [w objectAtIndex:x];
        [tierce replaceObjectAtIndex:0 withObject:number100000];
        
    }
      NSMutableArray *zero = [w objectAtIndex:0];
    [zero replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:0]];
    
    // levensthein application

    
    unsigned int cost=0;
    unsigned int pa=0;
    unsigned int pb=0;
    unsigned int pc=0;
    unsigned int i;
    unsigned int j;
    
    for ( i=1; i<=[a count] ; i++){
        for ( j=1; j<[b count] ; j++){
             NSMutableArray *seconde = [d objectAtIndex:i];
            NSMutableArray *secondemoinsun = [w objectAtIndex:i-1];
            NSMutableArray *secondebis = [w objectAtIndex:i];
            cost = [[seconde objectAtIndex:j]intValue];
            pa = [[secondemoinsun objectAtIndex:j]intValue] + cost;
            pb = [[secondebis objectAtIndex:j-1]intValue]+cost;
            pc = [[secondemoinsun objectAtIndex:j-1]intValue]+cost;
            
            [secondebis replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:MIN(MIN(pa,pb),pc)]];
        }
    }
    NSMutableArray *r1 = [w objectAtIndex:i-1];
    return [[r1 objectAtIndex:j-1]intValue];
}




- (int) smallestOf: (int) a andOf: (int) b andOf: (int) c
{
    int min = a;
    if ( b < min )
        min = b;
    
    if( c < min )
        min = c;
    
    return min;
}

- (int) costLevenC: (NSArray *) stringA comparedTo:(NSArray *) stringB{

     int k, i, j, cost, * d,*w, distance;
    int n = [stringA count];
    int m = [stringB count];	
    
    
    d = malloc( sizeof(int) * (m+1) * (n+1) );
    w= malloc( sizeof(int) * (m+1) * (n+1) );
    for( k = 0; k < n+1; k++)
    {
        d[k] = 0;
        w[k] = 0;
    }
   
    for( k = 0; k < m+1; k++)
   {
       d[ k * n ] = 0;
       w[k * n] = 0;
   }
    for ( i=1; i<=n ; i++){
        for ( j=1; j<m ; j++){
            NSNumber *number = [self difAngle:[stringA objectAtIndex:i-1]  withNumber:[stringB objectAtIndex:j-1]];
            d[j*n + i]=[number intValue];
        }
    }
    
    for ( i=1; i<=n ; i++){
        for ( j=1; j<m ; j++){
            w[j*n + i]=1000000;
        }
    }
    w[0]=1000000;
    int x,y,pa,pb,pc;
    
    for (x=1;x<=n;x++){
        for (y=1;y<m;y++){
            cost=d[y*n +x];
            pa=w[y*n +x-1]+cost;
            pb=w[(y-1)*n + x]+cost;
            pc=w[(y-1)*n + x-1]+cost;
            
            w[y*n +x]=MIN(MIN(pa,pb),pc);
        }
    }
    
    distance= w[(y-1)*n + x-1];
    
    free(w);
    free(d);
    
    return distance;
}

 
- (int) costLeven3: (NSArray *) stringA comparedTo:(NSArray *) stringB
{
    
    
    // Step 1
    int k, i, j, cost, * d, distance;
    
    int n = [stringA count];
    int m = [stringB count];	
    
    if( n++ != 0 && m++ != 0 ) {
        
        d = malloc( sizeof(int) * m * n );
        
        // Step 2
        for( k = 0; k < n; k++)
            d[k] = k;
        
        for( k = 0; k < m; k++)
            d[ k * n ] = k;
        
        // Step 3 and 4
        for( i = 1; i < n; i++ )
            for( j = 1; j < m; j++ ) {
                
                // Step 5
                if( [[stringA objectAtIndex: i-1]isEqualToNumber:[stringB objectAtIndex: j-1]] )                   
                    cost = 0;
                else
                    cost = 1;
                
                // Step 6
                d[ j * n + i ] = [self smallestOf: d [ (j - 1) * n + i ] + 1
                                            andOf: d[ j * n + i - 1 ] +  1
                                            andOf: d[ (j - 1) * n + i -1 ] + cost ];
            }
        
        distance = d[ n * m - 1 ];
        
        free( d );
        return distance;
    }
    return 1000000;
}
 
- (void)dealloc
{
     [patterns release];
    [globalInfos release];
    [anglesMap release];
    [points release];
    [super dealloc];
}

@end
