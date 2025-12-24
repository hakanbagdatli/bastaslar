using System;
using System.IO;
using System.Web;
using System.Drawing;
using System.Drawing.Drawing2D;

namespace Tools
{

    public class Uploads
    {
        public static string RandomNumber
        {
            get { return new Random().Next(1, 9999).ToString(); }
        }
        //---------------------------------------------------------

        public static Image Resize(Image img, int en, int boy)
        {
            Bitmap bmp = new Bitmap(en, boy);
            Graphics graphic = Graphics.FromImage((Image)bmp);
            graphic.InterpolationMode = InterpolationMode.HighQualityBicubic;
            graphic.SmoothingMode = SmoothingMode.HighQuality;
            graphic.PixelOffsetMode = PixelOffsetMode.HighQuality;
            graphic.CompositingQuality = CompositingQuality.HighQuality;
            graphic.DrawImage(img, 0, 0, en, boy);
            graphic.Dispose();
            return (Image)bmp;
        }
        //---------------------------------------------------------

        public static int[] RateofImage(double Y, double G, int constant)
        {
            double imageHeight = Y + 1;
            double imageWidth = G;
            double rate = 0;
            if (imageWidth > imageHeight && imageWidth > constant)
            {
                rate = imageWidth / imageHeight;
                imageWidth = constant;
                imageHeight = constant / rate;
            }
            else if (imageHeight > imageWidth && imageHeight > constant)
            {
                rate = imageHeight / imageWidth;
                imageHeight = constant;
                imageWidth = constant / rate;
            }
            int height = Convert.ToInt32(imageHeight);
            int width = Convert.ToInt32(imageWidth);
            int[] returnedValue = { width, height };
            return returnedValue;
        }
        //---------------------------------------------------------

        public static Bitmap DrawPicture(Bitmap image, Bitmap PictureToDraw)
        {
            int imageWidth = image.Width;
            int imageHeight = image.Height;
            int PictureToDrawWidth = PictureToDraw.Width;
            int PictureToDrawHeight = PictureToDraw.Height;
            //---------------------------------------------------------
            Graphics g = Graphics.FromImage(image);
            g.SmoothingMode = SmoothingMode.HighQuality;
            if (!String.IsNullOrEmpty(Entities.StaticList.Settings.WatermakLeftPosition.ToString()))
            { 
                g.DrawImage(PictureToDraw, new Point() 
                { 
                    X = (imageWidth - PictureToDrawWidth) / 2, 
                    Y = (imageHeight - PictureToDrawHeight) / 2 
                }); 
            }
            else
            { 
                g.DrawImage(PictureToDraw, new Point() 
                { 
                    X = Convert.ToInt32(Entities.StaticList.Settings.WatermakLeftPosition), 
                    Y = Convert.ToInt32(Entities.StaticList.Settings.WatermakTopPosition) 
                }); 
            }
            return image;
        }
        //---------------------------------------------------------

        public static Image ImageSizingByWidth(Image imgPhoto, int height)
        {
            int sourceWidth = imgPhoto.Width;
            int sourceHeight = imgPhoto.Height;
            int destWidth = height;
            int destHeight = sourceHeight * height / imgPhoto.Width; //Resmin bozulmaması için en boy ayarını veriyoruz.
            Bitmap bmPhoto = new Bitmap(destWidth, destHeight);
            bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);
            Graphics grPhoto = Graphics.FromImage(bmPhoto);
            grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic; // Resmin kalitesini ayarlıyoruz.
            grPhoto.FillRectangle(Brushes.Transparent, 0, 0, destWidth, destHeight);
            grPhoto.DrawImage(imgPhoto, new Rectangle(0, 0, destWidth, destHeight), new Rectangle(0, 0, sourceWidth, sourceHeight), GraphicsUnit.Pixel);
            grPhoto.Dispose();
            return bmPhoto;
        }
        //---------------------------------------------------------

        public static Image ImageSizingByHeight(Image imgPhoto, int width)
        {
            int sourceWidth = imgPhoto.Width;
            int sourceHeight = imgPhoto.Height;
            int destHeight = width;
            int destWidth = sourceWidth * width / imgPhoto.Height; //Resmin bozulmaması için en boy ayarını veriyoruz.
            Bitmap bmPhoto = new Bitmap(destWidth, destHeight);
            bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);
            Graphics grPhoto = Graphics.FromImage(bmPhoto);
            grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic; // Resmin kalitesini ayarlıyoruz.
            grPhoto.FillRectangle(Brushes.Transparent, 0, 0, destWidth, destHeight);
            grPhoto.DrawImage(imgPhoto, new Rectangle(0, 0, destWidth, destHeight), new Rectangle(0, 0, sourceWidth, sourceHeight), GraphicsUnit.Pixel);
            grPhoto.Dispose();
            return bmPhoto;
        }
        //---------------------------------------------------------

        public static Image CustomImageResizing(Image imgPhoto, int height, int width)
        {
            int sourceWidth = imgPhoto.Width;
            int sourceHeight = imgPhoto.Height;
            int destWidth = width;
            int destHeight = height;
            Bitmap bmPhoto = new Bitmap(destWidth, destHeight);
            bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);
            Graphics grPhoto = Graphics.FromImage(bmPhoto);
            grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic; // Resmin kalitesini ayarlıyoruz.
            grPhoto.FillRectangle(Brushes.Transparent, 0, 0, destWidth, destHeight);
            grPhoto.DrawImage(imgPhoto, new Rectangle(0, 0, destWidth, destHeight), new Rectangle(0, 0, sourceWidth, sourceHeight), GraphicsUnit.Pixel);
            grPhoto.Dispose();
            return bmPhoto;
        }
        //---------------------------------------------------------

        public static string FileWithoutResizing(HttpPostedFile path, string foldername, string givenname)
        {
            string filename = "";
            string extension = System.IO.Path.GetExtension(path.FileName.ToLower());
            //---------------------------------------------------------
            if (path.ContentLength > 0 && (extension == ".jpg" | extension == ".jpeg" | extension == ".svg" | extension == ".gif" | extension == ".png" | extension == ".swf" | extension == ".rar" | extension == ".zip" | extension == ".pdf" | extension == ".doc" | extension == ".docx" | extension == ".xls" | extension == ".xlsx" | extension == ".pps" | extension == ".ppsx" | extension == ".ppt" | extension == ".pptx" | extension == ".ico") && (path.FileName.ToLower().IndexOf(";") == -1) && (Function.ClearUploadSql(path.FileName.ToLower()) == 0))
            {

                try
                {
                    if (!String.IsNullOrEmpty(givenname))
                        filename = Function.ImageSeoReplace(givenname.Replace(extension, "")) + "-" + RandomNumber;
                    else
                        filename = Function.ImageSeoReplace(path.FileName.Replace(extension, "-")) + RandomNumber;
                }
                catch { filename = Function.Random(); }
                //--------------------------------------------------------- Dosya Adı

                filename = filename + Path.GetExtension(path.FileName.ToLower());
                string fullPath = HttpContext.Current.Server.MapPath(foldername + filename);
                path.SaveAs(fullPath);
                //--------------------------------------------------------- Dosya'yı Kaydet


                if (extension == ".jpg" | extension == ".jpeg" | extension == ".gif" | extension == ".png")
                {
                    //---------------------------------------------------------
                    Image imgPhotoVert1 = Image.FromFile(HttpContext.Current.Server.MapPath(foldername) + filename);
                    Image imgPhoto = null;
                    imgPhoto = ImageSizingByWidth(imgPhotoVert1, imgPhotoVert1.Width);
                    imgPhotoVert1.Dispose();
                    //---------------------------------------------------------
                    if (extension == ".jpg" | extension == ".jpeg") { imgPhoto.Save(HttpContext.Current.Server.MapPath(foldername) + filename, System.Drawing.Imaging.ImageFormat.Jpeg); }
                    //---------------------------------------------------------
                    else if (extension == ".gif") { imgPhoto.Save(HttpContext.Current.Server.MapPath(foldername) + filename, System.Drawing.Imaging.ImageFormat.Gif); }
                    //---------------------------------------------------------
                    else { imgPhoto.Save(HttpContext.Current.Server.MapPath(foldername) + filename, System.Drawing.Imaging.ImageFormat.Png); }
                    //---------------------------------------------------------
                    imgPhoto.Dispose();
                    //---------------------------------------------------------
                }
                //--------------------------------------------------------- Resim ise boyutlandır

            }
            return filename;
        }
        //---------------------------------------------------------

        public static string ImageFile(HttpPostedFile postedFile, string foldername, int thumbnailWidth, int imageWidth, string givenname)
        {
            //---------------------------------------------------------
            if (Convert.ToBoolean(Entities.StaticList.Settings.canCrop)) { return CropImageByWidth(postedFile, foldername, thumbnailWidth, imageWidth, givenname); }
            //---------------------------------------------------------
            else { return FileWithoutResizing(postedFile, foldername, givenname); }
            //---------------------------------------------------------
        }
        //---------------------------------------------------------

        public static string CropImageByWidth(HttpPostedFile path, string foldername, int thumbnailWidth, int imageWidth, string givenname)
        {
            string imagename = "false";
            string extension = System.IO.Path.GetExtension(path.FileName.ToLower());
            if (path.ContentLength > 0 && (extension == ".jpg" | extension == ".jpeg" | extension == ".gif" | extension == ".png") && (path.FileName.ToLower().IndexOf(";") == -1) && (Function.ClearUploadSql(path.FileName.ToLower()) == 0))
            {
                //---------------------------------------------------------
                string imageFolder = foldername, random = "";
                //---------------------------------------------------------
                try
                {
                    if (!String.IsNullOrEmpty(givenname)) { random = Function.ImageSeoReplace(givenname); }
                    //---------------------------------------------------------
                    else { random = Function.ImageSeoReplace(path.FileName.Replace(extension, "-")) + RandomNumber; ; }
                    //---------------------------------------------------------
                }
                catch { random = Function.Random(); }
                //---------------------------------------------------------


                //---------------------------------------------------------
                imagename = random + Path.GetExtension(path.FileName.ToLower());
                //---------------------------------------------------------
                string fullPath = System.Web.HttpContext.Current.Server.MapPath(imageFolder + random + Path.GetExtension(path.FileName.ToLower())); path.SaveAs(fullPath);


                //---------------------------------------------------------
                System.Drawing.Image imgPhotoVert = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath(imageFolder) + imagename);
                System.Drawing.Image imgPhoto = null;
                //---------------------------------------------------------
                if (imgPhotoVert.Width > thumbnailWidth) { imgPhoto = ImageSizingByWidth(imgPhotoVert, thumbnailWidth); }
                //---------------------------------------------------------
                else { imgPhoto = ImageSizingByWidth(imgPhotoVert, imgPhotoVert.Width); }
                //---------------------------------------------------------
                imgPhotoVert.Dispose(); imgPhoto.Dispose();
                //---------------------------------------------------------


                //---------------------------------------------------------
                System.Drawing.Image imgPhotoVert1 = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath(imageFolder) + imagename); System.Drawing.Image imgPhoto1 = null;
                //---------------------------------------------------------
                if (imgPhotoVert1.Width > imageWidth) { imgPhoto1 = ImageSizingByWidth(imgPhotoVert1, imageWidth); }
                //---------------------------------------------------------
                else { imgPhoto1 = ImageSizingByWidth(imgPhotoVert1, imgPhotoVert1.Width); }
                //---------------------------------------------------------
                imgPhotoVert1.Dispose();
                //---------------------------------------------------------

                if (extension == ".jpg" | extension == ".jpeg") { imgPhoto1.Save(fullPath, System.Drawing.Imaging.ImageFormat.Jpeg); }
                //---------------------------------------------------------
                else if (extension == ".gif") { imgPhoto1.Save(fullPath, System.Drawing.Imaging.ImageFormat.Gif); }
                //---------------------------------------------------------
                else if (extension == ".png") { imgPhoto1.Save(fullPath, System.Drawing.Imaging.ImageFormat.Png); }
                //---------------------------------------------------------
                else { imgPhoto1.Save(fullPath, System.Drawing.Imaging.ImageFormat.Jpeg); }
                //---------------------------------------------------------
                imgPhoto1.Dispose();
                //---------------------------------------------------------
                new FileInfo(fullPath).Delete(); fullPath = null;
            }
            return imagename;
        }
        //---------------------------------------------------------

    }
}
