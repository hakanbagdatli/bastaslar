using System;

namespace Entities
{
    public class GeneralCategories : IEntity
    {
        public GeneralCategories() : base("GeneralCategories")
        {

        }

        public int id { get; set; }
        public int CatID { get; set; }
        public int _SubCategoryCount { get; set; }
        public int PageTypeID { get; set; }
        public int SubPageTypeID { get; set; }
        public string Title { get; set; }
        public string _Title { get; set; }
        public string AdditionalTitle { get; set; }
        public string _AdditionalTitle { get; set; }
        public string MetaTitle { get; set; }
        public string _MetaTitle { get; set; }
        public string MetaUrl { get; set; }
        public string _MetaUrl { get; set; }
        public string Description { get; set; }
        public string _Description { get; set; }
        public string Keywords { get; set; }
        public string _Keywords { get; set; }
        public string Image { get; set; }
        public string _Image { get; set; }
        public string Thumbnail { get; set; }
        public string _Thumbnail { get; set; }
        public string BannerImage { get; set; }
        public string _BannerImage { get; set; }
        public string ShortContent { get; set; }
        public string _ShortContent { get; set; }
        public string MainContent { get; set; }
        public string _MainContent { get; set; }
        public string Filename { get; set; }
        public string _Filename { get; set; }
        public string Link { get; set; }
        public string OpeningType { get; set; }
        public byte? isTopMenu { get; set; }
        public byte? isLeftMenu { get; set; }
        public byte? isBottomMenu { get; set; }
        public byte? isMainPageMenu { get; set; }
        public byte? isMegaMenu { get; set; }
        public int? TopMenuSequence { get; set; }
        public int? SubMenuSequence { get; set; }
        public int? LeftMenuSequence { get; set; }
        public int? BottomMenuSequence { get; set; }
        public int? NumberofListings { get; set; }
        public byte? MenuLinkStatu { get; set; }
        public byte? ContentStatu { get; set; }
        public byte? ShortContentStatu { get; set; }
        public byte? DontAppearSiteMap { get; set; }
        public int? SortingType { get; set; }
        public string _SortingType { get; set; }
        public byte? canAddSubCategory { get; set; }
        public byte? canAddContent { get; set; }
        public byte? canDelete { get; set; }
        public int? Sorting { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "GeneralCategories";
        public string _tableName = "GeneralCategories";

    }
}

