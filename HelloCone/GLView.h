//
//  GLView.h
//  HelloCone
//
//  Created by Evghenii Nicolaev on 11/6/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLESViewProtocol.h"

@interface GLView : UIView <GLESViewProtocol> {
    GLuint renderBuffer;
    GLuint frameBuffer;
}

@end
