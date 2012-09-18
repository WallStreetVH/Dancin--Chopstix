#import "Main.h"
#import <mach/mach_time.h>

#define RANDOM_SEED() srandom((unsigned)(mach_absolute_time() & 0xFFFFFFFF))

@interface Main(Private)
//- (void)initClouds;
//- (void)initCloud;
@end


@implementation Main

- (id)init {
//	NSLog(@"Main::init");
	
	if(![super init]) return nil;
	
	RANDOM_SEED();

/*	AtlasSpriteManager *spriteManager = [AtlasSpriteManager spriteManagerWithFile:@"sprites.png" capacity:10];
	[self addChild:spriteManager z:-1 tag:kSpriteManager];
 */   
 /*   AtlasSpriteManager *spriteManager2 = [AtlasSpriteManager spriteManagerWithFile:@"stairsAgainstBlack.jpg" capacity:10];
	[self addChild:spriteManager2 z:0 tag:kSpriteManager2];
*/
   
    
    AtlasSpriteManager *spriteManager2 = [AtlasSpriteManager spriteManagerWithFile:@"stairsMaster5.png" capacity:10];
	[self addChild:spriteManager2 z:-1 tag:kSpriteManager2];

    
  /*  AtlasSpriteManager *spriteManager = [AtlasSpriteManager spriteManagerWithFile:@"stairsMaster2.png" capacity:10];
	[self addChild:spriteManager z:-1 tag:kSpriteManager];
   */ 
   
    
//    AtlasSpriteManager *spriteManager = [AtlasSpriteManager spriteManagerWithFile:@"sprites.png" capacity:10];
  //  	[self addChild:spriteManager z:-1 tag:kSpriteManager];


    
    CGRect rect;
    CGPoint pos;
	switch(random()%4) {
            
        case 0: rect = CGRectMake(0,543,310,480);
           //     pos = ccp(160,240);
                break;
        case 1: rect = CGRectMake(312,540,317,480);
        //        pos = ccp(160,240);
                break;
        case 2: rect = CGRectMake(706,0,316,480);
         //   pos = ccp(160,240);
            break;
        case 3: rect = CGRectMake(706,484,317,480);

     //   case 3: rect = CGRectMake(320,317,320,480);
//        pos = ccp(160,240);
            break;
            //   case 2: rect = CGRectMake(451,77,92,100);break;
            //   case 3: rect = CGRectMake(545,77,92,100);break;
            
	}

	

    AtlasSprite *background = [AtlasSprite spriteWithRect:rect spriteManager:spriteManager2];
	[spriteManager2 addChild:background];
	background.position = CGPointMake(160,240);


    
/*    AtlasSprite *background = [AtlasSprite spriteWithRect:rect spriteManager:spriteManager];
	[spriteManager addChild:background];
	background.position = CGPointMake(160,240);
  */      
    //	[self initClouds];
    
 
    
	[self schedule:@selector(step:)];
    
    
	
	return self;
}

- (void)dealloc {
//	NSLog(@"Main::dealloc");
	[super dealloc];
}

/*- (void)initClouds {
//	NSLog(@"initClouds");
	
	currentCloudTag = kCloudsStartTag;
	while(currentCloudTag < kCloudsStartTag + kNumClouds) {
		[self initCloud];
		currentCloudTag++;
	}
	
	[self resetClouds];
}

- (void)initCloud {
	
	CGRect rect;
	switch(random()%3) {
		case 0: rect = CGRectMake(336,16,256,108); break;
		case 1: rect = CGRectMake(336,128,257,110); break;
		case 2: rect = CGRectMake(336,240,252,119); break;
		
			}	
	
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
	AtlasSprite *cloud = [AtlasSprite spriteWithRect:rect spriteManager:spriteManager];
	[spriteManager addChild:cloud z:3 tag:currentCloudTag];
	
	//cloud.opacity = 128;
}

- (void)resetClouds {
//	NSLog(@"resetClouds");
	
	currentCloudTag = kCloudsStartTag;
	
	while(currentCloudTag < kCloudsStartTag + kNumClouds) {
		[self resetCloud];

		AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
		AtlasSprite *cloud = (AtlasSprite*)[spriteManager getChildByTag:currentCloudTag];
		ccVertex2F pos = cloud.position;
		pos.y -= 480.0f;
		cloud.position = pos;
		
		currentCloudTag++;
	}
}

- (void)resetCloud {
	
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
	AtlasSprite *cloud = (AtlasSprite*)[spriteManager getChildByTag:currentCloudTag];
	
	float distance = random()%20 + 5;
	
	float scale = 5.0f / distance;
	cloud.scaleX = scale;
	cloud.scaleY = scale;
	if(random()%2==1) cloud.scaleX = -cloud.scaleX;
	
	CGSize size = cloud.contentSize;
	float scaled_width = size.width * scale;
	float x = random()%(320+(int)scaled_width) - scaled_width/2;
	float y = random()%(480-(int)scaled_width) + scaled_width/2 + 480;
	
	cloud.position = ccp(x,y);
}*/

- (void)step:(ccTime)dt {
//	NSLog(@"Main::step");
	
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
	
/*	int t = kCloudsStartTag;
	for(t; t < kCloudsStartTag + kNumClouds; t++) {
		AtlasSprite *cloud = (AtlasSprite*)[spriteManager getChildByTag:t];
		CGPoint pos = cloud.position;
		CGSize size = cloud.contentSize;
		pos.x += 0.1f * cloud.scaleY;
		if(pos.x > 320 + size.width/2) {
			pos.x = -size.width/2;
		}
		cloud.position = pos;
	}*/
	
}

@end
