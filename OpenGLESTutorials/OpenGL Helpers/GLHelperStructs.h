//
//  GLHelperStructs.h
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 11/12/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#ifndef GLHelperStructs_h
#define GLHelperStructs_h



typedef struct {
    float R;
    float G;
    float B;
    float A;
} Color4f;

typedef struct {
    float X;
    float Y;
    float Z;
}Position3Df;

typedef struct {
    Position3Df Position;
    Color4f Color;
} Vertext3Df;

typedef struct {
    float fromValue;
    float toValue;
    float currentValue;
    float duration;
    float timeElapsed;
    _Bool animationStopped;
} Animation;

typedef struct {
    float radius;
    float currentValue;
    float duration;
    float timeElapsed;
    _Bool animationStopped;
} AnimationCircle;

#if defined __cplusplus
extern "C" {
#endif
    
    extern Color4f Color4fMake(float R, float G, float B, float A);
    
#if defined __cplusplus
};
#endif

#endif /* GLHelperStructs_h */