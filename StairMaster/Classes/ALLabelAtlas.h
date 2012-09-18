//
//  ALLabelAtlas.h
//  ALGame
//
//  Created by Adrian Diaconu on 7/7/09.
//  Copyright 2009 Indeeo, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface ALLabelAtlas : LabelAtlas
{
	int				atlasStartX;
	int				atlasStartY;
	int				kerning;
	int				minGlyphAdvance;
	NSUInteger		atlasColumns;
	NSUInteger		atlasRows;
	NSArray			*glyphAdvanceValues;
}

@property (assign) int		kerning;
@property (retain) NSArray	*glyphAdvanceValues;

- (id)initWithFile:(NSString *)file string:(NSString *)string;
- (id)initWithString:(NSString *)inString charMapFile:(NSString *)charmapfile atlasStartRect:(CGRect)startRect startCharMap:(char)c 
															atlasColumns:(int)columns glyphAdvanceValues:(NSArray *)advanceValues;
- (void)setString:(NSString *)newString;
- (NSString *)string;

// private
- (void)calculateMaxItems;
- (NSDictionary *)fontInfoDictFromFile:(NSString *)file;
@end
