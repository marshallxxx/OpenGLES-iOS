//
//  GLHelperStructs.c
//  HelloCone
//
//  Created by Evghenii Nicolaev on 11/12/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#include "GLHelperStructs.h"

Color4f Color4fMake(float R, float G, float B, float A) {
    Color4f newColor;
    newColor.R = R;
    newColor.G = G;
    newColor.B = B;
    newColor.A = A;
    return newColor;
}