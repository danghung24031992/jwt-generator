
#import "RNJwtGenerator.h"
#import <React/RCTLog.h>
#import "NSDictionary+JSONString.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation RNJwtGenerator

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(encode:(NSString *)algorithmByName
                  payload:(NSDictionary *)payload
                  secret:(NSString *)secret
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject )
{
    
    
    NSString * header = [NSString stringWithFormat:@"{\"typ\":\"JWT\",\"alg\":\"%@\"}",algorithmByName];
    NSString *headerEncode = [self encode:header];
    NSString * json = [payload jsonStringWithPrettyPrint:NO];
    NSString * payloadEncode = [self encode:json];
    NSString *signatureStr = [NSString stringWithFormat:@"%@.%@",headerEncode,payloadEncode];
    NSString * signature = [self HmacSHA256:signatureStr key:secret];
    NSString * token = [NSString stringWithFormat:@"%@.%@.%@",headerEncode,payloadEncode,signature];
    resolve(token);
}

/**
 * Encodes a String with Base64Url and no padding
 *
 * @param input String to be encoded
 * @return Encoded result from input
 */

-(NSString *)encode:(NSString *)str{
    // Create NSData object
    NSData *nsdata = [str dataUsingEncoding:NSUTF8StringEncoding];
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    return base64Encoded;
}



-(NSString *)HmacSHA256:(NSString *)data key:(NSString *)key{
    const char *cKey    =[key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData   =[data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    NSString *hash =[HMAC base64EncodedStringWithOptions:0];
    return hash;
}

@end
  
