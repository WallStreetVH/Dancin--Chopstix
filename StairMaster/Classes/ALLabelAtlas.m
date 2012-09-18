//
//  ALLabelAtlas.m
//  ALGame
//
//  Created by Adrian Diaconu on 7/7/09.
//  Copyright 2009 Indeeo, Inc. All rights reserved.
//

#import "ALLabelAtlas.h"

static NSMutableDictionary  *gLabelFontInfoDict = nil;


@implementation ALLabelAtlas

@synthesize kerning, glyphAdvanceValues;

- (id)initWithFile:(NSString *)file string:(NSString *)string
{
	NSDictionary	*atlasInfoDict = [self fontInfoDictFromFile:file];
	NSString		*atlasFile = [atlasInfoDict objectForKey:@"AtlasFile"];
	NSInteger		columns = [[atlasInfoDict objectForKey:@"AtlasColumns"] integerValue];
	NSInteger		glyphWidth = [[atlasInfoDict objectForKey:@"GlyphWidth"] integerValue];
	NSInteger		glyphHeight = [[atlasInfoDict objectForKey:@"GlyphHeight"] integerValue];
	NSArray			*advanceValues = [atlasInfoDict objectForKey:@"GlyphAdvanceValues"];
	char			startChar = [[atlasInfoDict objectForKey:@"AtlasStartChar"] charValue];
	
	return [self initWithString:string charMapFile:atlasFile atlasStartRect:CGRectMake(0, 0, glyphWidth, glyphHeight)
										startCharMap:startChar atlasColumns:columns glyphAdvanceValues:advanceValues];
}

- (id)initWithString:(NSString*) inString charMapFile: (NSString*) charmapfile atlasStartRect:(CGRect)startRect startCharMap:(char)c 
																atlasColumns:(int)columns glyphAdvanceValues:(NSArray *)advanceValues
{
	self = [super initWithString:inString charMapFile:charmapfile itemWidth:startRect.size.width itemHeight:startRect.size.height startCharMap:c];
	
	if(self)
	{
		atlasStartX = startRect.origin.x;
		atlasStartY = startRect.origin.y;
		atlasColumns = columns;
		atlasRows = ceil((float)[advanceValues count] / atlasColumns);
		kerning = 2;
		
		self.glyphAdvanceValues = advanceValues;
		
		for(NSNumber *glyphValNum in advanceValues)
		{
			float glyphVal = [glyphValNum floatValue];
			
			if(minGlyphAdvance <= 0)
				minGlyphAdvance = glyphVal;
			if(glyphVal <  minGlyphAdvance)
				minGlyphAdvance = glyphVal;
		}
		
		[self calculateMaxItems];
		[self updateAtlasValues];
	}
	
	return self;
}

- (void)dealloc
{
	self.glyphAdvanceValues = nil;
	[super dealloc];
}

- (void)setString:(NSString *)newString
{
	if( newString.length > textureAtlas_.totalQuads )
		[textureAtlas_ resizeCapacity: newString.length];

	[string release];
	string = [newString retain];
	
	[self calculateMaxItems];
	[self updateAtlasValues];
	
	transformAnchor_ = ccp((NSInteger)(contentSize_.width * anchorPoint_.x), (NSInteger)(contentSize_.height * anchorPoint_.y));
}

- (NSString *)string
{
	return string;
}

- (void)setKerning:(int)val
{
	kerning = val;
	[self calculateMaxItems];
	[self updateAtlasValues];
}

- (void)updateAtlasValues
{
	if(itemsPerRow == 0)
		return;
	
	int n = [string length];
	float kernedWidth = 0;
	float currentHeight = 0;
	
	ccV3F_C4B_T2F_Quad quad;

	contentSize_.width = 0;
	contentSize_.height = itemHeight;
	
	const char *s = [string UTF8String];

	for( int i=0; i<n; i++) {
		char a = s[i] - mapStartChar;
		float row = ((a % itemsPerRow) * texStepX) + (atlasStartX  / (float) [[textureAtlas_ texture] pixelsWide]);
		float col = ((a / itemsPerRow) * texStepY) + (atlasStartY / (float) [[textureAtlas_ texture] pixelsHigh]);
		
		quad.tl.texCoords.u = row;
		quad.tl.texCoords.v = col;
		quad.tr.texCoords.u = row + texStepX;
		quad.tr.texCoords.v = col;
		quad.bl.texCoords.u = row;
		quad.bl.texCoords.v = col + texStepY;
		quad.br.texCoords.u = row + texStepX;
		quad.br.texCoords.v = col + texStepY;
		
		quad.bl.vertices.x = (int)kernedWidth;
		quad.bl.vertices.y = (int)currentHeight;
		quad.bl.vertices.z = 0.0f;
		quad.br.vertices.x = (int)(kernedWidth + itemWidth);
		quad.br.vertices.y = (int)currentHeight;
		quad.br.vertices.z = 0.0f;
		quad.tl.vertices.x = (int)kernedWidth;
		quad.tl.vertices.y = (int)(currentHeight + itemHeight);
		quad.tl.vertices.z = 0.0f;
		quad.tr.vertices.x = (int)(kernedWidth + itemWidth);
		quad.tr.vertices.y = (int)(currentHeight + itemHeight);
		quad.tr.vertices.z = 0.0f;
		
		[textureAtlas_ updateQuad:&quad atIndex:i];
		
		contentSize_.width = MAX(contentSize_.width, kernedWidth + itemWidth);
		contentSize_.height = ABS(currentHeight) + itemHeight;
		
		if(s[i] == 10)	// newline
		{
			currentHeight -= (itemHeight * 0.5);
			kernedWidth = 0;
			//continue;
		}
		else
		{
			// advance for next glyph
			if(a < [glyphAdvanceValues count])
			{
				float glyphAdvance = [[glyphAdvanceValues objectAtIndex:a] floatValue];
				kernedWidth += glyphAdvance + kerning;
			}
			else
			{
				kernedWidth += minGlyphAdvance + kerning;
			}
		}
	}
}

- (void)calculateMaxItems
{
	itemsPerColumn = atlasRows;
	itemsPerRow = atlasColumns;
}


- (CGSize)contentSize
{
	return contentSize_;
}

#pragma mark -

- (NSDictionary *)fontInfoDictFromFile:(NSString *)file
{
	if(!gLabelFontInfoDict)
		gLabelFontInfoDict = [[NSMutableDictionary alloc] init];
	
	NSDictionary *infoDict = [gLabelFontInfoDict objectForKey:file];
	
	if(!infoDict)
	{
		NSString	*fullPath  = [[NSBundle mainBundle] pathForResource:[file stringByDeletingPathExtension] ofType:@"plist"];
		
		infoDict = [NSDictionary dictionaryWithContentsOfFile:fullPath];
		[gLabelFontInfoDict setObject:infoDict forKey:file];
	}
	
	return infoDict;
}



@end
