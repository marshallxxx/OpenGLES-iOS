//
//  GLESTwoView.m
//  HelloCone
//
//  Created by Evghenii Nicolaev on 11/6/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import "GLESTwoView.h"

@implementation GLESTwoView

- (instancetype)initWithFrame:(CGRect) frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setupContext {
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (self.context == nil || [EAGLContext setCurrentContext:self.context] == NO) {
        NSLog(@"Cannot create context");
        exit(EXIT_FAILURE);
    }
}

- (void)setupRenderBuffer {
    glGenRenderbuffers(1, &renderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, renderBuffer);
    
    [self.context renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer*)self.layer];
}

- (void)setupFrameBuffer {
    glGenFramebuffers(1, &frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
    
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, renderBuffer);
    
}

- (void)render {
    glClearColor(1.0, 0.0, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [self.context presentRenderbuffer:GL_RENDERBUFFER];
}

@end
