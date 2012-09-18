//
//  Event.h
//  Tabitha
//
//  Created by John DiGiorgio on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

// Events object
@interface Event : NSObject {
	NSString *english; // event title
	NSString *description; // event description
	NSString *imageURL; // event date
	NSString *movieURL; // snack? 
	NSString *written; // snack details
	NSString *category; // subID
	NSString *category2; // N/A
    NSString *image; // user or provider image
    int tio;

}

@property (nonatomic, retain) NSString *english;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) NSString *movieURL;
@property (nonatomic, retain) NSString *written;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *category2;
@property (nonatomic, retain) NSString *image;


-(id)initWithName:(NSString *)n description:(NSString *)d url:(NSString *)u url:(NSString *)m written:(NSString *)w category:(NSString *)c category2:(NSString *)c2 image:(NSString *)i;

@end
