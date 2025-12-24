using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Text.RegularExpressions;

namespace Utility
{
    public class Helper
    {

        #region String İşlemleri


        public static string NormalizeUTF8(string incomingData)
        {
            string returningvalue = incomingData;
            List<string> utfCh = new List<string> { "Ä±", "Ã§", "ÅŸ", "Ã¶", "Ã¼", "ÄŸ", "Ä°", "Ã‡", "ÅŸ", "Ã–", "Ãœ", "ÄŸ", "Ý", "ý", "ð", "Ð", "þ", "Þ" };
            List<string> utfChTR = new List<string> { "ı", "ç", "ş", "ö", "ü", "ğ", "İ", "Ç", "Ş", "Ö", "Ü", "Ğ", "İ", "ı", "ğ", "Ğ", "ş", "Ş" };
            for (int i = 0; i < utfCh.Count; i++)
            {
                returningvalue = incomingData.Replace(utfCh[i], utfChTR[i]);
            }
            return returningvalue;
        }
        //---------------------------------------------------------

        public static bool HasChar(string value, string item)
        {
            return value.Contains(item);
        }
        //---------------------------------------------------------

        public static string Substring(string value, string item)
        {
            try
            {
                int length = value.IndexOf(item);
                return value.Substring(0, length);
            }
            catch { return value; }
        }
        //---------------------------------------------------------

        public static string CharRestriction(string value, int length)
        {
            try
            {
                if (value.Length > length)
                    return value.Substring(0, length) + "...";
                return value;
            }
            catch
            { return null; }
        }
        //---------------------------------------------------------

        public static string AllLetterLowercase(object text)
        {
            try
            {
                return text.ToString().ToLower(new System.Globalization.CultureInfo("en-GB", false));
            }
            catch { return ""; }
        }
        //---------------------------------------------------------

        public static string AllLetterUppercase(object text)
        {
            try
            {
                return text.ToString().ToUpper(new System.Globalization.CultureInfo("en-GB", false));
            }
            catch { return ""; }
        }
        //---------------------------------------------------------

        public static string FirstLetterUppercase(object text)
        {
            try
            { return System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(text.ToString().ToLower()); }
            catch { return ""; }
        }
        //---------------------------------------------------------

        public static string DeleteFirstChar(string value)
        {
            return value.Substring(1);
        }
        //---------------------------------------------------------

        public static string DeleteLastChar(string value)
        {
            return value.Substring(0, value.Length - 1);
        }
        //---------------------------------------------------------

        public static string ShortDateFormat(string date)
        {
            if (!String.IsNullOrEmpty(date))
            {
                date = Convert.ToDateTime(date).ToString("dd.MM.yyyy");
            }
            return date;
        }
        //---------------------------------------------------------

        public static string DateFormat(string date)
        {
            if (!String.IsNullOrEmpty(date))
            {
                date = Convert.ToDateTime(date).ToString("dd.MM.yyyy - HH:mm");
            }
            return date;
        }
        //---------------------------------------------------------

        public static string SQLDateFormat(string date)
        {
            try
            {
                if (!String.IsNullOrEmpty(date))
                {
                    date = Convert.ToDateTime(date).ToString("yyyy-MM-dd");
                }
                return date;
            }
            catch (Exception) { return ""; }
        }
        //---------------------------------------------------------

        public static string SiteDateFormat(string date)
        {
            try
            {
                if (!String.IsNullOrEmpty(date))
                {
                    date = Convert.ToDateTime(date).ToString("dd MMMMM yyyy");
                }
                return date;
            }
            catch (Exception) { return ""; }
        }
        //---------------------------------------------------------

        public static string DatewithCulture(string date, string culture)
        {
            try
            {
                if (!String.IsNullOrEmpty(date))
                {
                    switch (culture)
                    { 
                        case "1":
                            date = Convert.ToDateTime(date).ToString("dd MMMMM yyyy", new CultureInfo("tr-TR"));
                            break;
                        default:
                            date = Convert.ToDateTime(date).ToString("dd MMMMM yyyy", new CultureInfo("en-GB"));
                            break;
                    }
                }
                return date;
            }
            catch (Exception) { return ""; }
        }
        //---------------------------------------------------------

        public static int DayDifference(DateTime date1, DateTime date2)
        {
            TimeSpan fark = date2.Subtract(date1);
            int gunFarki = (int)fark.TotalDays;
            return gunFarki;
        }
        //---------------------------------------------------------

        public static ArrayList SplitedList(string splitItem, string list)
        {
            ArrayList returnedList = new ArrayList();
            if (!String.IsNullOrEmpty(list))
            {
                try
                {
                    string[] items = Regex.Split(list, splitItem);
                    foreach (string _item in items) 
                    { 
                        returnedList.Add(_item); 
                    }
                }
                catch  { returnedList.Add(list); }
            }
            return returnedList;
        }
        //---------------------------------------------------------

        public static string DeleteAfterString(string text, string item)
        {
            int pos = text.IndexOf(item);
            if (pos > 0)
                return text.Substring(0, pos);
            else
                return text;
        }
        //---------------------------------------------------------

        public static string MoneyFormat(double value)
        {
            try
            {
                return string.Format("{0:C2}", value).Replace("₺", "").Replace("£", "");
            }
            catch (Exception) { return "0.00"; }
        }
        //---------------------------------------------------------


        public static double MoneytoDouble(string value)
        {
            try
            {
                CultureInfo culture = new CultureInfo("tr-TR");
                NumberStyles style = NumberStyles.AllowDecimalPoint | NumberStyles.AllowThousands;
                if (double.TryParse(value, style, culture, out double result))
                    return result;
                else
                    return 0;

            }
            catch (Exception) { return 0; }
        }
        //---------------------------------------------------------

        public static string OnlyNumber(string value) { return Regex.Replace(value, "[^0-9]+", string.Empty).ToString(); }
        //---------------------------------------------------------

        #endregion

        public static string CalculatePercentage(double amount, double percentage)
        {
            return MoneyFormat((amount * percentage) / 100);
        }
        //---------------------------------------------------------

        public static string FileSize(string ByteValue)
        {
            try
            {
                if (!String.IsNullOrEmpty(ByteValue))
                {
                    string[] suf = { " B", " KB", " MB", " GB", " TB", " PB", " EB" };
                    long bytes = Math.Abs(Convert.ToInt32(ByteValue));
                    int place = Convert.ToInt32(Math.Floor(Math.Log(bytes, 1024)));
                    double num = Math.Round(bytes / Math.Pow(1024, place), 1);
                    return (Math.Sign(bytes) * num).ToString() + suf[place];
                }
                return "";
            }
            catch
            {
                return "";
            }
        }
        //---------------------------------------------------------

        public static string RandomPassword()
        {
            string returningData = ""; string password = "";
            Random rnd = new Random();
            //---------------------------------------------------------
            int number = rnd.Next(1000, 9999);
            //---------------------------------------------------------
            for (int i = 0; i < 3; i++)
            {
                int ascii = rnd.Next(65, 91);
                char ch = Convert.ToChar(ascii);
                if (i % 2 == 0) { password += AllLetterLowercase(Convert.ToString(ch)); }
                else { password += Convert.ToString(ch); }
            }
            //---------------------------------------------------------
            returningData = Convert.ToString(password + "" + number);
            return returningData.ToLower();
        }
        //---------------------------------------------------------

        public static string SiteLocations(string text)
        {
            return text.Replace(",,", "~").Replace(",", "").Replace("~", ",");
        }
        //---------------------------------------------------------

    }
}