﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Workbounty.Models;
using System.IO;
namespace Workbounty.Repository
{
    public class WorkitemRepository : ApiController
    {
        private WorkbountyDBEntities entity = new WorkbountyDBEntities();
       
        public string AddWorkitem(Workitem addWorkitemData)
        {
            try
            {
               
                if (ModelState.IsValid)
                {
                    var fileName = Path.GetFileName(addWorkitemData.DocumentFilePath);
                    entity.Workitems.Add(addWorkitemData);
                    entity.SaveChanges();
                    return "Data Successfully saved";
                }
                else
                {
                    return "Error";
                }
            }

            catch (Exception)
            {
                return "error";
            }
        }

        public List<Workitem> GetWorkDetails(int currentWorkitemID)
        {


            var assignWorkitemData = entity.Workitems.Where(a => a.WorkitemID.Equals(currentWorkitemID)).ToList();

            if (assignWorkitemData == null)
            {
                return null;
            }

            return assignWorkitemData;
        }

        [HttpPost]
        public string UserRegisterForWorkitem(WorkitemRegistration dataForWorkitemRegistration)
        {
            try
            {
                entity.WorkitemRegistrations.Add(dataForWorkitemRegistration);
                entity.SaveChanges();
                return "Success";
            }

            catch (Exception)
            {
                return "Error";
            }
        }

        public string AddMemberDetails(Team memberData)
        {
            try
            {
                entity.Teams.Add(memberData);
                entity.SaveChanges();
                return "Success";
            }
            catch (Exception)
            {
                return "Error";
            }
        }

        public List<UpdateWorkitems> ShowCurrentWorkitems(int currentWorkitemID)
        {
            var getDataforAssignWorkitem = entity.WorkItemAssignments.Where(s => s.WorkItemID == currentWorkitemID).Select(s => s.SubmissionPath).FirstOrDefault();
            if (getDataforAssignWorkitem == null)
            {
                var displayData = entity.WorkitemRegistrations.Where(s => s.WorkitemID == currentWorkitemID).Select(s => new UpdateWorkitems { Title = s.Workitem.Title, Summary = s.Workitem.Summary, WorkItemID = s.WorkitemID }).ToList();
                return displayData;
            }
            else
            {
                return null;
            }
        }

        public string UpdateWorkitems(WorkItemAssignment data)
        {
            try
            {
                entity.WorkItemAssignments.Add(data);
                entity.SaveChanges();
                return "Success";
            }
            catch (Exception)
            {
                return "Error";
            }
        }

        public List<OpenWorkitems> GetAllWorkitems(int currentUserID)
        {
            try
            {
              
                var getTeamID = entity.Teams.Where(s => s.UserID == currentUserID).Select(s => s.TeamUserInfoID);
                var getWorkitemData = entity.Workitems.Where(s => s.CreatedBy != currentUserID).Select(s => new OpenWorkitems { WorkitemID = s.WorkitemID, FirstName = s.UserInfo.FirstName, PublishedTo = s.PublishedTo, Title = s.Title, Summary = s.Summary, ProposedReward = s.ProposedReward, Amount = s.Amount }).ToList();
                List<OpenWorkitems> workitemlist = new List<OpenWorkitems>();

                var registereditems = entity.WorkitemRegistrations.Where(s => s.UserID == currentUserID).Select(s => new OpenWorkitems { WorkitemID = s.WorkitemID }).ToList();
                foreach (var getUserData in getWorkitemData)
                {
                    if (getUserData.PublishedTo == 0)
                    {
                        workitemlist.Add(entity.Workitems.Where(s => s.WorkitemID == getUserData.WorkitemID).Select(s => new OpenWorkitems { WorkitemID = s.WorkitemID, FirstName = s.UserInfo.FirstName, Title = s.Title, Summary = s.Summary, ProposedReward = s.ProposedReward, Amount = s.Amount }).FirstOrDefault());
                    }
                    else
                    {
                        foreach (var getUserTeamID in getTeamID)
                        {
                            if (getUserData.PublishedTo == getUserTeamID)
                            {

                                workitemlist.Add(entity.Workitems.Where(s => s.WorkitemID == getUserData.WorkitemID).Select(s => new OpenWorkitems { WorkitemID = s.WorkitemID, FirstName = s.UserInfo.FirstName, Title = s.Title, Summary = s.Summary, ProposedReward = s.ProposedReward, Amount = s.Amount, CreatedDateTime=s.CreatedDateTime }).FirstOrDefault());
                            }
                        }
                    }
                }
                workitemlist.RemoveAll(x => registereditems.Any(y => y.WorkitemID == x.WorkitemID));
                workitemlist = workitemlist.OrderByDescending(s => s.CreatedDateTime).ToList();
                return workitemlist;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public List<AssignWorkitems> GetCurrentWorkitem(int currentUserID)
        {
            List<WorkitemRegistration> item = new List<WorkitemRegistration>();
            var name = entity.WorkitemRegistrations.Where(w => w.UserID == currentUserID).Select(s => s.Workitem.UserInfo.FirstName).FirstOrDefault();
            var getCurrentWorkitemData = entity.WorkitemRegistrations.Where(s => s.UserID == currentUserID).Select(s => new AssignWorkitems { WorkitemID = s.WorkitemID, Title = s.Workitem.Title, StartDate = s.Workitem.StartDate, EndDate = s.Workitem.DueDate, FirstName = name, ProposedReward = s.Workitem.ProposedReward, Amount = s.Workitem.Amount, CreatedDateTime = s.Workitem.CreatedDateTime  }).ToList();
            getCurrentWorkitemData = getCurrentWorkitemData.OrderByDescending(s => s.CreatedDateTime).ToList();
            return getCurrentWorkitemData;
        }

        public List<AddWorkitems> GetCurrentWorkitem()
        {
            var status = entity.WorkitemDistributions.Where(s => s.Workitem.Status);
            var getCurrentWorkitemData = entity.WorkitemDistributions.Select(s => new AddWorkitems { Title = s.Workitem.Title, StartDate = s.Workitem.StartDate, EndDate = s.Workitem.DueDate, FirstName = s.UserInfo.FirstName, ProposedReward = s.Workitem.ProposedReward }).ToList();
            return getCurrentWorkitemData;
        }

        public List<AddWorkitems> ItemsIWantDone(int currentWorkitemID)
        {
            List<Workitem> item = new List<Workitem>();

            var getWorkitemData = from u in entity.Workitems.Where(s => s.CreatedBy == currentWorkitemID)
                        join b in entity.WorkitemDistributions
                        on u.WorkitemID equals b.WorkitemID
                        into userArticles
                        from ua in userArticles.DefaultIfEmpty()
                        select new AddWorkitems { WorkitemID = u.WorkitemID, Title = u.Title, FirstName = ua.UserInfo.FirstName, ProposedReward = u.ProposedReward, StartDate = u.StartDate, EndDate = u.DueDate, CreatedDateTime = u.CreatedDateTime  };
            getWorkitemData = getWorkitemData.OrderByDescending(s => s.CreatedDateTime);
            return getWorkitemData.ToList();
        }

        public List<WorkitemRegistration> AppliedWorkitems(int currentWorkitemID)
        {
            var getDataforAssignWorkitem = entity.WorkitemDistributions.Where(s => s.WorkitemID == currentWorkitemID).FirstOrDefault();

            if (getDataforAssignWorkitem == null)
            {
                var getAssignWorkitemData = entity.WorkitemRegistrations.Where(s => s.WorkitemID == currentWorkitemID && s.IsExclusive == true).ToList();
                return getAssignWorkitemData;
            }
            else
            {
                return null;
            }
        }
        public List<WorkitemDocuments> ShowDocument(int id)
        {
            var getDataForIsRewarded = entity.WorkItemAssignments.Where(s => s.WorkItemID == id).Select(s => s.IsRewarded == true).FirstOrDefault();
            if (getDataForIsRewarded == false)
            {
                var getListofUserAppliedForWorkitem = entity.WorkItemAssignments.Where(s => s.WorkItemID == id).Select(s => new WorkitemDocuments { WorkItemID = s.WorkItemID, UserID = s.UserID, Title = s.Workitem.Title, Summary = s.Workitem.Summary, FirstName = s.UserInfo.FirstName, SubmissionDateTime = s.SubmissionDateTime, SubmissionPath = s.SubmissionPath }).ToList();
                return getListofUserAppliedForWorkitem;
            }
            else
            {
                return null;
            }
        }

        public List<Workitem> GetAllitemsDone(int currentWorkitemID)
        {
            List<WorkitemRegistration> getListofAppliedWorkitem = new List<WorkitemRegistration>();
            var getListofAssignWorkitem = entity.Workitems.Where(s => s.WorkitemID == currentWorkitemID).ToList();
            return getListofAssignWorkitem;
        }

        public string ApplyReward(Rewards id)
        {
            try
            {
                WorkItemAssignment item = entity.WorkItemAssignments.Where(s => s.WorkItemID == id.WorkItemID && s.UserID == id.UserID).First();
                item.IsRewarded = true;
                entity.SaveChanges();
                return "Success";
            }
            catch (Exception)
            {
                return "Error";
            }
        }


        public string AddAssignData(int id)
        {
            if (ModelState.IsValid)
            {
                entity.SaveChanges();
                return "Success";
            }
            return "Error";
        }


        public string WorkitemDistribution(WorkitemDistribution getWorkitemData)
        {
            if (ModelState.IsValid)
            {
                entity.WorkitemDistributions.Add(getWorkitemData);
                entity.SaveChanges();
                return "Success";

            }
            return "Error";
        }

        public List<WorkitemDocuments> ShowExclusiveDocument(int currentWorkitemID)
        {
            var showExclusiveData = entity.WorkItemAssignments.Where(s => s.WorkItemID == currentWorkitemID).Select(s => new WorkitemDocuments { Title = s.Workitem.Title, Summary = s.Workitem.Summary, FirstName = s.UserInfo.FirstName, SubmissionDateTime = s.SubmissionDateTime, SubmissionPath = s.SubmissionPath }).ToList();
            return showExclusiveData;
        }


        public List<Workitem> SearchWorkitems(string searchValue)
        {
            var getSearchWorkitemResults = entity.Workitems.Where(s => s.Title.StartsWith(searchValue)).ToList();

           
                return getSearchWorkitemResults;
            
        }

        public List<Team> SelectTeam(int currentUserID)
        {
            List<Team> selectedteamData = new List<Team>();
            selectedteamData.Add(new Team { TeamName = "Public", TeamUserInfoID = 0 });
            foreach (var item in entity.Teams)
            {
                if (item.UserID == currentUserID)
                {
                    selectedteamData.Add(entity.Teams.Where(s => s.TeamID == item.TeamID).FirstOrDefault());
                }
            }
            return selectedteamData;

        }




    }

}
