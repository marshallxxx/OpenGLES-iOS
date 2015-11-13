//
//  LessonProtocol.h
//  HelloCone
//
//  Created by Evghenii Nicolaev on 11/6/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLView.h"
#import "GLHelperStructs.h"

typedef enum {
    GLES_VERSION_1,
    GLES_VERSION_2
} GLES_VERSION;

@protocol LessonProtocol <NSObject>

@required
@property (nonatomic, strong) GLView *glView;
+ (GLES_VERSION)glesVersionUse;
+ (instancetype)startLessonWithView:(GLView *) openGLView;

@end
