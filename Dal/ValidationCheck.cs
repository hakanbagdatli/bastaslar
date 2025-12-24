using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

namespace Dal
{
    public class ValidationCheck
    {

        static string patternMail = @"\A(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)\Z";

        public static bool CheckValidate(object value, Entities.ValidateAttribute attr)
        {
            bool isOk = true;

            switch (attr.Type)
            {
                case Entities.EnumValidate.eValidateType.required:
                    if (value == null || value.ToString() == "")
                    {
                        isOk = false;
                    }


                    break;
                case Entities.EnumValidate.eValidateType.required_min:
                    break;
                case Entities.EnumValidate.eValidateType.required_min_value:
                    break;
                case Entities.EnumValidate.eValidateType.min_value:
                    break;
                case Entities.EnumValidate.eValidateType.min_length:
                    break;
                case Entities.EnumValidate.eValidateType.max_value:
                    break;
                case Entities.EnumValidate.eValidateType.max_length:
                    break;
                case Entities.EnumValidate.eValidateType.required_max:
                    break;
                case Entities.EnumValidate.eValidateType.required_max_value:
                    break;
                case Entities.EnumValidate.eValidateType.equal_length:
                    break;
                case Entities.EnumValidate.eValidateType.repeat:
                    break;
                case Entities.EnumValidate.eValidateType.email:
                    bool isEmail = Regex.IsMatch(value.ToString(), patternMail, RegexOptions.IgnoreCase);
                    if (!isEmail)
                    {
                        isOk = false;
                    }


                    break;
                case Entities.EnumValidate.eValidateType.notequal:
                    break;
                case Entities.EnumValidate.eValidateType.notequalreq:
                    break;
                case Entities.EnumValidate.eValidateType.numeric: // this value not required
                    if (value != null && value.ToString() != "")
                    {
                        int deger = 0;
                        if (int.TryParse(value.ToString(), out deger))
                        {
                            isOk = true;
                        }
                        else isOk = false;
                    }
                    break;
                case Entities.EnumValidate.eValidateType.numeric_required:
                    if (value == null || value.ToString() == "")
                        isOk = false;
                    else
                    {
                        int deger = 0;
                        if (int.TryParse(value.ToString(), out deger))
                        {
                            isOk = true;
                        }
                        else isOk = false;
                    }
                    break;
                case Entities.EnumValidate.eValidateType.decimal_: // this value not required
                    if (value != null && value.ToString() != "")
                    {
                        decimal deger = 0M;
                        if (decimal.TryParse(value.ToString(), out deger))
                        {
                            isOk = true;
                        }
                        else isOk = false;
                    }
                    break;
                case Entities.EnumValidate.eValidateType.decimal_required:
                    if (value == null || value.ToString() == "")
                        isOk = false;
                    else
                    {
                        decimal deger = 0M;
                        if (decimal.TryParse(value.ToString(), out deger))
                        {
                            isOk = true;
                        }
                        else isOk = false;
                    }
                    break;
                default:
                    break;
            }
            return isOk;

        }
    }
}
