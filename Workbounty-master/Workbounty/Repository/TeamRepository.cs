using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Workbounty.Models;

namespace Workbounty.Repository
{
    public class TeamRepository : ApiController
    {
        WorkbountyDBEntities entity = new WorkbountyDBEntities();
        public List<TeamInformation> GetTeamList(int id)
        {
            List<TeamInformation> team = new List<TeamInformation>();
            try
            {
                int currentUserid = id;
                var selectTeam = entity.Teams.Where(s => s.UserID == currentUserid).Select(s => s.TeamUserInfoID);
                foreach (var item in selectTeam)
                {
                    var data = entity.Teams.Where(s => s.TeamUserInfoID == item).ToList();
                    TeamInformation teamInfo = new TeamInformation();
                    teamInfo.TeamUserInfoID = item;
                    foreach (var _user in data)
                    {
                        TeamUserInfo _team = new TeamUserInfo { FirstName = _user.UserInfo.FirstName, Email = _user.UserInfo.Email, PhoneNumber = _user.UserInfo.PhoneNumber,TeamName=_user.TeamName};
                        teamInfo.TeamUserList.Add(_team);
                    }
                    team.Add(teamInfo);
                }
            }
            catch (Exception)
            {
                return null;
            }
            return team;
        }
        public List<UserInfo> GetMemberResult(string memberName)
        {
            try
            {
                var getMemberData = entity.UserInfoes.Where(s => s.LastName.ToLower().StartsWith(memberName)
                              || s.FirstName.ToLower().StartsWith(memberName)).ToList();

                if (getMemberData == null)
                {

                    return null;
                }

                return getMemberData;
            }
            catch (Exception)
            {
                return null;

            }
        }

        public int AddTeamData(Team teamData)
        {
            try
            {
            Again:
                var qwe = entity.Teams.Where(s => s.TeamUserInfoID == teamData.TeamUserInfoID).FirstOrDefault();

                if (qwe == null)
                {
                   var getID = Convert.ToInt32(teamData.TeamUserInfoID);
                    entity.Teams.Add(teamData);
                    entity.SaveChanges();
                    return getID;
                }
                else
                {
                    teamData.TeamUserInfoID = teamData.TeamUserInfoID + 1;
                    goto Again;
                }
            }
            catch (Exception)
            {
                return 0;
;

            }
        }


        public string AddMemberData(Team memberData)
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
    }
}