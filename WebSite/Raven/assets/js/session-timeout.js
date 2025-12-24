"use strict";
var KTSessionTimeoutDemo = function () {
    var initDemo = function () {
        $.sessionTimeout({
            title: getLang(7),
            message: getLang(8),
            keepAliveUrl: '/',
            redirUrl: '/raven/logout/',
            logoutUrl: '/raven/logout/',
            warnAfter: 590000, //warn after 590 seconds
            redirAfter: 600000, //redirect after 10 min
            ignoreUserActivity: false,
            countdownMessage: getLang(9),
            countdownBar: true,
            logoutButton: getLang(10),
            keepAliveButton: getLang(11)
        });
    }

    return {
        //main function to initiate the module
        init: function () {
            initDemo();
        }
    };
}();
jQuery(document).ready(function() {
    KTSessionTimeoutDemo.init();
});
