using System;
using Tools;
using System.Web;
using System.Linq;
using System.Collections.Generic;
using Entities;
using Utility;

namespace WebSite.Raven.General
{
    public class zUploader : IHttpHandler
    {

        public int UserID = Developer.UserToken("").UserID;

        public void ProcessRequest(HttpContext context)
        {
            string parameters = context.Request.Params.ToString();
            context.Response.ContentType = "text/plain";
            string Table = SplitParameters(parameters, 0);
            string CatID = SplitParameters(parameters, context.Request.Files.Count);
            //------------------------------------------------------------
            List<Entities.GeneralRecords> dList = StaticList.Records.Where(x => (x.id == Convert.ToInt32(CatID))).ToList();
            if (dList.Count > 0)
            {
                foreach (var item in dList)
                {
                    for (int i = 0; i < context.Request.Files.Count; i++)
                    {
                        HttpPostedFile file = context.Request.Files[i];
                        string filesize = file.ContentLength.ToString();
                        string fileExtension = System.IO.Path.GetExtension(file.FileName.ToLower());
                        string fileName = file.FileName;
                        fileName = fileName.Replace(fileExtension, "");
                        if (!string.IsNullOrEmpty(fileName))
                        {
                            string fileTitle = item.Title;
                            //---------------------------------------------------------
                            fileName = Function.ImageSeoReplace(item.Title);
                            //---------------------------------------------------------
                            fileName = fileName + "-" + Uploads.RandomNumber + i + fileExtension;
                            //---------------------------------------------------------
                            InsertDatabase(Function.RevertSeoString(fileTitle), CatID, fileName, filesize, Table);
                            string pathToSave = SavingPath(Table) + fileName;
                            file.SaveAs(pathToSave);
                        }
                    }
                }
            }
        }
        //---------------------------------------------------------

        protected string SavingPath(string TurID)
        {
            switch (TurID)
            {
                case "files":
                    return HttpContext.Current.Server.MapPath("~/uploads/files/"); ;
                default:
                    return HttpContext.Current.Server.MapPath("~/uploads/images/");
            }
        }
        //--------------------------------------------------------- dosyanın kaydedileceği konum

        protected string SplitParameters(string param, int paramIndex)
        {
            var splitParam = param.Split('&');
            int paramCount = splitParam.Length;
            var splitID = splitParam[paramIndex].ToString().Split('=');
            return splitID[1];
        }
        //--------------------------------------------------------- karışık gelen datanın ayrıştırılması

        protected void InsertDatabase(string title, string CatID, string name, string size, string Path)
        {
            switch (Path)
            {
                case "images":
                    List<Entities.GeneralPhotos> photoList = new List<Entities.GeneralPhotos>  {
                        new Entities.GeneralPhotos  {
                            CatID = Convert.ToInt32(CatID),
                            Title = title,
                            Image = name,
                            CreatedUser = UserID,
                            CreatedDate = DateTime.Now
                        }
                    };
                    foreach (var item in photoList) { item.Save(); }
                    break;
                case "plans":
                    List<Entities.GeneralPlans> planList = new List<Entities.GeneralPlans>  {
                        new Entities.GeneralPlans  {
                            CatID = Convert.ToInt32(CatID),
                            Title = title,
                            Image = name,
                            CreatedUser = UserID,
                            CreatedDate = DateTime.Now
                        }
                    };
                    foreach (var item in planList) { item.Save(); }
                    break;
                case "files":
                    List<Entities.GeneralFiles> fileList = new List<Entities.GeneralFiles>  {
                        new Entities.GeneralFiles  {
                            CatID = Convert.ToInt32(CatID),
                            Title = title,
                            Filename = name,
                            Filesize = size,
                            CreatedUser = UserID,
                            CreatedDate = DateTime.Now
                        }
                    };
                    foreach (var item in fileList) { item.Save(); }
                    break;
            }
        }
        //--------------------------------------------------------- database kaydet

        public bool IsReusable
        {
            get { return false; }
        }
        //--------------------------------------------------------- yeniden gönderimi iptal et
    }
}