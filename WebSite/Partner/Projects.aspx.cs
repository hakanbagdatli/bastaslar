using System;
using System.Web;
using Tools;

namespace WebSite.Partner
{
    public partial class Projects : System.Web.UI.Page
    {
        public string PLanguage = "2";
        public Entities.zUsers UserData = new Entities.zUsers { id = 0, CatID = 0 };
        protected void Page_Load(object sender, EventArgs e)
        {
            //Developer.CheckLogin("Agency", 1);
            UserData = Developer.LoggedPartner(false);
            //---------------------------------------------------------
            HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
            if (RavenCookies != null)
                PLanguage = RavenCookies.Values["RavenLang"];
        }
        //---------------------------------------------------------

        public int CalculateProgressPercentage(string StartDate, string EndDate)
        {
            try
            {
                DateTime start = Convert.ToDateTime(StartDate);
                DateTime end = Convert.ToDateTime(EndDate);

                // Bugünün tarihi
                DateTime today = DateTime.Today;

                // Toplam gün sayısı (en az 1 olacak şekilde)
                double totalDays = (end - start).TotalDays;
                if (totalDays <= 0)
                    return 100; // Başlangıç ve bitiş aynı ya da yanlış girilmişse %100 olarak kabul edelim

                // Geçen gün sayısı
                double elapsedDays = (today - start).TotalDays;

                // Geçen gün 0'dan küçükse (yani henüz başlamamışsa) 0 olarak ayarla
                if (elapsedDays < 0)
                    elapsedDays = 0;

                // Yüzdelik hesaplama
                double percentage = (elapsedDays / totalDays) * 100;

                // 0-100 arasında sınırla ve tam sayı olarak döndür
                int rounded = (int)Math.Round(percentage);
                if (rounded < 0) return 0;
                if (rounded > 100) return 100;

                return rounded;
            }
            catch 
            {
                return 0;
            }
        }
        //---------------------------------------------------------

    }
}