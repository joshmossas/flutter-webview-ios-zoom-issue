# Flutter IOS WebView Zoom Issue Reproduction

Basically IOS ignores when a webview has zoomEnabled set to false. This is even when javascriptMode is set to unrestricted when specified by the docs.

This reproduction has a regular webview with the default setup, and then another webview with a fix that runs some Javascript found in `assets/ios_zoom_fix.js` to fix the IOS issue.
