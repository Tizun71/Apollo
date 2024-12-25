using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Constants
{
    public enum OrderStatus
    {
        CANCELED = -1,
        PENDING = 0,
        PROCESSING = 1,
        DELIVERING = 2,
        COMPLETED = 3,
    }
}
