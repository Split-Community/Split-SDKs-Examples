#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "JFBCrypt.h"
#import "JFGC.h"
#import "JFRandom.h"

FOUNDATION_EXPORT double SplitVersionNumber;
FOUNDATION_EXPORT const unsigned char SplitVersionString[];

