/* for facebook init */
window.fbAsyncInit = function () {
    FB.init({
        appId: '482324189905262',
        cookie: true,
        xfbml: true,
        version: 'v12.0'
    });
    FB.AppEvents.logPageView();
};
(function (d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) { return; }
    js = d.createElement(s); js.id = id;
    js.src = "https://connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
$(".btn-facebook-login").on("click", function () {
    FB.login(function (response) {
        if (response.status == "connected") {
            FB.api('/me', { fields: 'first_name,last_name,email' }, function (result) {
                let params = [{
                    Name: result.first_name,
                    Surname: result.last_name,
                    Email: result.email,
                    NetworkName: "facebook",
                    NetworkUserID: response.authResponse.userID
                }];
                Connect(params);
            });
        }
    }, { scope: 'public_profile,email' });
});

/* for google init */
var googleUser = {};
var startApp = function () {
    gapi.load('auth2', function () {
        // Retrieve the singleton for the GoogleAuth library and set up the client.
        auth2 = gapi.auth2.init({
            client_id: '899594866572-ng1aubojopmpor1ihifl88nv9q1hnotg.apps.googleusercontent.com',
            cookiepolicy: 'single_host_origin'
        });
        attachGoogle(document.getElementById('gSignIn'));
    });
};
function attachGoogle(element) {
    auth2.attachClickHandler(element, {},
        function (googleUser) {
            var profile = googleUser.getBasicProfile();
            let params = [{
                Name: profile.getGivenName(),
                Surname: profile.getFamilyName(),
                Email: profile.getEmail(),
                NetworkName: "google",
                NetworkUserID: profile.getId()
            }];
            Connect(params);
        }
    );
}
startApp();

/* login via social media */
function Connect(params) {
    if (params != "" && params != null) {
        let paramaters = JSON.stringify({ value: params });
        let data = postAjax("LoginwithSocial", paramaters);
        let dataItem = JSON.parse(data.d);
        //------------------------------------------
        if (dataItem.result == true) {
            let UserToken = dataItem.items.UserToken;
            setCookie("CarrenttaID", UserToken, true)
            alertWithRedirect("", getLang(10), "success", window.location.href);
        }
        else
            alert(getLang(3), dataItem.message, "error");
    }
}