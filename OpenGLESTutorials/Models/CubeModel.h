//
//  Cube.h
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 11/12/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

const float cubeVertices[] = {
    
    -0.5f, -0.5f, 0.0f,
    -0.5f, 0.5f, 0.0f,
    0.5f, 0.5f, 0.0f,
    0.5f, -0.5f, 0.0f,
    -0.5f, -0.5f, -1.0f,
    -0.5f, 0.5f, -1.0f,
    0.5f, 0.5f, -1.0f,
    0.5f, -0.5f, -1.0f

};

const UInt8 cubeIndexes[] = {
    
    0, 1, 3,
    3, 1, 2,
    
    2, 1, 6,
    6, 1, 5,
    
    5, 1, 0,
    0, 5, 4,
    
    4, 0, 3,
    3, 4, 7,
    
    7, 3, 2,
    2, 6, 7,
    
    6, 5, 7,
    7, 5, 4
};

const int cubeIndexCount = sizeof(cubeIndexes) / sizeof(UInt8);
