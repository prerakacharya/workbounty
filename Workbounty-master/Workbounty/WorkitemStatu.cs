
//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------


namespace Workbounty
{

using System;
    using System.Collections.Generic;
    
public partial class WorkitemStatu
{

    public WorkitemStatu()
    {

        this.WorkitemHistories = new HashSet<WorkitemHistory>();

    }


    public int WorkitemStatusID { get; set; }

    public string StatusDescription { get; set; }



    public virtual ICollection<WorkitemHistory> WorkitemHistories { get; set; }

}

}
