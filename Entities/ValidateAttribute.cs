namespace Entities
{
    [System.AttributeUsage(System.AttributeTargets.Class | System.AttributeTargets.Struct | System.AttributeTargets.Property, AllowMultiple = true)]
    public class ValidateAttribute : System.Attribute
    {
        private string Validate;
        public EnumValidate.eValidateType Type { get; set; }
        public string SecondValue { get; set; }
        public string ThirdValue { get; set; }
        public string WarningMessage { get; set; }

        public ValidateAttribute(string validate)
        {
            this.Validate = validate;
        }
    }
}
