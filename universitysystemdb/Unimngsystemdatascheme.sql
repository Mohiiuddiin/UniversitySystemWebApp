USE [master]
GO
/****** Object:  Database [UniversityManagementDB]    Script Date: 11/10/2020 12:25:37 PM ******/
CREATE DATABASE [UniversityManagementDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UniversityManagementDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\UniversityManagementDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'UniversityManagementDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\UniversityManagementDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [UniversityManagementDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UniversityManagementDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UniversityManagementDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UniversityManagementDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UniversityManagementDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [UniversityManagementDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UniversityManagementDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [UniversityManagementDB] SET  MULTI_USER 
GO
ALTER DATABASE [UniversityManagementDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UniversityManagementDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UniversityManagementDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UniversityManagementDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [UniversityManagementDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [UniversityManagementDB] SET QUERY_STORE = OFF
GO
USE [UniversityManagementDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [UniversityManagementDB]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[Code] [varchar](50) NOT NULL,
	[DepartmentCode] [varchar](50) NULL,
	[SemesterId] [int] NULL,
	[Name] [varchar](50) NULL,
	[Credit] [decimal](18, 2) NULL,
	[Description] [varchar](100) NULL,
	[Flag] [int] NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomAllocate]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomAllocate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentCode] [varchar](50) NULL,
	[CourseCode] [varchar](50) NULL,
	[RoomNo] [int] NULL,
	[Day] [varchar](50) NULL,
	[From] [time](7) NULL,
	[To] [time](7) NULL,
	[Flag] [int] NULL,
 CONSTRAINT [PK_RoomAllocate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ClassScheduleView]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ClassScheduleView]
AS
SELECT        dbo.Course.Code AS CourseCode, dbo.Course.Name AS CourseName, dbo.Course.Flag, dbo.RoomAllocate.RoomNo, dbo.RoomAllocate.Day AS RoomDay, dbo.RoomAllocate.[From] AS FromTime, 
                         dbo.RoomAllocate.[To] AS ToTime, dbo.Course.DepartmentCode
FROM            dbo.Course LEFT OUTER JOIN
                         dbo.RoomAllocate ON dbo.Course.Code = dbo.RoomAllocate.CourseCode

GO
/****** Object:  Table [dbo].[CourseAssigned]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseAssigned](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentCode] [varchar](50) NULL,
	[TeacherId] [int] NULL,
	[CourseCode] [varchar](50) NULL,
	[Flag] [int] NULL,
 CONSTRAINT [PK_CourseAssigned] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Semester]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Semester](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_Semester] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[ContactNo] [varchar](50) NULL,
	[DesignationId] [int] NULL,
	[DepartmentCode] [varchar](50) NULL,
	[MaximumCredit] [decimal](18, 2) NULL,
	[Flag] [int] NULL,
	[CreditTaken] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CourseStatisticsView]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CourseStatisticsView] AS
SELECT        dbo.Course.Code AS CourseCode, dbo.Course.DepartmentCode, dbo.Course.Name AS CourseName, dbo.Course.SemesterId, dbo.Course.Credit, dbo.Course.Description, dbo.Course.Flag, dbo.Semester.Name AS SemesterName, 
                          dbo.Teacher.Name AS TeacherName, dbo.Teacher.MaximumCredit
FROM            dbo.Course LEFT OUTER JOIN
dbo.CourseAssigned ON dbo.CourseAssigned.CourseCode = dbo.Course.Code
LEFT OUTER JOIN
                         dbo.Semester ON dbo.Course.SemesterId = dbo.Semester.Id 
                          LEFT OUTER JOIN
                         dbo.Teacher ON dbo.CourseAssigned.TeacherId = dbo.Teacher.Id
GO
/****** Object:  Table [dbo].[EnrollCourse]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnrollCourse](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NULL,
	[CourseCode] [varchar](50) NULL,
	[Date] [date] NULL,
	[Flag] [int] NULL,
 CONSTRAINT [PK_StudentRegister] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[StudentCourseView]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StudentCourseView]
AS
SELECT        dbo.EnrollCourse.Id AS StudentRegId, dbo.EnrollCourse.CourseCode, dbo.EnrollCourse.StudentId, dbo.EnrollCourse.Flag, dbo.Course.Name AS CourseName
FROM            dbo.EnrollCourse INNER JOIN
                         dbo.Course ON dbo.EnrollCourse.CourseCode = dbo.Course.Code
GO
/****** Object:  Table [dbo].[StudentResult]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentResult](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NULL,
	[CourseCode] [varchar](50) NULL,
	[GradeCode] [varchar](50) NULL,
	[Flag] [int] NULL,
 CONSTRAINT [PK_StudentResult] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[StudentResultView]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StudentResultView]
AS
SELECT        dbo.EnrollCourse.CourseCode, dbo.EnrollCourse.StudentId, dbo.Course.Name, dbo.StudentResult.GradeCode
FROM            dbo.EnrollCourse LEFT OUTER JOIN
                         dbo.StudentResult ON dbo.EnrollCourse.StudentId = dbo.StudentResult.StudentId INNER JOIN
                         dbo.Course ON dbo.EnrollCourse.CourseCode = dbo.Course.Code
GO
/****** Object:  Table [dbo].[Department]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Code] [varchar](50) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Designation]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Designation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_Designation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grade]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grade](
	[Grade] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED 
(
	[Grade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[RoomNo] [int] NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RoomNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 11/10/2020 12:25:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RegNo] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[ContactNo] [varchar](50) NULL,
	[Date] [date] NULL,
	[Address] [varchar](100) NULL,
	[DepartmentCode] [varchar](50) NULL,
	[Flag] [int] NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Course] ([Code], [DepartmentCode], [SemesterId], [Name], [Credit], [Description], [Flag]) VALUES (N'CCR207', N'CSE', 2, N'Data Structure', CAST(3.00 AS Decimal(18, 2)), N'Data Structure', 1)
INSERT [dbo].[Course] ([Code], [DepartmentCode], [SemesterId], [Name], [Credit], [Description], [Flag]) VALUES (N'CCR311', N'CSE', 2, N'Architecture', CAST(3.00 AS Decimal(18, 2)), N'Computer Architecture and Organization', 1)
INSERT [dbo].[Course] ([Code], [DepartmentCode], [SemesterId], [Name], [Credit], [Description], [Flag]) VALUES (N'CCR401', N'CSE', 2, N'Database Management System', CAST(3.00 AS Decimal(18, 2)), N'asdasd', 1)
INSERT [dbo].[Course] ([Code], [DepartmentCode], [SemesterId], [Name], [Credit], [Description], [Flag]) VALUES (N'CSE222', N'BBA', 1, N'ddddddd', CAST(3.00 AS Decimal(18, 2)), N'sssssss', 1)
INSERT [dbo].[Course] ([Code], [DepartmentCode], [SemesterId], [Name], [Credit], [Description], [Flag]) VALUES (N'CSE413', N'CSE', 4, N'Operating System', CAST(3.00 AS Decimal(18, 2)), N'OOP', 1)
INSERT [dbo].[Course] ([Code], [DepartmentCode], [SemesterId], [Name], [Credit], [Description], [Flag]) VALUES (N'EEE 101', N'EEE', 2, N'Electronics', CAST(3.00 AS Decimal(18, 2)), N'Electronics', 1)
GO
SET IDENTITY_INSERT [dbo].[CourseAssigned] ON 

INSERT [dbo].[CourseAssigned] ([Id], [DepartmentCode], [TeacherId], [CourseCode], [Flag]) VALUES (1, N'CSE', 1, N'CSE413', 0)
INSERT [dbo].[CourseAssigned] ([Id], [DepartmentCode], [TeacherId], [CourseCode], [Flag]) VALUES (1004, N'CSE', 2, N'CCR207', 0)
INSERT [dbo].[CourseAssigned] ([Id], [DepartmentCode], [TeacherId], [CourseCode], [Flag]) VALUES (2002, N'CSE', 1, N'CCR401', 0)
INSERT [dbo].[CourseAssigned] ([Id], [DepartmentCode], [TeacherId], [CourseCode], [Flag]) VALUES (2003, N'CSE', 4, N'CCR207', 1)
SET IDENTITY_INSERT [dbo].[CourseAssigned] OFF
GO
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'BBA', N'Bachelor of Business Administration')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'CEN', N'Civil Engineering')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'CSE', N'Computer Science and Engineering')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'CST', N'ddd')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'CSY', N'hhh')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'ddddd', N'dddd')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'EEE', N'Electrical and Electronic Engineering')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'ETE', N'Electrical and Telecommunication Engineering')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'HR111', N'HR')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'HR112', N'HS')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'HR113', N'Hrs')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'MPH11', N'MPH')
GO
SET IDENTITY_INSERT [dbo].[Designation] ON 

INSERT [dbo].[Designation] ([Id], [Name]) VALUES (1, N'Lecturer')
INSERT [dbo].[Designation] ([Id], [Name]) VALUES (2, N'Professor')
INSERT [dbo].[Designation] ([Id], [Name]) VALUES (3, N'Assistant Professor')
INSERT [dbo].[Designation] ([Id], [Name]) VALUES (4, N'Associate Professor')
SET IDENTITY_INSERT [dbo].[Designation] OFF
GO
SET IDENTITY_INSERT [dbo].[EnrollCourse] ON 

INSERT [dbo].[EnrollCourse] ([Id], [StudentId], [CourseCode], [Date], [Flag]) VALUES (1, 1002, N'CCR207', CAST(N'2018-12-13' AS Date), 1)
INSERT [dbo].[EnrollCourse] ([Id], [StudentId], [CourseCode], [Date], [Flag]) VALUES (2, 1003, N'CCR207', CAST(N'2018-12-19' AS Date), 1)
INSERT [dbo].[EnrollCourse] ([Id], [StudentId], [CourseCode], [Date], [Flag]) VALUES (3, 1004, N'CCR401', CAST(N'2018-12-19' AS Date), 1)
INSERT [dbo].[EnrollCourse] ([Id], [StudentId], [CourseCode], [Date], [Flag]) VALUES (4, 1002, N'CCR401', CAST(N'2018-12-20' AS Date), 1)
INSERT [dbo].[EnrollCourse] ([Id], [StudentId], [CourseCode], [Date], [Flag]) VALUES (5, 1002, N'CSE413', CAST(N'2018-12-20' AS Date), 1)
INSERT [dbo].[EnrollCourse] ([Id], [StudentId], [CourseCode], [Date], [Flag]) VALUES (6, 1003, N'CCR401', CAST(N'2020-11-26' AS Date), 1)
INSERT [dbo].[EnrollCourse] ([Id], [StudentId], [CourseCode], [Date], [Flag]) VALUES (7, 2017, N'CSE222', CAST(N'2020-10-29' AS Date), 1)
SET IDENTITY_INSERT [dbo].[EnrollCourse] OFF
GO
INSERT [dbo].[Grade] ([Grade]) VALUES (N'A')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'A+')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'A-')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'B')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'B+')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'B-')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'C')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'C+')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'C-')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'D')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'D+')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'D-')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'F')
GO
INSERT [dbo].[Room] ([RoomNo]) VALUES (2301)
INSERT [dbo].[Room] ([RoomNo]) VALUES (2302)
INSERT [dbo].[Room] ([RoomNo]) VALUES (3201)
INSERT [dbo].[Room] ([RoomNo]) VALUES (3202)
INSERT [dbo].[Room] ([RoomNo]) VALUES (3301)
INSERT [dbo].[Room] ([RoomNo]) VALUES (3302)
GO
SET IDENTITY_INSERT [dbo].[RoomAllocate] ON 

INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (1, N'CSE', N'CCR207', 2302, N'Monday', CAST(N'08:18:00' AS Time), CAST(N'10:18:00' AS Time), 0)
INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (2, N'CSE', N'CCR207', 2301, N'Sunday', CAST(N'10:10:00' AS Time), CAST(N'11:10:00' AS Time), 0)
INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (3, N'CSE', N'CCR207', 2301, N'Saturday', CAST(N'07:52:00' AS Time), CAST(N'08:51:00' AS Time), 0)
INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (4, N'BBA', N'CSE222', 2301, N'Saturday', CAST(N'20:53:00' AS Time), CAST(N'20:53:00' AS Time), 0)
INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (6, N'CSE', N'CCR401', 2301, N'Saturday', CAST(N'19:14:00' AS Time), CAST(N'20:14:00' AS Time), 0)
INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (7, N'BBA', N'CSE222', 3202, N'Saturday', CAST(N'19:14:00' AS Time), CAST(N'20:14:00' AS Time), 0)
INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (8, N'CSE', N'CSE413', 3301, N'Saturday', CAST(N'19:14:00' AS Time), CAST(N'19:14:00' AS Time), 0)
INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (9, N'CSE', N'CCR311', 2302, N'Sunday', CAST(N'20:17:00' AS Time), CAST(N'08:17:00' AS Time), 0)
INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (10, N'BBA', N'CSE222', 2301, N'Monday', CAST(N'20:17:00' AS Time), CAST(N'10:17:00' AS Time), 0)
INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (11, N'CSE', N'CSE413', 3302, N'Friday', CAST(N'22:34:00' AS Time), CAST(N'23:34:00' AS Time), 0)
SET IDENTITY_INSERT [dbo].[RoomAllocate] OFF
GO
SET IDENTITY_INSERT [dbo].[Semester] ON 

INSERT [dbo].[Semester] ([Id], [Name]) VALUES (1, N'First Semester')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (2, N'Second Semester')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (3, N'Third Semester')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (4, N'Fourth Semester')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (5, N'Fifth Semester')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (6, N'Sixth Semester')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (7, N'Seventh Semester')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (8, N'Eighth Semester')
SET IDENTITY_INSERT [dbo].[Semester] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (1002, N'CSE-2018-001', N'Anupia Barua', N'apb@dmail.com', N'0146843687', CAST(N'2018-12-16' AS Date), N'sdfgsdfs', N'CSE', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (1003, N'CSE-2018-002', N'Anupam Barua', N'apqwb@dmail.com', N'0146843687', CAST(N'2018-12-16' AS Date), N'sdfgsdfs', N'CSE', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (1004, N'CSE-2018-003', N'Anusree Barua', N'abc@abc.com', N'0146843687', CAST(N'2018-12-20' AS Date), N'fghfghfg', N'CSE', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (1005, N'CSE-2018-004', N'Xyz', N'xyz@gmail.com', N'0135698465', CAST(N'2018-12-27' AS Date), N'sdfsdfs', N'CSE', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2002, N'CSE-2018-005', N'Kallol Dhar', N'Kallol@gmail.com', N'413235', CAST(N'2018-12-16' AS Date), N'Coxsbazar', N'CSE', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2003, N'BBA-2020-001', N'Mohiuddin', N'md.mohiiuddiin@gmail.com', N'00000000000', CAST(N'2020-10-15' AS Date), N'aaaaaaaaaaaa', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2004, N'CSE-2020-001', N'ffffffffffffff', N'mr.terminator.01@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'ooooooooooooooooooooooooo', N'CSE', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2005, N'BBA-2020-002', N'Electronics', N'mr.terminator.061@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N';llllllllllllllllllllllllll', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2006, N'CSE-2020-002', N'CSE', N'mr.terllminator.01@gmail.com', N'00000000000', CAST(N'2020-10-19' AS Date), N'llllllllllllllllllllllllllllllll', N'CSE', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2007, N'BBA-2020-003', N'CSE111', N'mr.terminaltor.01@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'jjjjjjjjjjjjjjjjjjjjjjj', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2008, N'ETE-2020-001', N'dddd', N'mr.terminaktor.01@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'jjjjjjjjjjjjjjjjjjjjjj', N'ETE', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2009, N'BBA-2020-004', N'Electronics', N'md.mohiifuddiin@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'dddddddddddddd', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2010, N'CEN-2020-001', N'Electronics', N'md.mohiiudldiin@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'kkkkkkkkkkkkkkkkkkkkkkkk', N'CEN', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2011, N'BBA-2020-005', N'dddd', N'mr.termlllllllllllinator.01@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'llllllllllllllllllllllllllllll', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2012, N'BBA-2020-006', N'Electronics', N'mr.terminllator.01@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'jjjjjjjjjjjjjj', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2013, N'BBA-2020-007', N'dddd', N'mr.terminator.01m@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'kkkkkkkkkkkkkkk', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2014, N'CEN-2020-002', N'dddd', N'mr.terminathor.01m@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'kkkkkkkkkkkkkkk', N'CEN', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2015, N'BBA-2020-008', N'dddd', N'mr.terminaator.01@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'ffffffffffffffffffffff', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2016, N'BBA-2020-009', N'ddddd', N'mr.terminaadtor.01@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'ffffffffffffffffffffff', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2017, N'BBA-2020-010', N'dddd', N'mr.terminartor.01@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'ffffffffff', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2018, N'BBA-2020-011', N'dddd', N'mr.terminator.001@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'llllllllllllllllllllllllllllllllllllll', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2019, N'BBA-2020-012', N'dddd', N'mr.terminator.101@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'llllllllllllllllllllllllllll', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2020, N'BBA-2020-013', N'dddd', N'mr.terminator.201@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'kkkkkkkkkkkkkkkkkk', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2021, N'BBA-2020-014', N'Electronics', N'md.mohiiuddiin1@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2022, N'BBA-2020-015', N'dddd', N'mr.terminator.011@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'ddd', N'BBA', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (3003, N'HR112-2020-001', N'ddddddd', N'mr.terminator.03@gmail.com', N'00000000002', CAST(N'2020-11-12' AS Date), N'ddddddddddd', N'HR112', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (3004, N'CSE-2020-003', N'Mohiuddin11', N'md.mohiiuddiin11@gmail.com', N'00000000000', CAST(N'2020-10-07' AS Date), N'ddddddddddd', N'CSE', 1)
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentResult] ON 

INSERT [dbo].[StudentResult] ([Id], [StudentId], [CourseCode], [GradeCode], [Flag]) VALUES (5, 1002, N'CCR207', N'A+', 1)
INSERT [dbo].[StudentResult] ([Id], [StudentId], [CourseCode], [GradeCode], [Flag]) VALUES (6, 1003, N'CCR207', N'A-', 1)
INSERT [dbo].[StudentResult] ([Id], [StudentId], [CourseCode], [GradeCode], [Flag]) VALUES (7, 1002, N'CCR401', N'A+', 1)
SET IDENTITY_INSERT [dbo].[StudentResult] OFF
GO
SET IDENTITY_INSERT [dbo].[Teacher] ON 

INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [DesignationId], [DepartmentCode], [MaximumCredit], [Flag], [CreditTaken]) VALUES (1, N'Risul Islam Rasel', N'Chittagong', N'risul@gmail.com', N'017123546', 4, N'CSE', CAST(14.00 AS Decimal(18, 2)), 1, CAST(3.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [DesignationId], [DepartmentCode], [MaximumCredit], [Flag], [CreditTaken]) VALUES (2, N'Habibur Rahman', N'Chittagong', N'habib@gmail.com', N'0156458754', 1, N'CSE', CAST(14.00 AS Decimal(18, 2)), 1, CAST(3.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [DesignationId], [DepartmentCode], [MaximumCredit], [Flag], [CreditTaken]) VALUES (3, N'Sadik Hasan', N'Chittagong', N'sadik@gmail.com', N'01920777592', 3, N'CEN', CAST(15.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [DesignationId], [DepartmentCode], [MaximumCredit], [Flag], [CreditTaken]) VALUES (4, N'ddjhdkkd', N'ddjhdkkd ddjdk', N'mr.terminato1@gmail.com', N'00000000000', 2, N'CSE', CAST(12.00 AS Decimal(18, 2)), 1, CAST(3.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Teacher] OFF
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Department] FOREIGN KEY([DepartmentCode])
REFERENCES [dbo].[Department] ([Code])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Department]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Semester] FOREIGN KEY([SemesterId])
REFERENCES [dbo].[Semester] ([Id])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Semester]
GO
ALTER TABLE [dbo].[CourseAssigned]  WITH CHECK ADD  CONSTRAINT [FK_CourseAssigned_Course] FOREIGN KEY([CourseCode])
REFERENCES [dbo].[Course] ([Code])
GO
ALTER TABLE [dbo].[CourseAssigned] CHECK CONSTRAINT [FK_CourseAssigned_Course]
GO
ALTER TABLE [dbo].[CourseAssigned]  WITH CHECK ADD  CONSTRAINT [FK_CourseAssigned_Department] FOREIGN KEY([DepartmentCode])
REFERENCES [dbo].[Department] ([Code])
GO
ALTER TABLE [dbo].[CourseAssigned] CHECK CONSTRAINT [FK_CourseAssigned_Department]
GO
ALTER TABLE [dbo].[CourseAssigned]  WITH CHECK ADD  CONSTRAINT [FK_CourseAssigned_Teacher] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[Teacher] ([Id])
GO
ALTER TABLE [dbo].[CourseAssigned] CHECK CONSTRAINT [FK_CourseAssigned_Teacher]
GO
ALTER TABLE [dbo].[EnrollCourse]  WITH CHECK ADD  CONSTRAINT [FK_StudentRegister_Course] FOREIGN KEY([CourseCode])
REFERENCES [dbo].[Course] ([Code])
GO
ALTER TABLE [dbo].[EnrollCourse] CHECK CONSTRAINT [FK_StudentRegister_Course]
GO
ALTER TABLE [dbo].[EnrollCourse]  WITH CHECK ADD  CONSTRAINT [FK_StudentRegister_Student] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([Id])
GO
ALTER TABLE [dbo].[EnrollCourse] CHECK CONSTRAINT [FK_StudentRegister_Student]
GO
ALTER TABLE [dbo].[RoomAllocate]  WITH CHECK ADD  CONSTRAINT [FK_RoomAllocate_Course] FOREIGN KEY([CourseCode])
REFERENCES [dbo].[Course] ([Code])
GO
ALTER TABLE [dbo].[RoomAllocate] CHECK CONSTRAINT [FK_RoomAllocate_Course]
GO
ALTER TABLE [dbo].[RoomAllocate]  WITH CHECK ADD  CONSTRAINT [FK_RoomAllocate_Department] FOREIGN KEY([DepartmentCode])
REFERENCES [dbo].[Department] ([Code])
GO
ALTER TABLE [dbo].[RoomAllocate] CHECK CONSTRAINT [FK_RoomAllocate_Department]
GO
ALTER TABLE [dbo].[RoomAllocate]  WITH CHECK ADD  CONSTRAINT [FK_RoomAllocate_Room] FOREIGN KEY([RoomNo])
REFERENCES [dbo].[Room] ([RoomNo])
GO
ALTER TABLE [dbo].[RoomAllocate] CHECK CONSTRAINT [FK_RoomAllocate_Room]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Department] FOREIGN KEY([DepartmentCode])
REFERENCES [dbo].[Department] ([Code])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Department]
GO
ALTER TABLE [dbo].[StudentResult]  WITH CHECK ADD  CONSTRAINT [FK_StudentResult_Course] FOREIGN KEY([CourseCode])
REFERENCES [dbo].[Course] ([Code])
GO
ALTER TABLE [dbo].[StudentResult] CHECK CONSTRAINT [FK_StudentResult_Course]
GO
ALTER TABLE [dbo].[StudentResult]  WITH CHECK ADD  CONSTRAINT [FK_StudentResult_Grade] FOREIGN KEY([GradeCode])
REFERENCES [dbo].[Grade] ([Grade])
GO
ALTER TABLE [dbo].[StudentResult] CHECK CONSTRAINT [FK_StudentResult_Grade]
GO
ALTER TABLE [dbo].[StudentResult]  WITH CHECK ADD  CONSTRAINT [FK_StudentResult_Student] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([Id])
GO
ALTER TABLE [dbo].[StudentResult] CHECK CONSTRAINT [FK_StudentResult_Student]
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD  CONSTRAINT [Teacher_Department] FOREIGN KEY([DepartmentCode])
REFERENCES [dbo].[Department] ([Code])
GO
ALTER TABLE [dbo].[Teacher] CHECK CONSTRAINT [Teacher_Department]
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD  CONSTRAINT [Teacher_Designation] FOREIGN KEY([DesignationId])
REFERENCES [dbo].[Designation] ([Id])
GO
ALTER TABLE [dbo].[Teacher] CHECK CONSTRAINT [Teacher_Designation]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Course"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RoomAllocate"
            Begin Extent = 
               Top = 6
               Left = 256
               Bottom = 136
               Right = 436
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ClassScheduleView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ClassScheduleView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Course"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 426
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EnrollCourse"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StudentCourseView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StudentCourseView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "StudentResult"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Course"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EnrollCourse"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StudentResultView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StudentResultView'
GO
USE [master]
GO
ALTER DATABASE [UniversityManagementDB] SET  READ_WRITE 
GO
