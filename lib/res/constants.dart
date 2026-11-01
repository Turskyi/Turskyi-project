const String kAppName = 'Turskyi';
const String kDeveloperDomain = 'turskyi.com';
const String kResendEmailDomain = kDeveloperDomain;
const String kSupportEmail = 'support@$kDeveloperDomain';
const String kImagePath = 'assets/images/';
const String kFeatureGraphicPath = '${kImagePath}feature_graphics/';
const String kGooglePlayBaseUrl =
    'https://play.google.com/store/apps/details?id=';
const String kDoNotReplySenderName = 'Do Not Reply';
const String kFeedbackEmailSender =
    '$kDoNotReplySenderName $kAppName <no-reply@$kResendEmailDomain>';

// https://dash.cloudflare.com/1918e9a6ac2794ef899bc1056f0cde51/workers/services/view/turskyi-support-api/production
const String kSupportWorkerBaseUrl =
    'https://turskyi-support-api.dmytro-turskyi.workers.dev';
