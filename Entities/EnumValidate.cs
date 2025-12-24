namespace Entities
{
    public class EnumValidate
    {
        public enum eValidateType
        {
            required = 5,
            required_min = 10,
            required_min_value = 15,
            min_value = 20,
            min_length = 25,
            max_value = 30,
            max_length = 35,
            required_max = 40,
            required_max_value = 45,
            equal_length = 50,
            repeat = 55,
            email = 60,
            notequal = 65,
            notequalreq = 70,
            numeric = 80, // not required if value input it must be numeric
            numeric_required = 85,
            decimal_ = 90,
            decimal_required = 95,

        }

        public enum Reservation
        {

            waiting = 1,
            pending = 2,
            approved = 3,
            active = 4,
            done = 5,
            cancelled = 6
        }
    }
}
