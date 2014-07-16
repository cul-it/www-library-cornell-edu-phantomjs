#!/usr/bin/env phantomjs
var page = require('webpage').create();
var args = require('system').args;
if (args.length === 1) {
    console.log('Please specify the URL to an SSL page.');
    phantom.exit(1);
}
page.onResourceReceived = function (response) {
    if (response.stage == "start") {
        if (response.url.substr(0, 8) !== "https://" && response.url.substr(0, 5) !== "data:") {
            console.log("ALERT: The secure page " + args[1] + " loaded an insecure asset " + response.url + " which may trigger warnings and hurt customer perception.");
            phantom.exit(1);
        }
    }
};
page.open(args[1], function(status) {
    if (status === "success") {
        console.log("All good!");
        phantom.exit(0);
    }
    else {
        console.log("Could not open " + args[1]);
        phantom.exit(1);
    }
});
