//
//  Event.m
//  Tabitha
//
//  The Event object 
//
//  Created by John DiGiorgio on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Event.h"

@implementation Event
@synthesize english, description, imageURL, movieURL, written, category, category2, image;

-(id)initWithName:(NSString *)n description:(NSString *)d url:(NSString *)u url:(NSString *)m written:(NSString *)w category:(NSString *)c category2:(NSString *)c2 image:(NSString *)i{
	self.english = n;    // event name
	self.description = d;  // event description
	self.imageURL = u;   // event date
	self.movieURL = m; // snack
	self.written = w; // snack details
	self.category = c; // subID
	self.category2 = c2; // event time
    self.image = i; //image
	return self;
}
@end
