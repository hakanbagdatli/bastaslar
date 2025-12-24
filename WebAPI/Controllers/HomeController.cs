using System.Web.Mvc;

namespace WebAPI.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            Response.Write("v1.0");
            Response.End();
            return View();
        }
    }
}
