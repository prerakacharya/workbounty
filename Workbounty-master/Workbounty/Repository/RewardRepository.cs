using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Workbounty.Models;

namespace Workbounty.Repository
{
    public class RewardRepository : ApiController
    {
        private WorkbountyDBEntities entity = new WorkbountyDBEntities();
        public List<Rewards> GetAllRewards(int currentUserID)
        {
        
            var assignUserId = entity.WorkItemAssignments.Where(a => a.UserID.Equals(currentUserID) && a.IsRewarded == true).ToList();
            List<Rewards> displayRewarddata = new List<Rewards>();

            if (assignUserId == null)
            {
                return null;
            }
            else
            {
                foreach (var data in assignUserId)
                {
                    displayRewarddata = entity.WorkItemAssignments.Select(s => new Rewards { Title = s.Workitem.Title, FirstName = s.UserInfo.FirstName, ProposedReward = s.Workitem.ProposedReward, Amount = s.Workitem.Amount }).ToList();
                }
                return displayRewarddata;
            }
        }

       
    }
}