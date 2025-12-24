using Owin;
using System;
using System.Web.Mvc;
using Microsoft.Owin;
using System.Web.Http;
using System.Web.Routing;
using WebAPI.OAuth.Providers;
using Microsoft.Owin.Security.OAuth;

[assembly: OwinStartup(typeof(WebAPI.OAuth.Startup))]

namespace WebAPI.OAuth
{
    public class Startup
    {
        public void Configuration(IAppBuilder appBuilder)
        {
            HttpConfiguration httpConfiguration = new HttpConfiguration();
            ConfigureOAuth(appBuilder);
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            appBuilder.Use(httpConfiguration);
        }

        private void ConfigureOAuth(IAppBuilder appBuilder)
        {
            OAuthAuthorizationServerOptions oAuthAuthorizationServerOptions = new OAuthAuthorizationServerOptions()
            {
                /*
                 
                Headers’e eklenecek parametreler:
                Header: Accept                Value: application/json
                Header: Content-Type     Value: application/x-www-form-urlencoded

                Body’e eklenecek parametreler:
                data tipi x-www-form-urlencoded olarak seçilip,
                Key: grant_type                 Value: password
                Key: username                   Value: (Kullanıcı adınız)
                Key: password                   Value: (Şifreniz)

                */

                TokenEndpointPath = new Microsoft.Owin.PathString("/Login"),
                AccessTokenExpireTimeSpan = TimeSpan.FromMinutes(5),
                AllowInsecureHttp = true,
                Provider = new SimpleAuthorizationServerProvider()
            };

            appBuilder.UseOAuthAuthorizationServer(oAuthAuthorizationServerOptions);
            appBuilder.UseOAuthBearerAuthentication(new OAuthBearerAuthenticationOptions());
        }
    }
}