namespace Entities.Items
{
    public class ResponseStatus
    {
        public string MerchantId { get; set; }
        public string OrderId { get; set; }
        public string TransId { get; set; }
        public string Status { get; set; }
        public string Amount { get; set; }
        public string Currency { get; set; }
        public object ResellerCode { get; set; }
        public int Installment { get; set; }
        public string ErrorMsg { get; set; }
        public string Hash { get; set; }
    }

    public class PaymentResult
    {
        public string Status { get; set; }
        public string Description { get; set; }
        public ResponseStatus Result { get; set; }
    }
}
