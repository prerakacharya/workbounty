using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Workbounty.Models;

namespace Workbounty.Repository
{
    public class UserRepository : ApiController
    {
        private WorkbountyDBEntities entity = new WorkbountyDBEntities(); 

        public UserInfo UserLogin(UserInfo userLoginData)
        {
            try
            {
                var checkLoginData = entity.UserInfoes.Where(a => a.Email.Equals(userLoginData.Email) && a.Password.Equals(userLoginData.Password)).FirstOrDefault();

                if (checkLoginData == null)
                {
                    return checkLoginData;
                }
                else
                {
                    return checkLoginData;
                }
            }
            catch (Exception)
            {
                return null;
            }

        }

        public UserInfo AddUserDetails(UserInfo userSignupData)
        {
            try
            {
                var checkUserSignupInfo = entity.UserInfoes.Where(a => a.Email.Equals(userSignupData.Email)).FirstOrDefault();
                if (checkUserSignupInfo == null)
                {
                    entity.UserInfoes.Add(userSignupData);
                    entity.SaveChanges();
                    return userSignupData;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception)
            {
                return null;
            }
        }


        public List<UserProfileInfo> ViewUserProfileDetails(int currentUserData)
        {
            try
            {
                if (currentUserData != null)
                {
                    var getUserDetails = entity.UserInfoes.Where(s => s.UserID == currentUserData).Select(s => new UserProfileInfo { Email = s.Email, FirstName = s.FirstName, LastName = s.LastName, DateOfBirth = s.DateOfBirth, InterestedKeywords = s.InterestedKeywords, PhoneNumber = s.PhoneNumber }).ToList();
                    return getUserDetails;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception)
            {
                return null;
            }

        }




    }
}