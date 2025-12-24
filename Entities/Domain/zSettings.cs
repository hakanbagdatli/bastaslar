using System;

namespace Entities
{
    public class zSettings : IEntity
    {
        public zSettings() : base("zSettings")
        {

        }

        public int id { get; set; }
        public string CompanyName { get; set; }
        public string SiteTitle { get; set; }
        public string SiteLink { get; set; }
        public string MetaTitle { get; set; }
        public string MetaKeywords { get; set; }
        public string MetaDescription { get; set; }
        public string SiteLogo { get; set; }
        public string DarkLogo { get; set; }
        public string MobileLogo { get; set; }
        public string FooterLogo { get; set; }
        public string Favicon { get; set; }
        public string Trailer { get; set; }
        public string Promotion { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string ErrorMailAdress { get; set; }
        public string EmailUsername { get; set; }
        public string EmailPassword { get; set; }
        public string EmailSmtpHost { get; set; }
        public int? EmailSmtpPort { get; set; }
        public string EmailSenderName { get; set; }
        public string EmailSign { get; set; }
        public string Whatsapp { get; set; }
        public string BookNowLink { get; set; }
        public string FacebookAddress { get; set; }
        public string InstagramAddress { get; set; }
        public string LinkedinAddress { get; set; }
        public string TwiterAddress { get; set; }
        public string YouTubeAddress { get; set; }
        public string TiktokAddress { get; set; }
        public string PinterestAddress { get; set; }
        public string FriendFeedAddress { get; set; }
        public string VimeoAdrdess { get; set; }
        public string SkypeAddress { get; set; }
        public string GeoTags { get; set; }
        public string LiveSupportCode { get; set; }
        public string YandexAnalyticsCode { get; set; }
        public string GoogleAnalyticsCode { get; set; }
        public string YandexVerificationCode { get; set; }
        public string GoogleVerificationCode { get; set; }
        public string AdditionalMetaTags { get; set; }
        public int NumberofListings { get; set; }
        public int UrlLinkType { get; set; }
        public bool isURLWithoutHTML { get; set; }
        public int? DefaultLanguage { get; set; }
        public bool isMultipleLangauge { get; set; }
        public bool isRssActive { get; set; }
        public bool isSiteMapActive { get; set; }
        public bool canLoggin { get; set; }
        public bool canCrop { get; set; }
        public bool canCache { get; set; }
        public bool canRightClick { get; set; }
        public bool can301Redirect { get; set; }
        public bool canAddMultipleFile { get; set; }
        public bool canAddMultipleImage { get; set; }
        public bool canDeleteMultiple { get; set; }
        public bool canDeletePictures { get; set; }
        public bool canDeleteRelatedRecord { get; set; }
        public bool hasPopup { get; set; }
        public string PopupImage { get; set; }
        public string PopupUrl { get; set; }
        public string PopupUrlTarget { get; set; }
        public bool SaveOriginalName { get; set; }
        public bool hasWatermak { get; set; }
        public string WatermakImage { get; set; }
        public int WatermakLeftPosition { get; set; }
        public int WatermakTopPosition { get; set; }
        public int WatermakImageWidth { get; set; }
        public int WatermakImageHeight { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "zSettings";
        public string _tableName = "zSettings";

    }
}

