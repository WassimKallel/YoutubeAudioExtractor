//
//  YoutubeApi.m
//  JXcoreHTTPServer
//
//  Created by Wassim Kallel on 15/06/2016.
//  Copyright © 2016 Nubisa. All rights reserved.
//


#import "JXcore.h"
#import "YoutubeApi.h"

static bool initialized = false;
static void callback(NSArray *args, NSString *return_id) { }

@implementation YoutubeApi

- (id)init
{
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // do not initialize JXcore twice
        if (initialized) return self;
        initialized = true;
        
        // makes JXcore instance running under it's own thread
        [JXcore useSubThreading];
        
        // start engine (main file will be JS/main.js. This is the initializer file)
        [JXcore startEngine:@"JS/main"];
        
        
        // Listen to Errors on the JS land
        [JXcore addNativeBlock:^(NSArray *params, NSString *callbackId) {
            NSString *errorMessage = (NSString*)[params objectAtIndex:0];
            NSString *errorStack = (NSString*)[params objectAtIndex:1];
            
            NSLog(@"Error!: %@\nStack:%@\n", errorMessage, errorStack);
        } withName:@"OnError"];
        
        
        // Second native method for JS side
        [JXcore addNativeBlock:^(NSArray *params, NSString *callbackId) {
            if (params == nil || [params count] == 0)
            {
                NSLog(@"error starting server");
            }
        } withName:@"SetIPAddress"];
        
        
        // Start the application (app.js)
        NSArray *params = [NSArray arrayWithObjects:@"app.js", nil];
        [JXcore callEventCallback:@"StartApplication" withParams:params];
    return self;
}

-(BOOL) initialized
{
    return initialized;
}

-(NSString *) getDirectUrl:(NSString *)url
{
    NSArray *params = [NSArray arrayWithObjects:url, nil];
    [JXcore callEventCallback:@"UpdateLink" withParams:params];
    NSString *newUrl = nil;
    while(newUrl == nil || [newUrl  isEqual: @""]) {
        newUrl = [self getDataFrom:@"http://127.0.0.1:3000"];
    }
    NSLog(@"%@", newUrl);
    return newUrl;
}


    
- (NSString *) getDataFrom:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}


@end
