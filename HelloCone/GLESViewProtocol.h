//
//  GLESViewProtocol.h
//  HelloCone
//
//  Created by Evghenii Nicolaev on 11/6/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@protocol OpenGLESViewDelegate <NSObject>

- (void)render;

@end

//-------------------------------------------------------------------

@protocol GLESViewProtocol <NSObject>

@required

@property (nonatomic, weak) id<OpenGLESViewDelegate> delegate;
@property (nonatomic, strong) EAGLContext *context;

- (void)setupLayer;
- (void)setupContext;
- (void)setupRenderBuffer;
- (void)setupFrameBuffer;
- (void)setupDisplayLink;
- (void)render;

@end
