USE [master]
GO
/****** Object:  Database [WorkbountyDB]    Script Date: 04/10/2016 21:15:17 ******/
CREATE DATABASE [WorkbountyDB] ON  PRIMARY 
( NAME = N'WorkbountyDB', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MYPC\MSSQL\DATA\WorkbountyDB.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'WorkbountyDB_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MYPC\MSSQL\DATA\WorkbountyDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [WorkbountyDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WorkbountyDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WorkbountyDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [WorkbountyDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [WorkbountyDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [WorkbountyDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [WorkbountyDB] SET ARITHABORT OFF
GO
ALTER DATABASE [WorkbountyDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [WorkbountyDB] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [WorkbountyDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [WorkbountyDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [WorkbountyDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [WorkbountyDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [WorkbountyDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [WorkbountyDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [WorkbountyDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [WorkbountyDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [WorkbountyDB] SET  DISABLE_BROKER
GO
ALTER DATABASE [WorkbountyDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [WorkbountyDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [WorkbountyDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [WorkbountyDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [WorkbountyDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [WorkbountyDB] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [WorkbountyDB] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [WorkbountyDB] SET  READ_WRITE
GO
ALTER DATABASE [WorkbountyDB] SET RECOVERY SIMPLE
GO
ALTER DATABASE [WorkbountyDB] SET  MULTI_USER
GO
ALTER DATABASE [WorkbountyDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [WorkbountyDB] SET DB_CHAINING OFF
GO
USE [WorkbountyDB]
GO
/****** Object:  Table [dbo].[WorkitemStatus]    Script Date: 04/10/2016 21:15:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkitemStatus](
	[WorkitemStatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusDescription] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_WorkitemStatus] PRIMARY KEY CLUSTERED 
(
	[WorkitemStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 04/10/2016 21:15:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[PhoneNumber] [nvarchar](25) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[InterestedKeywords] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 04/10/2016 21:15:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [nvarchar](50) NOT NULL,
	[UserID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TeamUserInfoID] [int] NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Workitem]    Script Date: 04/10/2016 21:15:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Workitem](
	[WorkitemID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Summary] [nvarchar](200) NOT NULL,
	[StartDate] [date] NOT NULL,
	[DueDate] [date] NOT NULL,
	[PublishedTo] [int] NOT NULL,
	[DocumentFilePath] [nvarchar](250) NOT NULL,
	[ProposedReward] [nvarchar](50) NOT NULL,
	[Amount] [nvarchar](50) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[ModifyBy] [int] NOT NULL,
	[ModifyDateTime] [datetime] NOT NULL,
	[Status] [bit] NOT NULL,
	[Remarks] [nvarchar](100) NOT NULL,
	[IsOpenForGroup] [bit] NOT NULL,
 CONSTRAINT [PK_Workitem] PRIMARY KEY CLUSTERED 
(
	[WorkitemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkitemRegistration]    Script Date: 04/10/2016 21:15:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkitemRegistration](
	[WorkitemID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[IsExclusive] [bit] NOT NULL,
	[IsFavourite] [bit] NOT NULL,
	[IsRegistered] [bit] NOT NULL,
	[WorkitemRegistrationID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_WorkitemRegistration] PRIMARY KEY CLUSTERED 
(
	[WorkitemRegistrationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkitemHistory]    Script Date: 04/10/2016 21:15:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkitemHistory](
	[WorkitemID] [int] NOT NULL,
	[WorkitemStatusID] [int] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[UpdatedDateTIme] [datetime] NOT NULL,
	[WorkitemHistoryID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_WorkitemHistory] PRIMARY KEY CLUSTERED 
(
	[WorkitemHistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkitemDistribution]    Script Date: 04/10/2016 21:15:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkitemDistribution](
	[WorkitemID] [int] NOT NULL,
	[TeamID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[WorkitemDistributionID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_WorkitemDistribution] PRIMARY KEY CLUSTERED 
(
	[WorkitemDistributionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkItemAssignment]    Script Date: 04/10/2016 21:15:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkItemAssignment](
	[WorkItemAssignmentID] [int] IDENTITY(1,1) NOT NULL,
	[WorkItemID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[SubmissionPath] [nvarchar](250) NOT NULL,
	[IsRewarded] [bit] NOT NULL,
	[SubmissionDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_WorkItemAssignment] PRIMARY KEY CLUSTERED 
(
	[WorkItemAssignmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_UserInfo_UserInfo]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[UserInfo]  WITH CHECK ADD  CONSTRAINT [FK_UserInfo_UserInfo] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfo] ([UserID])
GO
ALTER TABLE [dbo].[UserInfo] CHECK CONSTRAINT [FK_UserInfo_UserInfo]
GO
/****** Object:  ForeignKey [FK_Team_Team]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [FK_Team_Team]
GO
/****** Object:  ForeignKey [FK_Team_UserInfo]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_UserInfo] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfo] ([UserID])
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [FK_Team_UserInfo]
GO
/****** Object:  ForeignKey [FK_Workitem_UserInfo1]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[Workitem]  WITH CHECK ADD  CONSTRAINT [FK_Workitem_UserInfo1] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UserInfo] ([UserID])
GO
ALTER TABLE [dbo].[Workitem] CHECK CONSTRAINT [FK_Workitem_UserInfo1]
GO
/****** Object:  ForeignKey [FK_Workitem_UserInfo2]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[Workitem]  WITH CHECK ADD  CONSTRAINT [FK_Workitem_UserInfo2] FOREIGN KEY([ModifyBy])
REFERENCES [dbo].[UserInfo] ([UserID])
GO
ALTER TABLE [dbo].[Workitem] CHECK CONSTRAINT [FK_Workitem_UserInfo2]
GO
/****** Object:  ForeignKey [FK_Workitem_Workitem]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[Workitem]  WITH CHECK ADD  CONSTRAINT [FK_Workitem_Workitem] FOREIGN KEY([WorkitemID])
REFERENCES [dbo].[Workitem] ([WorkitemID])
GO
ALTER TABLE [dbo].[Workitem] CHECK CONSTRAINT [FK_Workitem_Workitem]
GO
/****** Object:  ForeignKey [FK_WorkitemRegistration_UserInfo]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[WorkitemRegistration]  WITH CHECK ADD  CONSTRAINT [FK_WorkitemRegistration_UserInfo] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfo] ([UserID])
GO
ALTER TABLE [dbo].[WorkitemRegistration] CHECK CONSTRAINT [FK_WorkitemRegistration_UserInfo]
GO
/****** Object:  ForeignKey [FK_WorkitemRegistration_Workitem]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[WorkitemRegistration]  WITH CHECK ADD  CONSTRAINT [FK_WorkitemRegistration_Workitem] FOREIGN KEY([WorkitemID])
REFERENCES [dbo].[Workitem] ([WorkitemID])
GO
ALTER TABLE [dbo].[WorkitemRegistration] CHECK CONSTRAINT [FK_WorkitemRegistration_Workitem]
GO
/****** Object:  ForeignKey [FK_WorkitemHistory_UserInfo]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[WorkitemHistory]  WITH CHECK ADD  CONSTRAINT [FK_WorkitemHistory_UserInfo] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[UserInfo] ([UserID])
GO
ALTER TABLE [dbo].[WorkitemHistory] CHECK CONSTRAINT [FK_WorkitemHistory_UserInfo]
GO
/****** Object:  ForeignKey [FK_WorkitemHistory_Workitem]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[WorkitemHistory]  WITH CHECK ADD  CONSTRAINT [FK_WorkitemHistory_Workitem] FOREIGN KEY([WorkitemID])
REFERENCES [dbo].[Workitem] ([WorkitemID])
GO
ALTER TABLE [dbo].[WorkitemHistory] CHECK CONSTRAINT [FK_WorkitemHistory_Workitem]
GO
/****** Object:  ForeignKey [FK_WorkitemHistory_WorkitemStatus]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[WorkitemHistory]  WITH CHECK ADD  CONSTRAINT [FK_WorkitemHistory_WorkitemStatus] FOREIGN KEY([WorkitemStatusID])
REFERENCES [dbo].[WorkitemStatus] ([WorkitemStatusID])
GO
ALTER TABLE [dbo].[WorkitemHistory] CHECK CONSTRAINT [FK_WorkitemHistory_WorkitemStatus]
GO
/****** Object:  ForeignKey [FK_WorkitemDistribution_Team]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[WorkitemDistribution]  WITH CHECK ADD  CONSTRAINT [FK_WorkitemDistribution_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO
ALTER TABLE [dbo].[WorkitemDistribution] CHECK CONSTRAINT [FK_WorkitemDistribution_Team]
GO
/****** Object:  ForeignKey [FK_WorkitemDistribution_UserInfo]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[WorkitemDistribution]  WITH CHECK ADD  CONSTRAINT [FK_WorkitemDistribution_UserInfo] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfo] ([UserID])
GO
ALTER TABLE [dbo].[WorkitemDistribution] CHECK CONSTRAINT [FK_WorkitemDistribution_UserInfo]
GO
/****** Object:  ForeignKey [FK_WorkitemDistribution_Workitem]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[WorkitemDistribution]  WITH CHECK ADD  CONSTRAINT [FK_WorkitemDistribution_Workitem] FOREIGN KEY([WorkitemID])
REFERENCES [dbo].[Workitem] ([WorkitemID])
GO
ALTER TABLE [dbo].[WorkitemDistribution] CHECK CONSTRAINT [FK_WorkitemDistribution_Workitem]
GO
/****** Object:  ForeignKey [FK_WorkItemAssignment_UserInfo]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[WorkItemAssignment]  WITH CHECK ADD  CONSTRAINT [FK_WorkItemAssignment_UserInfo] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfo] ([UserID])
GO
ALTER TABLE [dbo].[WorkItemAssignment] CHECK CONSTRAINT [FK_WorkItemAssignment_UserInfo]
GO
/****** Object:  ForeignKey [FK_WorkItemAssignment_Workitem]    Script Date: 04/10/2016 21:15:20 ******/
ALTER TABLE [dbo].[WorkItemAssignment]  WITH CHECK ADD  CONSTRAINT [FK_WorkItemAssignment_Workitem] FOREIGN KEY([WorkItemID])
REFERENCES [dbo].[Workitem] ([WorkitemID])
GO
ALTER TABLE [dbo].[WorkItemAssignment] CHECK CONSTRAINT [FK_WorkItemAssignment_Workitem]
GO
