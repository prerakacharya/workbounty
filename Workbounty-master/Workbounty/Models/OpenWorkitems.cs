using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Workbounty.Models
{
    public class OpenWorkitems
    {

        public string FirstName { get; set; }
        public string Title { get; set; }
        public string Summary { get; set; }
        public System.DateTime StartDate { get; set; }
        public System.DateTime EndDate { get; set; }
        public string ProposedReward { get; set; }
        public string Amount { get; set; }
        public int WorkitemID { get; set; }
        public int UserID { get; set; }
        public int PublishedTo { get; set; }
        public string Status { get; set; }
        public System.DateTime CreatedDateTime { get; set; }

    }
}