using System;
using Utility;
using Entities;
using System.IO;
using System.Web;
using System.Linq;
using PdfSharp.Pdf;
using Entities.Items;
using PdfSharp.Drawing;
using PdfSharp.Drawing.Layout;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace Tools
{
    public class Handler
    {
        #region General

        public static string Base64toImage(string base64, string SavingPath, string FileName)
        {
            base64 = base64.Replace("data:image/png;base64,", String.Empty);
            base64 = base64.Replace("data:image/jpeg;base64,", String.Empty);
            base64 = base64.Replace("data:image/jpg;base64,", String.Empty);
            byte[] bytes = Convert.FromBase64String(base64);
            System.Drawing.Image image;
            string FullPath = SavingPath + FileName;
            using (MemoryStream ms = new MemoryStream(bytes))
            {
                image = System.Drawing.Image.FromStream(ms);
                image.Save(FullPath, System.Drawing.Imaging.ImageFormat.Png);
                image.Dispose();
            }
            return FullPath;
        }
        //--------------------------------------------- base64toImage 

        public static bool HasSubMenu(int CategoryID)
        {
            List<Entities.GeneralCategories> dList = StaticList.Categories.Where(x => (x.isTopMenu == 1) && (x.Approved == 1) && (x.CatID == CategoryID)).ToList();
            if (dList.Count > 0) { return true; } else { return false; }
        }
        //---------------------------------------------

        public static string WithoutGlobalRequest()
        {
            string pageUrl = HttpContext.Current.Request.RawUrl;
            if (Feature.ActiveLanguage != StaticList.Settings.DefaultLanguage.ToString())
            {
                string LanguageCode = StaticList.LanguageCodes.Where(x => x.id == Convert.ToInt32(Feature.ActiveLanguage)).ToList()[0].Code;
                pageUrl = pageUrl.Replace(LanguageCode + "/", "");
            }
            pageUrl = pageUrl.Replace("/", "");
            pageUrl = Helper.Substring(pageUrl, "?");
            try
            {
                return pageUrl.Substring(0, pageUrl.IndexOf("/"));
            }
            catch { return pageUrl; }
        }
        //--------------------------------------------- GlobalRequestSiz

        public static string MakePagination(int PageCount, int ActivePageID, string PageURL)
        {
            #region url path
            string path = "?pi=";
            int piIndex = PageURL.IndexOf("pi");
            if (piIndex > 0)
                PageURL = PageURL.Substring(0, piIndex);
            if (PageURL.ToLower().Contains("?"))
            {
                if (PageURL.Substring(PageURL.Length - 1) == "?")
                    path = "pi=";
                else
                    path = "&pi=";
            }
            if (PageURL.Substring(PageURL.Length - 1) == "&")
                PageURL = Helper.DeleteLastChar(PageURL);

            PageURL += path;
            #endregion

            int NumberofPagesDisplayed = 4, StartingNumber = 0, EndNumber = 0;
            //---------------------------------------------------------
            StartingNumber = ActivePageID - NumberofPagesDisplayed;
            EndNumber = ActivePageID + NumberofPagesDisplayed;
            //---------------------------------------------------------
            if (StartingNumber < NumberofPagesDisplayed) { StartingNumber = 1; EndNumber = (NumberofPagesDisplayed * 2) + 1; }
            //---------------------------------------------------------
            if (EndNumber > PageCount) { EndNumber = PageCount; StartingNumber = EndNumber - (NumberofPagesDisplayed * 2); }
            //---------------------------------------------------------
            if (StartingNumber < 1) { StartingNumber = 1; }

            //---------------------------------------------------------
            System.Text.StringBuilder shtml = new System.Text.StringBuilder();

            if (PageCount > 1)
            {

                if (ActivePageID > 1)
                {
                    //shtml.Append("<a href='" + PageURL + "1'  title='İlk Sayfa' class='prev-page'><i class='fal fa-angle-double-left'></i></a>");
                    //---------------------------------------------------------
                    shtml.Append("<li><a href='" + PageURL + (ActivePageID - 1) + "'  title='Previous Page' class='previous page-numbers'><i class='fal fa-arrow-left'></i></a></li>");
                }
                //---------------------------------------------------------
                for (int i = StartingNumber; i < EndNumber + 1; i++)
                {
                    if (ActivePageID == i)
                        shtml.Append("<li><span aria-current='page' class='page-numbers current'>" + i.ToString() + "</span></li>");
                    //---------------------------------------------------------
                    else
                        shtml.Append("<li><a href='" + PageURL + i + "' title='" + i.ToString() + ". Page' class='page-numbers'>" + i.ToString() + "</a></li>");
                }
                //---------------------------------------------------------
                if (ActivePageID < PageCount)
                {
                    shtml.Append("<li><a href='" + PageURL + (ActivePageID + 1) + "'  title='Next Page' class='next page-numbers'><i class='fal fa-arrow-right'></i></a></li>");
                    //---------------------------------------------------------
                    //shtml.Append("<a href='" + PageURL + PageCount + "1'  title='Son Sayfa' class='next-page'><i class='fal fa-angle-double-left'></i></a>");
                }
            }
            return shtml.ToString();
        }
        //--------------------------------------------- 

        public static string SetMetaTags(string Title, string Description, string Keywords, Literal lblDescription, Literal lblKeywords, Literal lblOgTitle, Literal lblOgDescription)
        {
            string returningValue = null;
            //---------------------------------------------------------
            if (!String.IsNullOrEmpty(Title))
            {
                lblOgTitle.Text = "<meta property='og:title' content='" + Title + "'>";
                HttpContext.Current.Session["MetaOgTitle"] = "MetaOgTitle";
            }
            //---------------------------------------------------------
            if (!String.IsNullOrEmpty(Description))
            {
                lblDescription.Text = "<meta name='Description' content='" + Description + "'>";
                lblOgDescription.Text = "<meta property='og:description' content='" + Description + "'>";
                HttpContext.Current.Session["MetaDesc"] = "Description";
            }
            //---------------------------------------------------------
            //if (!String.IsNullOrEmpty(Keywords)) { lblKeywords.Text = "<meta name=\"keywords\" content=\"" + Keywords + "\">\n"; HttpContext.Current.Session["MetaKeyw"] = "Keywords"; }
            //---------------------------------------------------------
            return returningValue;
        }
        //--------------------------------------------- sayfanın Description ve Keywords değerlerini ayarla

        #endregion

        #region Set Language

        public static string GetLanguageFromCurrentUrl()
        {
            try
            {
                // HttpContext ile mevcut isteğin URL'sini al
                var request = HttpContext.Current.Request;
                string url = request.Url.AbsolutePath;

                if (url.Contains("AjaxRequest.asmx"))
                    return Feature.ActiveLanguage;
                else
                {
                    // URL'yi analiz edin
                    string[] segments = url.Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries);
                    if (segments.Length > 0)
                    {
                        var matchingLanguage = StaticList.LanguageCodes.FirstOrDefault(x => x.Code == segments[0]);
                        if (matchingLanguage != null)
                        {
                            return matchingLanguage.id.ToString();
                        }
                    }
                    // Dil kodu yoksa boş döner
                    return StaticList.Settings.DefaultLanguage.ToString();
                }
            }
            catch
            {
                return StaticList.Settings.DefaultLanguage.ToString();
            }
        }
        //---------------------------------------------

        public static string GetPartnerLang()
        {
            HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
            if (RavenCookies != null)
                return RavenCookies.Values["RavenLang"].ToString();
            else
                return "2";
        }
        //---------------------------------------------

        public static void SetLanguage()
        {
            try
            {
                string LanguageCode = GetLanguageFromCurrentUrl();
                if (LanguageCode != Feature.ActiveLanguage)
                {
                    int hasLang = StaticList.LanguageCodes.Where(x => x.id == Convert.ToInt32(LanguageCode)).Count();
                    if (hasLang > 0)
                    {
                        Feature.ActiveLanguage = StaticList.LanguageCodes.Where(x => x.id == Convert.ToInt32(LanguageCode)).ToList()[0].id.ToString();
                        StaticList.ActiveSite = StaticList.LanguageCodes.Where(x => x.id == Convert.ToInt32(Feature.ActiveLanguage)).ToList()[0];
                        StaticList.PageTypes = Bll.zPageTypes.Select(0, filter: "");
                        StaticList.Defines = Bll.zDefineDetails.Select(0, filter: " AND Approved=1", sorting: " Sorting ASC, id DESC");
                        StaticList.Categories = Bll.GeneralCategories.Select(0, filter: "", sorting: " Sorting ASC, id ASC");
                        StaticList.Records = Bll.GeneralRecords.Select(0, filter: "", sorting: " Sorting ASC, id ASC");
                    }
                    else
                    {
                        if (Feature.ActiveLanguage == null)
                            Feature.ActiveLanguage = StaticList.Settings.DefaultLanguage.ToString();
                    }
                }
            }
            catch
            {
                if (Feature.ActiveLanguage == null)
                    Feature.ActiveLanguage = StaticList.Settings.DefaultLanguage.ToString();
            }
        }
        //---------------------------------------------

        public static string SetPartnerText(string DefaultText, string LanguageText)
        {
            string PLanguage = "2";
            HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
            if (RavenCookies != null)
            {
                PLanguage = StaticList.LanguageCodes.
                    Where(x => x.id == Convert.ToInt32(RavenCookies.Values["RavenLang"])).
                    FirstOrDefault().Code.ToUpper();
            }

            if (StaticList.Settings.DefaultLanguage.ToString() == PLanguage)
                return DefaultText;
            else
            {
                if (!String.IsNullOrEmpty(LanguageText))
                    return LanguageText;
                else
                    return DefaultText;
            }
        }
        //---------------------------------------------

        public static string SetText(string DefaultText, string LanguageText)
        {
            if (StaticList.Settings.DefaultLanguage.ToString() == Feature.ActiveLanguage)
                return DefaultText;
            else
            {
                if (!String.IsNullOrEmpty(LanguageText))
                    return LanguageText;
                else
                    return DefaultText;
            }
        }
        //---------------------------------------------

        public static string SetImage(string DefaultText, string LanguageText)
        {
            if (!String.IsNullOrEmpty(LanguageText))
                return LanguageText;
            else
                return DefaultText;
        }
        //---------------------------------------------

        public static string SetMetaURL(int CatID, int id, bool isDetail)
        {
            if (StaticList.Settings.DefaultLanguage.ToString() == Feature.ActiveLanguage)
            {
                if (isDetail)
                    return Select.GlobalSiteDetailLink(CatID, id);
                else
                    return Select.GlobalSiteLink(CatID, id);
            }
            else
            {
                string LanguageCode = StaticList.LanguageCodes.Where(x => x.id == Convert.ToInt32(Feature.ActiveLanguage)).ToList()[0].Code;
                if (isDetail)
                {
                    string redirectURL = Select._GlobalSiteDetailLink(CatID, id);
                    if (redirectURL.Contains("https"))
                        return redirectURL;
                    else if (redirectURL.Contains("javascript"))
                        return redirectURL;
                    else
                        return "/" + LanguageCode + redirectURL;
                }
                else
                {
                    string redirectURL = Select._GlobalSiteLink(CatID, id);
                    if (redirectURL.Contains("https"))
                        return redirectURL;
                    else if (redirectURL.Contains("javascript"))
                        return redirectURL;
                    else
                        return "/" + LanguageCode + redirectURL;
                }
            }
        }
        //---------------------------------------------

        public static string GetLanguageMain()
        {
            try
            {
                if (Feature.ActiveLanguage == StaticList.Settings.DefaultLanguage.ToString())
                    return "/";
                else
                    return "/" + StaticList.LanguageCodes.Where(x => x.id == Convert.ToInt32(Feature.ActiveLanguage)).ToList()[0].Code.ToLower() + "/";
            }
            catch
            {
                return "/";
            }
        }
        //---------------------------------------------

        #endregion

        #region PDF Converter

        public static string ProjectPdf(PdfExport item)
        {
            PdfDocument document = new PdfDocument();
            ProjectPage1(document, item);
            ProjectPage2(document, item);
            ProjectPage3(document, item);
            ProjectPage4(document, item);
            string ExportName = Guid.NewGuid().ToString() + ".pdf";
            string ExportPath = HttpContext.Current.Server.MapPath(Feature.AgencyFolder) + ExportName;
            document.Save(ExportPath);
            return ExportName;
        }
        //---------------------------------------------

        static void ProjectPage1(PdfDocument document, PdfExport item)
        {
            try
            {
                XSize pageSize = new XSize(8.27 * 72, 11.69 * 72); // A4 boyut
                PdfPage page = document.AddPage();
                page.Width = pageSize.Width;
                page.Height = pageSize.Height;

                using (XGraphics gfx = XGraphics.FromPdfPage(page))
                {
                    double contentWidth = page.Width - 50; // 25 sağ - 25 sol boşluk
                    double defaultX = 25; //sol boşluk
                    double currentY = 15; //üst boşluk
                    double maxLogoHeight = 50.0;

                    #region Header

                    // Logo çizimi
                    DrawImage(item.AgencyLogo, page, gfx, xPosition: defaultX, yPosition: currentY, maxHeight: maxLogoHeight, 0.4);

                    // Yazı fontu
                    XFont font = new XFont("Poppins", 12, XFontStyle.Regular);
                    double textWidth = gfx.MeasureString(item.AgencyName, font).Width;

                    // Yazıyı sağ üste yerleştirirken logoyla hizalama
                    double textY = currentY + (maxLogoHeight / 2) - 15;
                    double textX = (page.Width - textWidth) - 30; // sağdan 20pt boşluk

                    currentY = DrawText(item.AgencyName, page, gfx, xPosition: textX, yPosition: textY, contentWidth, 0.4, 12);

                    currentY += 25; // bir sonraki içerik için boşluk
                    #endregion

                    string HtmlText = "<p><b>" + Language.GetPartner("ProjeAdi") + " : </b>" + item.ProjectName + "</p>";
                           HtmlText += "<p><b>" + Language.GetPartner("BaslangicTarih") + " : </b>" + item.StartDate + "</p>";
                           HtmlText += "<p><b>" + Language.GetPartner("BitisTarih") + " : </b>" + item.EndDate + "</p>";
                           HtmlText += "<p><b>" + Language.GetPartner("Aciklama") + " : </b>" + item.ShortContent + "</p>";
                           HtmlText += "<p><b>" + Language.GetPartner("OdemePlani") + " : </b></p>" + item.PaymentPlans;

                    currentY = DrawHtml(HtmlText, page, gfx, xPosition: defaultX, yPosition: currentY, contentWidth);
                    
                    #region Footer

                    // Yazı fontu
                    font = new XFont("Poppins", 10, XFontStyle.Regular);
                    textWidth = gfx.MeasureString("Telefon  : " + item.BrokerPhone, font).Width;

                    // Yazıyı sağ alta yerleştirirken hizalama
                    textY = page.Height - 15 - 13;
                    textX = (page.Width - textWidth) - 30; // sağdan 20pt boşluk

                    DrawText(Language.GetPartner("Iletisim") + " : " + item.BrokerName, page, gfx, xPosition: defaultX, yPosition: textY, contentWidth, 0.4, 10);
                    DrawText(Language.GetPartner("Telefon") + " : " + item.BrokerPhone, page, gfx, xPosition: textX, yPosition: textY, contentWidth, 0.4, 10);
                    #endregion

                }
            }
            catch
            {
                // Opsiyonel: loglama yapılabilir
            }
        }
        //---------------------------------------------

        static void ProjectPage2(PdfDocument document, PdfExport item)
        {
            try
            {
                XSize pageSize = new XSize(8.27 * 72, 11.69 * 72); // A4 boyut
                PdfPage page = document.AddPage();
                page.Width = pageSize.Width;
                page.Height = pageSize.Height;

                using (XGraphics gfx = XGraphics.FromPdfPage(page))
                {
                    double contentWidth = page.Width - 50; // 25 sağ - 25 sol boşluk
                    double defaultX = 25; //sol boşluk
                    double currentY = 15; //üst boşluk
                    double maxLogoHeight = 50.0;

                    #region Header

                    // Logo çizimi
                    DrawImage(item.AgencyLogo, page, gfx, xPosition: defaultX, yPosition: currentY, maxHeight: maxLogoHeight, 0.4);

                    // Yazı fontu
                    XFont font = new XFont("Poppins", 12, XFontStyle.Regular);
                    double textWidth = gfx.MeasureString(item.AgencyName, font).Width;

                    // Yazıyı sağ üste yerleştirirken logoyla hizalama
                    double textY = currentY + (maxLogoHeight / 2) - 15;
                    double textX = (page.Width - textWidth) - 30; // sağdan 20pt boşluk

                    currentY = DrawText(item.AgencyName, page, gfx, xPosition: textX, yPosition: textY, contentWidth, 0.4, 12);

                    currentY += 10; // bir sonraki içerik için boşluk
                    #endregion

                    #region Outdoor-Information

                    currentY = DrawHtml("<p><b>" + Language.GetPartner("DisMekan") +"</b></p>", page, gfx, xPosition: defaultX, yPosition: currentY, contentWidth);
                    currentY += 15;

                    DrawImage(item.OutdoorPhoto1, page, gfx, xPosition: defaultX, yPosition: currentY, maxHeight: 150);
                    currentY = DrawImage(item.OutdoorPhoto2, page, gfx, xPosition: (defaultX + 285), yPosition: currentY, maxHeight: 150);
                    currentY += 10;

                    DrawImage(item.OutdoorPhoto3, page, gfx, xPosition: defaultX, yPosition: currentY, maxHeight: 150);
                    currentY = DrawImage(item.OutdoorPhoto4, page, gfx, xPosition: (defaultX + 285), yPosition: currentY, maxHeight: 150);

                    #endregion

                    #region Indoor-Information
                    currentY = DrawHtml("<p><b>" + Language.GetPartner("IcMekan") +"</b></p>", page, gfx, xPosition: defaultX, yPosition: currentY, contentWidth);
                    currentY += 15;

                    DrawImage(item.IndoorPhoto1, page, gfx, xPosition: defaultX, yPosition: currentY, maxHeight: 150);
                    currentY = DrawImage(item.IndoorPhoto2, page, gfx, xPosition: (defaultX + 285), yPosition: currentY, maxHeight: 150);
                    currentY += 10;

                    DrawImage(item.IndoorPhoto3, page, gfx, xPosition: defaultX, yPosition: currentY, maxHeight: 150);
                    currentY = DrawImage(item.IndoorPhoto4, page, gfx, xPosition: (defaultX + 285), yPosition: currentY, maxHeight: 150);
                    currentY += 10;
                    #endregion

                    #region Footer

                    // Yazı fontu
                    font = new XFont("Poppins", 10, XFontStyle.Regular);
                    textWidth = gfx.MeasureString("Telefon  : " + item.BrokerPhone, font).Width;

                    // Yazıyı sağ alta yerleştirirken hizalama
                    textY = page.Height - 15 - 13;
                    textX = (page.Width - textWidth) - 30; // sağdan 20pt boşluk

                    DrawText(Language.GetPartner("Iletisim") + " : " + item.BrokerName, page, gfx, xPosition: defaultX, yPosition: textY, contentWidth, 0.4, 10);
                    DrawText(Language.GetPartner("Telefon") + " : " + item.BrokerPhone, page, gfx, xPosition: textX, yPosition: textY, contentWidth, 0.4, 10);
                    #endregion

                }
            }
            catch
            {
                // Opsiyonel: loglama yapılabilir
            }
        }
        //---------------------------------------------
        
        static void ProjectPage3(PdfDocument document, PdfExport item)
        {
            try
            {
                XSize pageSize = new XSize(8.27 * 72, 11.69 * 72); // A4 boyut
                PdfPage page = document.AddPage();
                page.Width = pageSize.Width;
                page.Height = pageSize.Height;

                using (XGraphics gfx = XGraphics.FromPdfPage(page))
                {
                    double contentWidth = page.Width - 50; // 25 sağ - 25 sol boşluk
                    double defaultX = 25; //sol boşluk
                    double currentY = 15; //üst boşluk
                    double maxLogoHeight = 50.0;

                    #region Header

                    // Logo çizimi
                    DrawImage(item.AgencyLogo, page, gfx, xPosition: defaultX, yPosition: currentY, maxHeight: maxLogoHeight, 0.4);

                    // Yazı fontu
                    XFont font = new XFont("Poppins", 12, XFontStyle.Regular);
                    double textWidth = gfx.MeasureString(item.AgencyName, font).Width;

                    // Yazıyı sağ üste yerleştirirken logoyla hizalama
                    double textY = currentY + (maxLogoHeight / 2) - 15;
                    double textX = (page.Width - textWidth) - 30; // sağdan 20pt boşluk

                    currentY = DrawText(item.AgencyName, page, gfx, xPosition: textX, yPosition: textY, contentWidth, 0.4, 12);

                    currentY += 10; // bir sonraki içerik için boşluk
                    #endregion

                    currentY = DrawHtml("<p><b>"+ Language.GetPartner("Properties") +"</b></p>", page, gfx, xPosition: defaultX, yPosition: currentY, contentWidth);
                    currentY += 10;

                    double imageMaxHeight = page.Height - currentY - 30; // Alt boşluk bırak
                    DrawImageFit(item.Properties, page, gfx, xPosition: defaultX, yPosition: currentY, maxWidth: contentWidth, maxHeight: imageMaxHeight);

                    #region Footer

                    // Yazı fontu
                    font = new XFont("Poppins", 10, XFontStyle.Regular);
                    textWidth = gfx.MeasureString("Telefon  : " + item.BrokerPhone, font).Width;

                    // Yazıyı sağ alta yerleştirirken hizalama
                    textY = page.Height - 15 - 13;
                    textX = (page.Width - textWidth) - 30; // sağdan 20pt boşluk

                    DrawText(Language.GetPartner("Iletisim") + " : " + item.BrokerName, page, gfx, xPosition: defaultX, yPosition: textY, contentWidth, 0.4, 10);
                    DrawText(Language.GetPartner("Telefon") + " : " + item.BrokerPhone, page, gfx, xPosition: textX, yPosition: textY, contentWidth, 0.4, 10);
                    #endregion
                }
            }
            catch
            {
                // Opsiyonel: loglama yapılabilir
            }
        }
        //---------------------------------------------

        static void ProjectPage4(PdfDocument document, PdfExport item)
        {
            try
            {
                XSize pageSize = new XSize(8.27 * 72, 11.69 * 72); // A4 boyut
                PdfPage page = document.AddPage();
                page.Width = pageSize.Width;
                page.Height = pageSize.Height;

                using (XGraphics gfx = XGraphics.FromPdfPage(page))
                {
                    double contentWidth = page.Width - 50; // 25 sağ - 25 sol boşluk
                    double defaultX = 25; //sol boşluk
                    double currentY = 15; //üst boşluk
                    double maxLogoHeight = 50.0;

                    #region Header

                    // Logo çizimi
                    DrawImage(item.AgencyLogo, page, gfx, xPosition: defaultX, yPosition: currentY, maxHeight: maxLogoHeight, 0.4);

                    // Yazı fontu
                    XFont font = new XFont("Poppins", 12, XFontStyle.Regular);
                    double textWidth = gfx.MeasureString(item.AgencyName, font).Width;

                    // Yazıyı sağ üste yerleştirirken logoyla hizalama
                    double textY = currentY + (maxLogoHeight / 2) - 15;
                    double textX = (page.Width - textWidth) - 30; // sağdan 20pt boşluk

                    currentY = DrawText(item.AgencyName, page, gfx, xPosition: textX, yPosition: textY, contentWidth, 0.4, 12);

                    currentY += 10; // bir sonraki içerik için boşluk
                    #endregion

                    currentY = DrawHtml("<p><b>" + Language.GetPartner("MulkMusaitlikleri") + "</b></p>", page, gfx, xPosition: defaultX, yPosition: currentY, contentWidth);
                    currentY += 10;

                    double imageMaxHeight = page.Height - currentY - 30; // Alt boşluk bırak
                    DrawImageFit(item.AvailabilityPhoto, page, gfx, xPosition: defaultX, yPosition: currentY, maxWidth: contentWidth, maxHeight: imageMaxHeight);

                    #region Footer

                    // Yazı fontu
                    font = new XFont("Poppins", 10, XFontStyle.Regular);
                    textWidth = gfx.MeasureString("Telefon  : " + item.BrokerPhone, font).Width;

                    // Yazıyı sağ alta yerleştirirken hizalama
                    textY = page.Height - 15 - 13;
                    textX = (page.Width - textWidth) - 30; // sağdan 20pt boşluk

                    DrawText(Language.GetPartner("Iletisim") + " : " + item.BrokerName, page, gfx, xPosition: defaultX, yPosition: textY, contentWidth, 0.4, 10);
                    DrawText(Language.GetPartner("Telefon") + " : " + item.BrokerPhone, page, gfx, xPosition: textX, yPosition: textY, contentWidth, 0.4, 10);
                    #endregion
                }
            }
            catch
            {
                // Opsiyonel: loglama yapılabilir
            }
        }
        //---------------------------------------------

        static double DrawText(string dataValue, PdfPage page, XGraphics gfx, double xPosition, double yPosition, double maxWidth, double opacity = 1.0, int fontSize = 13)
        {
            XFont font = new XFont("Poppins", fontSize, XFontStyle.Regular);
            XTextFormatter tf = new XTextFormatter(gfx);

            // Opaklık değeri 0.0 - 1.0 arası olmalı
            if (opacity < 0.0) opacity = 0.0;
            if (opacity > 1.0) opacity = 1.0;

            // Renk: Siyah ama opacity'e göre alfa değeri ayarlanmış
            int alpha = (int)(opacity * 255); // 255 = %100 opak
            XBrush brush = new XSolidBrush(XColor.FromArgb(alpha, 0, 0, 0)); // Siyah ton

            // Yazıyı belirli genişlikte ve sınırsız yükseklikte çizer
            XRect rect = new XRect(xPosition, yPosition, maxWidth, page.Height - yPosition);
            tf.Alignment = XParagraphAlignment.Left;
            tf.DrawString(dataValue, font, brush, rect, XStringFormats.TopLeft);

            // Satır yüksekliği
            double lineHeight = font.GetHeight();

            // Yaklaşık satır sayısını tahmin et
            double textWidth = gfx.MeasureString(dataValue, font).Width;
            int estimatedLineCount = (int)Math.Ceiling(textWidth / maxWidth);

            // Toplam yükseklik = satır sayısı x satır yüksekliği
            double estimatedHeight = estimatedLineCount * lineHeight;

            // Yeni Y pozisyonu (bir sonraki içerik için)
            return yPosition + estimatedHeight;
        }
        //---------------------------------------------

        static double DrawImage(string imageValue, PdfPage page, XGraphics gfx, double xPosition, double yPosition, double maxHeight, double opacity = 1.0)
        {
            if (opacity < 0.0) opacity = 0.0;
            if (opacity > 1.0) opacity = 1.0;

            XImage xImage = XImage.FromFile(HttpContext.Current.Server.MapPath(imageValue));

            // Oranlama faktörü (yükseklik odaklı)
            double scaleFactor = maxHeight / xImage.PixelHeight;

            // Gerçek boyutlar (inç olarak) x 72 dpi
            double scaledWidth = xImage.PixelWidth * scaleFactor;
            double scaledHeight = xImage.PixelHeight * scaleFactor;

            // Görseli çiz
            gfx.DrawImage(xImage, xPosition, yPosition, scaledWidth, scaledHeight);

            if (opacity < 1.0)
            {
                int alpha = (int)((1.0 - opacity) * 255); // ne kadar şeffaflık, o kadar beyazlık
                XBrush overlay = new XSolidBrush(XColor.FromArgb(alpha, 255, 255, 255)); // beyaz maske
                gfx.DrawRectangle(overlay, xPosition, yPosition, scaledWidth, scaledHeight);
            }

            // Görselin bittiği Y konumu (bir alt satır için kullanılabilir)
            return yPosition + scaledHeight;
        }
        //---------------------------------------------
        
        static double DrawImageFit(string imageValue, PdfPage page, XGraphics gfx, double xPosition, double yPosition, double maxWidth, double maxHeight, double opacity = 1.0)
        {
            if (opacity < 0.0) opacity = 0.0;
            if (opacity > 1.0) opacity = 1.0;

            XImage xImage = XImage.FromFile(HttpContext.Current.Server.MapPath(imageValue));

            // Genişlik ve yükseklik oranları
            double widthRatio = maxWidth / xImage.PixelWidth;
            double heightRatio = maxHeight / xImage.PixelHeight;

            // En küçük oranı kullan (taşmaması için)
            double scaleFactor = Math.Min(widthRatio, heightRatio);

            double scaledWidth = xImage.PixelWidth * scaleFactor;
            double scaledHeight = xImage.PixelHeight * scaleFactor;

            gfx.DrawImage(xImage, xPosition, yPosition, scaledWidth, scaledHeight);

            if (opacity < 1.0)
            {
                int alpha = (int)((1.0 - opacity) * 255);
                XBrush overlay = new XSolidBrush(XColor.FromArgb(alpha, 255, 255, 255));
                gfx.DrawRectangle(overlay, xPosition, yPosition, scaledWidth, scaledHeight);
            }

            return yPosition + scaledHeight;
        }
        //---------------------------------------------

        static double DrawHtml(string htmlContent, PdfPage page, XGraphics gfx, double xPosition, double yPosition, double maxWidth, double opacity = 1.0)
        {
            int alpha = (int)(Math.Max(0.0, Math.Min(1.0, opacity)) * 255);
            XBrush brush = new XSolidBrush(XColor.FromArgb(alpha, 0, 0, 0));

            htmlContent = Regex.Replace(htmlContent, @"\r\n?|\n", "");
            var blocks = Regex.Matches(htmlContent, @"<(p|ul|table)>(.*?)<\/\1>", RegexOptions.IgnoreCase);

            foreach (Match block in blocks)
            {
                string tag = block.Groups[1].Value.ToLower();
                string content = block.Groups[2].Value;

                if (tag == "p")
                {
                    List<(string Text, bool IsBold)> parts = new List<(string, bool)>();
                    string pattern = @"(<b>(.*?)<\/b>)|([^<]+)";
                    foreach (Match match in Regex.Matches(content, pattern, RegexOptions.IgnoreCase))
                    {
                        if (match.Groups[2].Success)
                            parts.Add((match.Groups[2].Value, true));
                        else if (match.Groups[3].Success)
                            parts.Add((match.Groups[3].Value, false));
                    }

                    double currentX = xPosition;
                    double lineHeight = new XFont("Poppins", 13, XFontStyle.Regular).GetHeight();
                    double maxRight = xPosition + maxWidth;

                    foreach (var part in parts)
                    {
                        XFont font = new XFont("Poppins", 13, part.IsBold ? XFontStyle.Bold : XFontStyle.Regular);
                        string[] words = part.Text.Split(new[] { ' ' }, StringSplitOptions.None);

                        foreach (string word in words)
                        {
                            string textToDraw = word + " ";
                            var size = gfx.MeasureString(textToDraw, font);

                            if (currentX + size.Width > maxRight)
                            {
                                yPosition += lineHeight;
                                currentX = xPosition;
                            }

                            gfx.DrawString(textToDraw, font, brush, new XPoint(currentX, yPosition + lineHeight), XStringFormats.TopLeft);
                            currentX += size.Width;
                        }
                    }

                    yPosition += lineHeight + 10;
                }
                else if (tag == "ul")
                {
                    var liMatches = Regex.Matches(content, @"<li>(.*?)<\/li>", RegexOptions.IgnoreCase);
                    foreach (Match li in liMatches)
                    {
                        string liText = "• " + Regex.Replace(li.Groups[1].Value, "<.*?>", string.Empty);
                        XFont font = new XFont("Poppins", 13, XFontStyle.Regular);
                        double lineHeight = font.GetHeight();
                        double currentX = xPosition;

                        string[] words = liText.Split(new[] { ' ' }, StringSplitOptions.None);
                        foreach (string word in words)
                        {
                            string wordWithSpace = word + " ";
                            var size = gfx.MeasureString(wordWithSpace, font);

                            if (currentX + size.Width > xPosition + maxWidth)
                            {
                                yPosition += lineHeight;
                                currentX = xPosition;
                            }

                            gfx.DrawString(wordWithSpace, font, brush, new XPoint(currentX, yPosition + lineHeight), XStringFormats.TopLeft);
                            currentX += size.Width;
                        }

                        yPosition += lineHeight + 5;
                    }
                }
            }

            return yPosition;
        }
        //---------------------------------------------

        #endregion

    }
}
