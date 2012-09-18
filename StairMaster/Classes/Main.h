#import "cocos2d.h"

//#define RESET_DEFAULTS

#define kFPS 60

//#define kNumClouds			12

#define kMinPlatformStep	50
#define kMaxPlatformStep	100
//#define kNumPlatforms       2
#define kPlatformTopPadding 10

#define kMinBonusStep		30
#define kMaxBonusStep		50

enum {
	kSpriteManager = 0,
    kSpriteManager2 = 0,
	kBird,
    kDude1,
    kDude2,
    kDude3,
    kDude4,
    kStairs1,
    kPause,
    kPlay,
    kPower,
    kStarburst,
    kExplosion,
	kScoreLabel,
    kTouchLabel,
    kTimeLabel,
    kLevelLabel,
    kLivesLabel,
    kSplash,
    kAngelTime,
    kBullet1,
    kBullet2,
    kBlood,
    kBomb,
    kBomb2,
    kBomb3,
    kBomb4,
    kBomb5,
    kMoney1,
    kMoney2,
 //   kLeaderboardID = "1",
//	kCloudsStartTag = 100,
	kPlatformsStartTag = 200,
	kBonusStartTag = 300
};

enum {
	kBonus5 = 0,
	kBonus10,
	kBonus50,
	kBonus100,
	kNumBonuses
};

@interface Main : Layer
{
//	int currentCloudTag;
   
}
//- (void)resetClouds;
//- (void)resetCloud;
- (void)step:(ccTime)dt;
@end
