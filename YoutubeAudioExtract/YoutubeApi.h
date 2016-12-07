//
//  YoutubeApi.h
//  JXcoreHTTPServer
//
//  Created by Wassim Kallel on 15/06/2016.
//  Copyright © 2016 Nubisa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YoutubeApi : NSObject

-(BOOL) initialized;
-(NSString *) getDirectUrl:(NSString *)url;
@end
