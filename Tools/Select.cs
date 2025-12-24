using System;
using Entities;
using System.Linq;
using System.Collections.Generic;

namespace Tools
{
    public class Select
    {

        #region Kısayol İşlemleri

        public static Entities.GeneralCategories GetCategory(int id)
        {
            if (id > 0)
                return StaticList.Categories.Where(x => (x.id == id)).FirstOrDefault();
            else
                return StaticList.Categories.FirstOrDefault();
        }
        //---------------------------------------------------------

        public static string MenuSortingType(int sortingTypeId)
        {
            string returningValue = "Sorting ASC, id DESC";
            List<Entities.zSortingType> dataList = Bll.zSortingType.Select(sortingTypeId, filter: "");
            if (dataList.Count > 0)
                returningValue = dataList[0].Sorting;
            return returningValue;
        }
        //--------------------------------------------------------- id bilgisi gönderilen sıralama türünü getir

        public static string SortingType(int id)
        {
            string returningValue = "Sorting ASC, id DESC";
            List<Entities.GeneralCategories> dList = StaticList.Categories.Where(x => (x.id == id)).ToList();
            if (dList.Count > 0)
            {
                foreach (var item in dList)
                {
                    List<Entities.zSortingType> dataList = Bll.zSortingType.Select(Convert.ToInt32(item.SortingType), filter: "");
                    foreach (var items in dataList)
                    {
                        returningValue = items.Sorting;
                    }
                }
            }
            return returningValue;
        }
        //--------------------------------------------------------- ilgili kategori için kayıtların sıralaması

        public static int NumberofListings(int id)
        {
            int returningValue = Convert.ToInt32(Entities.StaticList.Settings.NumberofListings);
            List<Entities.GeneralCategories> dList = StaticList.Categories.Where(x => (x.id == id) && (x.NumberofListings > 0)).ToList();
            if (dList.Count > 0)
            {
                foreach (var item in dList)
                {
                    returningValue = Convert.ToInt32(item.NumberofListings);
                    List<Entities.zPageTypes> dataList = StaticList.PageTypes.Where(x => (x.id == item.PageTypeID) && (x.NumberofListings > 0)).ToList();
                    if (dataList.Count > 0)
                    {
                        foreach (var items in dataList)
                        {
                            returningValue = Convert.ToInt32(items.NumberofListings);
                        }
                    }
                }
            }
            return returningValue;
        }
        //--------------------------------------------------------- ilgili kategori için listelenecek kayıt sayısı

        public static bool isMenuSingleDetail(int id)
        {
            bool returningValue = false;
            List<Entities.GeneralCategories> dList = StaticList.Categories.Where(x => (x.id == id)).ToList();
            if (dList.Count > 0)
            {
                foreach (var item in dList)
                {
                    List<Entities.zPageTypes> dataList = StaticList.PageTypes.Where(x => (x.id == item.PageTypeID)).ToList();
                    foreach (var items in dataList)
                    {
                        returningValue = Convert.ToBoolean(items.isDetailSingle);
                    }
                    //if (item.CatID != 0)
                    //returningValue = isMenuSingleDetail(item.CatID);
                }
            }
            return returningValue;
        }
        //--------------------------------------------------------- ilgili kategori için kayıt sayısı > 1 mi?

        public static string MultipleCategoryName(int id)
        {
            string returningValue = "";
            List<Entities.GeneralCategories> dList = StaticList.Categories.Where(x => (x.id == id)).ToList();
            foreach (var item in dList)
            {
                returningValue = item.Title + " / ";
                if (item.CatID != 0)
                {
                    returningValue = MultipleCategoryName(item.CatID) + returningValue;
                }
            }
            return returningValue;
        }
        //--------------------------------------------------------- ilgili kategori ve bağlı olduğu tüm kategorilerin isim'lerini getir

        public static string MultipleCategoryID(int id)
        {
            string returning = id.ToString();
            List<Entities.GeneralCategories> dList = StaticList.Categories.Where(x => (x.CatID == id)).ToList();
            foreach (var item in dList)
            {
                returning += "," + MultipleCategoryID(item.id);
            }
            return returning;
        }
        //--------------------------------------------------------- ilgili kategori ve bağlı olduğu tüm kategorilerin id'lerini getir

        public static string MultipleCategoryCatID(int id)
        {
            string returningValue = id.ToString();
            List<Entities.GeneralCategories> dList = StaticList.Categories.Where(x => (x.id == id)).ToList();
            foreach (var item in dList)
            {
                if (item.CatID > 0)
                    returningValue += "," + MultipleCategoryCatID(item.CatID);
            }
            return returningValue;
        }
        //--------------------------------------------------------- ilgili kategori ve bağlı olduğu tüm kategorilerin CatID'lerini getir

        public static string MultipleTopCategoryID(int id)
        {
            string returningValue = "";
            List<Entities.GeneralCategories> dList = StaticList.Categories.Where(x => (x.id == id)).ToList();
            foreach (var item in dList)
            {
                returningValue = item.id.ToString();
                if (item.CatID != 0)
                    returningValue = MultipleTopCategoryID(item.CatID);
            }
            return returningValue;
        }
        //--------------------------------------------------------- ilgili kategori için en üst kategori id bilgisini getirir

        #endregion

        #region Kategori ve Kayıt İşlemleri

        public static string GetCategoryURL(int id)
        {
            // İlk ve tek kaydı alır
            var category = GetCategory(id);

            // Eğer kategori bulunamadıysa null döner, aksi takdirde MetaUrl döner
            return category?.MetaUrl ?? string.Empty;
        }
        //--------------------------------------------------------- belirli bir kategori ID'sine göre MetaUrl değerini döndürüyor.

        public static string CategoryURL(int id)
        {
            var category = GetCategory(id);

            // Eğer kategori bulunamadıysa boş döner
            if (category == null)
                return string.Empty;

            // Üst kategori URL'sini al
            string parentUrl = category.CatID != 0 ? CategoryURL(category.CatID) : string.Empty;

            // Kendi URL'sini ekle
            return $"{parentUrl}/{category.MetaUrl}";
        }
        //--------------------------------------------------------- kategori URL'lerini oluştururken kategori hiyerarşisini dikkate alarak bir URL dizisi oluşturur

        public static string TopCategoryURL(int id)
        {
            var category = GetCategory(id);

            // Eğer kategori bulunamadıysa boş döner
            if (category == null)
                return string.Empty;

            // Üst kategori URL'sini al
            string parentUrl = category.CatID != 0 ? TopCategoryURL(category.CatID) : string.Empty;

            // Kendi URL'sini ekle
            return $"{parentUrl}/{category.MetaUrl}";
        }
        //--------------------------------------------------------- verilen bir kategori ID'si için en üst kategoriye kadar gidip URL'yi oluşturmak.

        public static string FirstRecordURL(int id)
        {

            var _idList = MultipleCategoryID(id).Split(',').Select(int.Parse).ToList();
            var record = StaticList.Records.Where(x => _idList.Contains(x.CatID) && (x.Approved == 1)).Take(1).FirstOrDefault();

            // Eğer kayıt bulunamadıysa boş döner
            if (record == null)
                return null;

            // Detaylı bağlantıyı döner
            return GlobalSiteDetailLink(record.CatID, record.id);
        }
        //--------------------------------------------------------- ilgili kategoriye ait ilk kayıtı url bilgisini getir

        public static string FirstCategoryURL(int CatID)
        {
            var category = StaticList.Categories.Where(x => (x.CatID == CatID) && (x.Approved == 1)).Take(1).FirstOrDefault();
            if (category == null)
                return null;

            // Global site bağlantısını döner
            return GlobalSiteLink(category.PageTypeID, category.id);
        }
        //--------------------------------------------------------- ilgili kategoriye bağlı ilk alt kategorinin url bilgisini getir

        public static string GlobalConstantLink(int id)
        {
            var category = GetCategory(id);

            // Eğer kategori bulunamazsa boş döner
            if (category == null)
                return string.Empty;

            // Global site bağlantısını döner
            return GlobalSiteLink(category.PageTypeID, category.id);
        }
        //--------------------------------------------------------- id si verilen kategorinin url bilgisini getir

        public static string GlobalURL(int id, int catID, string catURL, int pageTypeID, string pageTypeConstantURL, bool isDetailSingle, bool isCatDirectList, bool isPageDirectList)
        {
            string returningValue = null;

            #region Root Category (catID == 0)
            if (Convert.ToInt32(catID) == 0)
            {
                if (pageTypeConstantURL.IndexOf("javascript:;") == 0)
                    returningValue = "javascript:;";
                else if (pageTypeConstantURL.IndexOf("#") == 0 || catURL.IndexOf("javascript:;") == 0)
                    returningValue = catURL;
                else
                {
                    if (!isPageDirectList)
                    {
                        if (!isCatDirectList)
                        {
                            List<Entities.GeneralRecords> dListRecords = StaticList.Records.Where(x => (x.CatID == id) && (x.Approved == 1)).ToList();
                            if (dListRecords.Count == 1)
                            {
                                foreach (var item in dListRecords)
                                {
                                    returningValue = isDetailSingle ? "/" + item.MetaUrl : "/" + item.MetaUrl + "/";
                                }
                            }
                            else
                                returningValue = "/" + catURL + "/";
                        }
                        else
                            returningValue = "/" + catURL + "/";
                    }
                    else
                        returningValue = "/" + catURL + "/";
                }
            }
            #endregion

            #region Non-Root Category (catID != 0)
            else
            {

                var _idList = MultipleCategoryID(id).Split(',').Select(int.Parse).ToList();
                List<Entities.GeneralRecords> dList = StaticList.Records.Where(x => _idList.Contains(x.CatID) && (x.Approved == 1)).ToList();
                if (dList.Count == 1 && !isPageDirectList)
                {
                    foreach (var item in dList)
                    {
                        #region  !isCatDirectList
                        if (!isCatDirectList)
                        {
                            if (String.IsNullOrEmpty(item.Link))
                            {
                                if (isDetailSingle || isMenuSingleDetail(item.CatID))
                                    returningValue = "/" + item.MetaUrl;
                                else
                                {
                                    switch (Entities.StaticList.Settings.UrlLinkType)
                                    {
                                        case 0:
                                            returningValue = "/" + TopCategoryURL(id) + "/" + item.MetaUrl;
                                            break;
                                        case 1:
                                            returningValue = catURL == item.MetaUrl
                                                ? "/" + GetCategoryURL(catID) + "/" + item.MetaUrl
                                                : "/" + GetCategoryURL(id) + "/" + item.MetaUrl;
                                            break;
                                        case 2:
                                            returningValue = "/" + CategoryURL(id) + "/" + item.MetaUrl;
                                            break;
                                        case 3:
                                            returningValue = catURL == item.MetaUrl
                                                ? "/" + GetCategoryURL(catID) + "/" + item.MetaUrl
                                                : "/" + GetCategoryURL(id) + "/" + item.MetaUrl;
                                            break;
                                        default:
                                            returningValue = "/" + item.MetaUrl; // Or some default value
                                            break;
                                    }
                                }
                            }
                            else
                                returningValue = item.Link;
                        }
                        #endregion

                        #region yes it is
                        else
                        {
                            switch (Entities.StaticList.Settings.UrlLinkType)
                            {
                                case 0:
                                    returningValue = "/" + TopCategoryURL(id) + "/" + catURL + "/";
                                    break;
                                case 1:
                                    returningValue = "/" + GetCategoryURL(catID) + "/" + catURL + "/";
                                    break;
                                case 2:
                                    returningValue = "/" + CategoryURL(catID) + "/" + catURL + "/";
                                    break;
                                case 3:
                                    returningValue = "/" + catURL + "/";
                                    break;
                                default:
                                    returningValue = "/" + catURL + "/"; // Or some default value
                                    break;
                            }
                        }
                        #endregion
                    }
                }
                else
                {
                    int mainPageTypeID = GetCategory(catID).PageTypeID;

                    #region is it same with mainpage type
                    if (mainPageTypeID == pageTypeID)
                    {
                        if (pageTypeConstantURL.IndexOf("#") == 0 || catURL.IndexOf("javascript:;") == 0)
                            returningValue = catURL;
                        else
                        {
                            switch (Entities.StaticList.Settings.UrlLinkType)
                            {
                                case 0:
                                    returningValue = "/" + TopCategoryURL(id) + "/" + catURL + "/";
                                    break;
                                case 1:
                                    returningValue = "/" + GetCategoryURL(catID) + "/" + catURL + "/";
                                    break;
                                case 2:
                                    returningValue = "/" + CategoryURL(catID) + "/" + catURL + "/";
                                    break;
                                case 3:
                                    returningValue = "/" + catURL + "/";
                                    break;
                                default:
                                    returningValue = "/" + catURL + "/"; // Or some default value
                                    break;
                            }
                        }
                    }
                    #endregion

                    #region not it's not
                    else
                    {
                        int subPageTypeID = GetCategory(catID).SubPageTypeID;
                        if (subPageTypeID == pageTypeID)
                        {
                            if (pageTypeConstantURL.IndexOf("#") == 0 || catURL.IndexOf("javascript:;") == 0)
                                returningValue = catURL;
                            else
                            {
                                switch (Entities.StaticList.Settings.UrlLinkType)
                                {
                                    case 0:
                                        returningValue = "/" + TopCategoryURL(id) + "/" + catURL + "/";
                                        break;
                                    case 1:
                                        returningValue = mainPageTypeID > 5
                                            ? "/" + GetCategoryURL(catID) + "/" + catURL + "/"
                                            : "/" + catURL + "/";
                                        break;
                                    case 2:
                                        returningValue = "/" + CategoryURL(catID) + "/" + catURL + "/";
                                        break;
                                    case 3:
                                        returningValue = "/" + catURL + "/";
                                        break;
                                    default:
                                        returningValue = "/" + catURL + "/"; // Or some default value
                                        break;
                                }
                            }
                        }
                        else
                        {
                            string mainSiteKategoriUrl = StaticList.PageTypes.Where(x => x.id == mainPageTypeID).FirstOrDefault().ConstantURL;
                            if (pageTypeConstantURL.IndexOf("#") == 0 || catURL.IndexOf("javascript:;") == 0)
                                returningValue = "/" + catURL + "/";
                            else if (mainSiteKategoriUrl.IndexOf("#") == 0 || mainSiteKategoriUrl.IndexOf("javascript:;") == 0)
                                returningValue = "/" + catURL + "/";
                            else
                                returningValue = "/" + catURL + "/";

                        }
                    }
                    #endregion
                }
            }
            #endregion

            return returningValue;
        }
        //--------------------------------------------------------- GlobalUrlBelirtSec

        public static string GlobalSiteLink(int PageTypeID, int id)
        {
            string returningValue = null;
            List<Entities.zPageTypes> dList = StaticList.PageTypes.Where(x => (x.id == PageTypeID)).ToList();
            foreach (var item in dList)
            {
                List<Entities.GeneralCategories> dataList = StaticList.Categories.Where(x => (x.id == id)).ToList();
                if (dataList.Count > 0)
                {
                    foreach (var items in dataList)
                    {
                        if (Convert.ToBoolean(item.DontAppearSiteMap))
                            returningValue = "javascript:;";
                        else if (String.IsNullOrEmpty(items.Link))
                        {
                            if (PageTypeID != 1)
                            {
                                if (Convert.ToBoolean(item.isLinkFreeRecord))
                                    returningValue = FirstRecordURL(items.id);
                                else if (Convert.ToBoolean(item.isLinkFreeCategory))
                                    returningValue = FirstCategoryURL(items.id);
                                else
                                    returningValue = GlobalURL(items.id, Convert.ToInt32(items.CatID), items.MetaUrl, Convert.ToInt32(items.PageTypeID), item.ConstantURL, Convert.ToBoolean(item.isDetailSingle), Convert.ToBoolean(item.isDirectList), Convert.ToBoolean(item.isDirectList));
                                if (!String.IsNullOrEmpty(returningValue))
                                    returningValue = returningValue.Replace("//", "/");
                            }
                            else
                                returningValue = "/";
                        }
                        else
                        {
                            returningValue = items.Link;
                        }
                    }
                }
            }
            return returningValue;
        }
        //--------------------------------------------------------- GlobalSiteLinkSec

        public static string GlobalSiteDetailLink(int CatID, int id)
        {
            string returningValue = "";
            List<Entities.GeneralRecords> dList = StaticList.Records.Where(x => (x.id == id) && (x.CatID == CatID) && (x.Approved == 1)).ToList(); ;
            //---------------------------------------------------------
            if (dList.Count > 0)
            {
                foreach (var item in dList)
                {
                    List<Entities.zPageTypes> pageTypesList = StaticList.PageTypes.Where(x => x.id == Convert.ToInt32(item._PageTypeID)).ToList();
                    if (Convert.ToBoolean(pageTypesList[0].DontAppearSiteMap) == false)
                    {
                        if (String.IsNullOrEmpty(item.Link))
                        {
                            if (isMenuSingleDetail(Convert.ToInt32(CatID)))
                                returningValue = $"/{item.MetaUrl}";
                            else if (Convert.ToBoolean(pageTypesList[0].isLinkFreeRecord))
                                returningValue = $"/{item.MetaUrl}";
                            else
                            {
                                switch (Entities.StaticList.Settings.UrlLinkType)
                                {
                                    case 0:
                                        returningValue = $"/{TopCategoryURL(CatID)}/{item.MetaUrl}";
                                        break;
                                    case 1:
                                        returningValue = $"/{GetCategoryURL(item.CatID)}/{item.MetaUrl}";
                                        break;
                                    case 2:
                                        returningValue = $"/{CategoryURL(Convert.ToInt32(CatID))}/{item.MetaUrl}";
                                        break;
                                    case 3:
                                        returningValue = $"/{GetCategoryURL(item.CatID)}/{item.MetaUrl}";
                                        break;
                                    default:
                                        // Optional: Handle unexpected UrlLinkType values
                                        returningValue = ""; // or some default value
                                        break;
                                }
                            }
                        }
                        else
                        {
                            returningValue = item.Link;
                        }
                        returningValue = returningValue.Replace("//", "/");
                    }
                    else
                        returningValue = GlobalSiteLink(Convert.ToInt32(item._PageTypeID), CatID);
                }
            }
            return returningValue;
        }
        //--------------------------------------------------------- GlobalSiteDetayLinkSec

        #endregion

        #region Diller için Kategori ve Kayıt İşlemleri

        public static string _GetCategoryURL(int id, string Language = "")
        {
            // İlk ve tek kaydı alır
            var category = Bll.GeneralCategories.Select(id, filter: "", lang: Language).FirstOrDefault();

            // Eğer kategori bulunamadıysa null döner, aksi takdirde _MetaUrl döner
            return category?._MetaUrl ?? string.Empty;
        }
        //--------------------------------------------------------- belirli bir kategori ID'sine göre _MetaUrl değerini döndürüyor.

        public static string _CategoryURL(int id, string Language = "")
        {
            var category = Bll.GeneralCategories.Select(id, filter: "", lang: Language).FirstOrDefault();

            // Eğer kategori bulunamadıysa boş döner
            if (category == null)
                return string.Empty;

            // Üst kategori URL'sini al
            string parentUrl = category.CatID != 0 ? _CategoryURL(category.CatID, Language) : string.Empty;

            // Kendi URL'sini ekle
            return $"{parentUrl}/{category._MetaUrl}";
        }
        //--------------------------------------------------------- kategori URL'lerini oluştururken kategori hiyerarşisini dikkate alarak bir URL dizisi oluşturur

        public static string _TopCategoryURL(int id, string Language = "")
        {
            var category = Bll.GeneralCategories.Select(id, filter: "", lang: Language).FirstOrDefault();

            // Eğer kategori bulunamadıysa boş döner
            if (category == null)
                return string.Empty;

            // Üst kategori URL'sini al
            string parentUrl = category.CatID != 0 ? _TopCategoryURL(category.CatID, Language) : string.Empty;

            // Kendi URL'sini ekle
            return $"{parentUrl}/{category._MetaUrl}";
        }
        //--------------------------------------------------------- verilen bir kategori ID'si için en üst kategoriye kadar gidip URL'yi oluşturmak.

        public static string _FirstRecordURL(int id, string Language = "")
        {
            var record = Bll.GeneralRecords.Select(0, " AND CatID in (" + MultipleCategoryID(id) + ") AND Approved=1", MenuSortingType(id), startIndex: 0, rowCount: 1, lang: Language).FirstOrDefault();

            // Eğer kayıt bulunamadıysa boş döner
            if (record == null)
                return null;

            // Detaylı bağlantıyı döner
            return _GlobalSiteDetailLink(record.CatID, record.id, Language);
        }
        //--------------------------------------------------------- ilgili kategoriye ait ilk kayıtı url bilgisini getir

        public static string _FirstCategoryURL(int CatID, string Language = "")
        {
            var category = Bll.GeneralCategories.Select(0, " AND CatID=" + CatID + " AND Approved=1", startIndex: 0, rowCount: 1, lang: Language).FirstOrDefault();
            if (category == null)
                return null;

            // Global site bağlantısını döner
            return _GlobalSiteLink(category.PageTypeID, category.id, Language);
        }
        //--------------------------------------------------------- ilgili kategoriye bağlı ilk alt kategorinin url bilgisini getir

        public static string _GlobalConstantLink(int id, string Language = "")
        {
            var category = Bll.GeneralCategories.Select(id, filter: "", lang: Language).FirstOrDefault();

            // Eğer kategori bulunamazsa boş döner
            if (category == null)
                return string.Empty;

            // Global site bağlantısını döner
            return _GlobalSiteLink(category.PageTypeID, category.id, Language);
        }
        //--------------------------------------------------------- id si verilen kategorinin url bilgisini getir

        public static string _GlobalURL(int id, int catID, string catURL, int pageTypeID, string pageTypeConstantURL, bool isDetailSingle, bool isCatDirectList, bool isPageDirectList, string Language = "")
        {
            string returningValue = null;

            #region Root Category (catID == 0)
            if (Convert.ToInt32(catID) == 0)
            {
                if (pageTypeConstantURL.IndexOf("javascript:;") == 0)
                    returningValue = "javascript:;";
                else if (pageTypeConstantURL.IndexOf("#") == 0 || catURL.IndexOf("javascript:;") == 0)
                    returningValue = catURL;
                else
                {
                    if (!isPageDirectList)
                    {
                        if (!isCatDirectList)
                        {
                            List<Entities.GeneralRecords> dListRecords = Bll.GeneralRecords.Select(0, " AND CatID=" + id + " AND Approved=1", lang: Language);
                            if (dListRecords.Count == 1)
                            {
                                foreach (var item in dListRecords)
                                {
                                    returningValue = isDetailSingle ? "/" + item._MetaUrl : "/" + item._MetaUrl + "/";
                                }
                            }
                            else
                                returningValue = "/" + catURL + "/";
                        }
                        else
                            returningValue = "/" + catURL + "/";
                    }
                    else
                        returningValue = "/" + catURL + "/";
                }
            }
            #endregion

            #region Non-Root Category (catID != 0)
            else
            {
                List<Entities.GeneralRecords> dList = Bll.GeneralRecords.Select(0, " AND CatID in (" + MultipleCategoryID(id) + ") AND Approved=1", lang: Language);
                if (dList.Count == 1 && !isPageDirectList)
                {
                    foreach (var item in dList)
                    {
                        #region  !isCatDirectList
                        if (!isCatDirectList)
                        {
                            if (String.IsNullOrEmpty(item.Link))
                            {
                                if (isDetailSingle || isMenuSingleDetail(item.CatID))
                                    returningValue = "/" + item._MetaUrl;
                                else
                                {
                                    switch (Entities.StaticList.Settings.UrlLinkType)
                                    {
                                        case 0:
                                            returningValue = "/" + _TopCategoryURL(id, Language) + "/" + item._MetaUrl;
                                            break;
                                        case 1:
                                            returningValue = catURL == item._MetaUrl
                                                ? "/" + _GetCategoryURL(catID, Language) + "/" + item._MetaUrl
                                                : "/" + _GetCategoryURL(id, Language) + "/" + item._MetaUrl;
                                            break;
                                        case 2:
                                            returningValue = "/" + _CategoryURL(id, Language) + "/" + item._MetaUrl;
                                            break;
                                        case 3:
                                            returningValue = catURL == item._MetaUrl
                                                ? "/" + _GetCategoryURL(catID, Language) + "/" + item._MetaUrl
                                                : "/" + _GetCategoryURL(id, Language) + "/" + item._MetaUrl;
                                            break;
                                        default:
                                            returningValue = "/" + item._MetaUrl; // Or some default value
                                            break;
                                    }
                                }
                            }
                            else
                                returningValue = item.Link;
                        }
                        #endregion

                        #region yes it is
                        else
                        {
                            switch (Entities.StaticList.Settings.UrlLinkType)
                            {
                                case 0:
                                    returningValue = "/" + _TopCategoryURL(id, Language) + "/" + catURL + "/";
                                    break;
                                case 1:
                                    returningValue = "/" + _GetCategoryURL(catID, Language) + "/" + catURL + "/";
                                    break;
                                case 2:
                                    returningValue = "/" + _CategoryURL(catID, Language) + "/" + catURL + "/";
                                    break;
                                case 3:
                                    returningValue = "/" + catURL + "/";
                                    break;
                                default:
                                    returningValue = "/" + catURL + "/"; // Or some default value
                                    break;
                            }
                        }
                        #endregion
                    }
                }
                else
                {
                    int mainPageTypeID = Convert.ToInt32(Bll.GeneralCategories.Select(catID, filter: "", lang: Language)[0].PageTypeID);


                    #region is it same with mainpage type
                    if (mainPageTypeID == pageTypeID)
                    {
                        if (pageTypeConstantURL.IndexOf("#") == 0 || catURL.IndexOf("javascript:;") == 0)
                            returningValue = catURL;
                        else
                        {
                            switch (Entities.StaticList.Settings.UrlLinkType)
                            {
                                case 0:
                                    returningValue = "/" + _TopCategoryURL(id, Language) + "/" + catURL + "/";
                                    break;
                                case 1:
                                    returningValue = "/" + _GetCategoryURL(catID, Language) + "/" + catURL + "/";
                                    break;
                                case 2:
                                    returningValue = "/" + _CategoryURL(catID, Language) + "/" + catURL + "/";
                                    break;
                                case 3:
                                    returningValue = "/" + catURL + "/";
                                    break;
                                default:
                                    returningValue = "/" + catURL + "/"; // Or some default value
                                    break;
                            }
                        }
                    }
                    #endregion

                    #region not it's not
                    else
                    {
                        int subPageTypeID = Convert.ToInt32(Bll.GeneralCategories.Select(catID, filter: "", lang: Language)[0].SubPageTypeID);
                        if (subPageTypeID == pageTypeID)
                        {
                            if (pageTypeConstantURL.IndexOf("#") == 0 || catURL.IndexOf("javascript:;") == 0)
                                returningValue = catURL;
                            else
                            {
                                switch (Entities.StaticList.Settings.UrlLinkType)
                                {
                                    case 0:
                                        returningValue = "/" + _TopCategoryURL(id, Language) + "/" + catURL + "/";
                                        break;
                                    case 1:
                                        returningValue = mainPageTypeID > 5
                                            ? "/" + _GetCategoryURL(catID, Language) + "/" + catURL + "/"
                                            : "/" + catURL + "/";
                                        break;
                                    case 2:
                                        returningValue = "/" + _CategoryURL(catID, Language) + "/" + catURL + "/";
                                        break;
                                    case 3:
                                        returningValue = "/" + catURL + "/";
                                        break;
                                    default:
                                        returningValue = "/" + catURL + "/"; // Or some default value
                                        break;
                                }
                            }
                        }
                        else
                        {
                            string mainSiteKategoriUrl = StaticList.PageTypes.Where(x => (x.id == mainPageTypeID)).FirstOrDefault().ConstantURL;

                            if (pageTypeConstantURL.IndexOf("#") == 0 || catURL.IndexOf("javascript:;") == 0)
                                returningValue = "/" + catURL + "/";
                            else if (mainSiteKategoriUrl.IndexOf("#") == 0 || mainSiteKategoriUrl.IndexOf("javascript:;") == 0)
                                returningValue = "/" + catURL + "/";
                            else
                                returningValue = mainSiteKategoriUrl + catURL + "/";
                        }
                    }
                    #endregion
                }
            }
            #endregion

            return returningValue;
        }
        //--------------------------------------------------------- GlobalUrlBelirtSec

        public static string _GlobalSiteLink(int PageTypeID, int id, string Language = "")
        {
            string returningValue = null;
            List<Entities.zPageTypes> dList = StaticList.PageTypes.Where(x => (x.id == PageTypeID)).ToList();
            foreach (var item in dList)
            {
                List<Entities.GeneralCategories> dataList = Bll.GeneralCategories.Select(Convert.ToInt32(id), filter: "", lang: Language);
                if (dataList.Count > 0)
                {
                    foreach (var items in dataList)
                    {
                        if (Convert.ToBoolean(item.DontAppearSiteMap))
                            returningValue = "javascript:;";
                        else if (String.IsNullOrEmpty(items.Link))
                        {
                            if (PageTypeID != 1)
                            {
                                if (Convert.ToBoolean(item.isLinkFreeRecord))
                                    returningValue = _FirstRecordURL(items.id, Language);
                                else if (Convert.ToBoolean(item.isLinkFreeCategory))
                                    returningValue = _FirstCategoryURL(items.id, Language);
                                else
                                    returningValue = _GlobalURL(items.id, Convert.ToInt32(items.CatID), items._MetaUrl, Convert.ToInt32(items.PageTypeID), item.ConstantURL, Convert.ToBoolean(item.isDetailSingle), Convert.ToBoolean(item.isDirectList), Convert.ToBoolean(item.isDirectList), Language);
                                if (!String.IsNullOrEmpty(returningValue))
                                    returningValue = returningValue.Replace("//", "/");
                            }
                            else
                                returningValue = "/";
                        }
                        else
                        {
                            returningValue = items.Link;
                        }
                    }
                }
            }
            return returningValue;
        }
        //--------------------------------------------------------- GlobalSiteLinkSec

        public static string _GlobalSiteDetailLink(int CatID, int id, string Language = "")
        {
            string returningValue = "";
            List<Entities.GeneralRecords> dList = Bll.GeneralRecords.Select(0, $" AND CatID={CatID} AND id={id} AND Approved=1", lang: Language);
            //---------------------------------------------------------
            if (dList.Count > 0)
            {
                foreach (var item in dList)
                {
                    List<Entities.zPageTypes> pageTypesList = StaticList.PageTypes.Where(x => (x.id == Convert.ToInt32(item._PageTypeID))).ToList();
                    if (Convert.ToBoolean(pageTypesList[0].DontAppearSiteMap) == false)
                    {
                        if (String.IsNullOrEmpty(item.Link))
                        {
                            if (isMenuSingleDetail(Convert.ToInt32(CatID)))
                                returningValue = $"/{item._MetaUrl}";
                            else if (Convert.ToBoolean(pageTypesList[0].isLinkFreeRecord))
                                returningValue = $"/{item._MetaUrl}";
                            else
                            {
                                switch (Entities.StaticList.Settings.UrlLinkType)
                                {
                                    case 0:
                                        returningValue = $"/{_TopCategoryURL(CatID, Language)}/{item._MetaUrl}";
                                        break;
                                    case 1:
                                        returningValue = $"/{_GetCategoryURL(item.CatID, Language)}/{item._MetaUrl}";
                                        break;
                                    case 2:
                                        returningValue = $"/{_CategoryURL(Convert.ToInt32(CatID), Language)}/{item._MetaUrl}";
                                        break;
                                    case 3:
                                        returningValue = $"/{_GetCategoryURL(item.CatID, Language)}/{item._MetaUrl}";
                                        break;
                                    default:
                                        // Optional: Handle unexpected UrlLinkType values
                                        returningValue = ""; // or some default value
                                        break;
                                }
                            }
                        }
                        else
                        {
                            returningValue = item.Link;
                        }
                        returningValue = returningValue.Replace("//", "/");
                    }
                    else
                        returningValue = _GlobalSiteLink(Convert.ToInt32(item._PageTypeID), CatID, Language);
                }
            }
            return returningValue;
        }
        //--------------------------------------------------------- GlobalSiteDetayLinkSec

        #endregion

    }
}