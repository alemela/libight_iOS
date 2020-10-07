#import "Engine.h"
#import <oonimkall/Oonimkall.h>

@implementation Engine

/** newUUID4 returns the a new UUID4 for this client  */
+ (NSString*) newUUID4 {
    return OonimkallNewUUID4();
}

/** startExperimentTaskWithSettings starts the experiment described by the provided settings. */
+ (id<OONIMKTask>) startExperimentTaskWithSettings:(id<OONIMKTaskConfig>)settings error:(NSError **)error{
    return [[PEMKTask alloc] initWithTask:OonimkallStartTask(settings.serialization, error)];
}

/** resolveProbeCC returns the probeCC. */
+ (NSString*) resolveProbeCCWithSoftwareName:(NSString*)softwareName
                             softwareVersion:(NSString*)softwareVersion
                                     timeout:(long)timeout
                                       error:(NSError **)userError {
    NSError *error;
    PESession* session = [[PESession alloc] initWithConfig:
                          [Engine getDefaultSessionConfigWithSoftwareName:softwareName
                                                          softwareVersion:softwareVersion
                                                                   logger:[LoggerNull new]]
                                                                    error:&error];
    if (error != nil) {
        if (userError != nil) *userError = error;
        return nil;
    }
    // Updating resources with no timeout because we don't know for sure how much
    // it will take to download them and choosing a timeout may prevent the operation
    // to ever complete. (Ideally the user should be able to interrupt the process
    // and there should be no timeout here.)
    [session maybeUpdateResources:[session newContext] error:&error];
    if (error != nil) {
        if (userError != nil) *userError = error;
        return nil;
    }
    return [session geolocate:[session newContextWithTimeout:timeout] error:&error].country;
}

/** newSession returns a new OONISession instance. */
+ (id<OONISession>) newSession:(OONISessionConfig*)config error:(NSError **)error {
    id<OONISession> session = [[PESession alloc] initWithConfig:config error:error];
    return session;
}

/** getDefaultSessionConfig returns a new SessionConfig with default parameters. */
+ (OONISessionConfig*) getDefaultSessionConfigWithSoftwareName:(NSString*)softwareName
                                               softwareVersion:(NSString*)softwareVersion
                                                        logger:(id<OONILogger>)logger {
    OONISessionConfig* config = [OONISessionConfig new];
    config.logger = [[LoggerComposed alloc] initWithLeft:logger right:[LoggeriOS new]];
    config.softwareName = softwareName;
    config.softwareVersion = softwareVersion;
    config.verbose = false;
    config.assetsDir = [self getAssetsDir];
    config.stateDir = [self getStateDir];
    config.tempDir = [self getTempDir];
    return config;
}

/**
 * getAssetsDir returns the assets directory for the current context. The
 * assets directory is the directory where the OONI Probe Engine should store
 * the assets it requires, e.g., the MaxMind DB files.
 */
+ (NSString*) getAssetsDir {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:
            [NSString stringWithFormat:@"assets"]];
}

/**
 * getStateDir returns the state directory for the current context. The
 * state directory is the directory where the OONI Probe Engine should store
 * internal state variables (e.g. the orchestra credentials).
 */
+ (NSString*) getStateDir {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:
            [NSString stringWithFormat:@"state"]];;
}

/**
 * getTempDir returns the temporary directory for the current context. The
 * temporary directory is the directory where the OONI Probe Engine should store
 * the temporary files that are managed by a Session.
 */
+ (NSString*) getTempDir {
    return NSTemporaryDirectory();
}

@end
