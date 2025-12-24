using Tools;
using System.Web;
using System.Linq;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace WebAPI.Handlers
{
    public class APIKeyMessageHandler : DelegatingHandler
    {
        private const string APIKeyToCheck = "80ae79b4-84e1-47f6-aa75-4242f2414f89";

        protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage httpRequestMessage, CancellationToken cancellationToken)
        {
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            bool validKey = false;
            IEnumerable<string> requestHeaders;
            var checkApiExists = httpRequestMessage.Headers.TryGetValues("apiKey", out requestHeaders);
            if (checkApiExists)
            {
                if (requestHeaders.FirstOrDefault().Equals(APIKeyToCheck))
                {
                    validKey = true;
                }
            }
            else if (path.Contains("swagger"))
            {
                validKey = true;
            }
            if (!validKey)
            {
                return httpRequestMessage.CreateResponse(Servant.ResultMessage("", 0, 0, 0, false, "Invalid API Key"));
                //HttpStatusCode.Forbidden, "{errorCode: 403, errorMessage: 'Invalid API Key'}", JsonMediaTypeFormatter.DefaultMediaType);
            }
            var response = await base.SendAsync(httpRequestMessage, cancellationToken);
            return response;
        }

    }
}