USE [master]
GO
/****** Object:  Database [UniversityManagementDB]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  Table [dbo].[Course]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  Table [dbo].[RoomAllocate]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  View [dbo].[ClassScheduleView]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  Table [dbo].[CourseAssigned]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  Table [dbo].[Semester]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  Table [dbo].[Teacher]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  View [dbo].[CourseStatisticsView]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  Table [dbo].[EnrollCourse]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  View [dbo].[StudentCourseView]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  Table [dbo].[StudentResult]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  View [dbo].[StudentResultView]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2/24/2021 1:49:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2/24/2021 1:49:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2/24/2021 1:49:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2/24/2021 1:49:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2/24/2021 1:49:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2/24/2021 1:49:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  Table [dbo].[Designation]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  Table [dbo].[Grade]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  Table [dbo].[Room]    Script Date: 2/24/2021 1:49:26 PM ******/
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
/****** Object:  Table [dbo].[Student]    Script Date: 2/24/2021 1:49:26 PM ******/
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
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202102240741459_InitialCreate', N'UniversitySystemMvcApp.Models.ApplicationDbContext', 0x1F8B0800000000000400DD5CDB6EDC36107D2FD07F10F4D416CECA9726488DDD14CEDA6E8DC617649DA06F0157E2AE85489422518E8D225FD6877E527FA14389BAF1A2CBAEBCBB2E0A145E717866381C7286C361FEFDFB9FF1AF0FBE67DCE328760332310F46FBA681891D382E594ECC842E5EBC367F7DF3FD77E333C77F303EE674478C0E7A927862DE511A1E5B566CDF611FC523DFB5A3200E16746407BE859CC03ADCDFFFC53A38B0304098806518E3F709A1AE8FD31FF0731A101B873441DE65E0602FE6DFA16596A21A57C8C771886C3C313F103715973ECE1E638AFDCB7BFB240C475947D338F15C0442CDB0B7300D4448401105918F3FC47846A3802C67217C40DEED6388816E81BC18F3A11C97E45D47B57FC84665951D73283B8969E0F7043C38E26AB2C4EE2B29DB2CD4088A3C0385D34736EA549913F3C2C1E9A7F781070A10191E4FBD88114FCCCB82C5491C5E613ACA3B8E32C8F308E0BE06D1E7511571CFE8DC6FAF30ABC3D13EFB6FCF98261E4D223C2138A111F2F68C9B64EEB9F61FF8F136F88CC9E4E860BE387AFDF215728E5EFD8C8F5E56470A6305BADA07F8741305218E4036BC28C66F1A56BD9F25762CBA55FA645A015B8215621A97E8E11D264B7A076BE7F0B5699CBB0FD8C9BF70E3028B8505059D6894C0CFABC4F3D0DCC345BBD5C893FDBF81EBE1CB578370BD42F7EE329D7A813F2C9C08D6D57BECA5ADF19D1B66CBAB36DF9F38D97914F8EC77DDBEB2D64FB320896C3698404B728BA225A675E9C65669BC9D4C9A410D6FD639EAEE9B369354366F25291BD02A2B2167B1E9D590CBFBB47C3B5B1C781E98BCD4B498469A0CAED16F8D04A03D434D5E1AD44157832230D0FFF3FE78E623D71B6083ECC005C294851BF9B818E5DB00CC1191DE32DFA03886FDC1F91DC5770DA2C39F03883EC37612313BA2C80F9F9CDBCD5D40F055E2CFD96AD81CAFC1A6E6F66B708E6C1A446784F55A1BEF5D607F0E127A469C5344F1076AE780ECE7ADEB770718449C13DBC6717C0EC68C9D690051780E7841E8D1616F38B6576D3B40997AC8F5D5118AB0AB7ECA49CB28454D21452A1A3255B4D224EABB60E9926EA2E6A47A51338A565139595F511958374939A55ED094A055CE8C6AB0F82F9DA1E103C01476F723C0F59CB76E2FA8A871063B24FE0D131CC136E6DC204A7144CA19E8B26F6C235848A78F317D72DF9472FA88BC6468562BAD867413187E35A4B0BBBF1A5231E1F3BDEBB0A8A4C3B1282706F84EF4EA1357FB9A1324DBF472A80D73D3CC37B307E896CB491C07B69BAE0245428CA733EAF2430C67B4E736B2D188F911181818BACB5C1E7C81B199A2515D9353EC618A8D133B4B184E516C234756230CC8E92158EE511582957992BA703F493CC1D271C43A2176088A61A5BA84CACBC225B61B22AF554B42CF8E2E8C8DBDE021B69CE21013C6B055135D98ABD3224C80828F30296D1A1A5B158B6B36444DD4AA9BF3B610B69C77295BB1119B6C899D3576C9E3B72731CC668D6DC0389B55D245006D8A6F1B06CACF2A5D0D403CB8EC9A810A27268D81F2906A23065AD7D8160CB4AE926767A0D911B5EBFC0BE7D55D33CFFA4179F36EBD515D5BB0CD9A3E76CC34B3D813FA50E88123D93C4FE7AC113F50C5E10CE4E4E7B39887BAA28930F019A6F5944D19EF2AE350AB194434A226C0D2D05A40F9E5A004242DA81EC2E5B9BC46E97814D10336CFBB35C2F2BD5F80ADD8808C5DBD24AD10EAAF5245E3EC74FA284656588364E49D0E0B151C8541889B577DE01D94A2CBCBCA8AE9120BF789862B03E393D1A0A096C855A3A47C30836B2937CD762DA902B23E21D95A5A12C2278D96F2C10CAE256EA3ED4A5204053DC282B5545477E1032DB63CD351789BA26D6C656554FCC3D8D2D45B8D2F5118BA6459A9BFE25F8C59567C357D31EB5F8AE46718961D2B2A920A690B4E3488D0120BADC01A243D77A3989E228AE688E579A68E2F91297DAB66FBCF5956DDA73C89B91FC8A9D9DFDCAD355EE9D7DCAE1C9770B87318ACCF829B34A3AE300575778395C6210F458A24FE34F0129FE8632D7DEFEC2AAFDA3FFB22238C2D417E299692142745BCF559E83447F2FA187EBE8AA866F539D343E8349FC7A455DDEBE2543D4A9EB6AAA2E852595B9B435D78B3EABC894164FF696B45789AD5C62B57AA00FC534F8C4AF183045669EB8E5AAF4FA962D65BBA230A45285548A1A98794D552939A90D58695F0341A555374E720179754D1E5D6EEC88A32932AB4A279056C85CC625B775445254A1558D1DC1DBB2C4B11F7D31DF667DAA3CD100E2D3B08AFE7D134184FB3390EE3102BF7FD55A0CAE79E58FC465F02E3DF77D2B0B4A7C1210C2B4B85AC67581A0CFD7E54BB34AF6F478D37FD7ACCDA4D786DCB6FAA04D0E3F533DF273512E95C289214DC8BF3A1700E1CF33359FBE31CE99096919846AE4670F7A9418D18C168F6C59B7A2E669B7B4E708988BBC031CDAA3FCCC3FD8343E151CFEE3CB0B1E2D8F114675ADD2B9BFA9C6DA0908BDCA3C8BE43915C56B1C623941254CA585F10073F4CCCBFD25EC769F283FD957EDE332E62D856BE24D0701B25D8F82697890E5394DFE1194821E8B767F1BEA2BBCA2FFEFC9475DD33AE23584EC7C6BEA0E855A6BFFEEAA2973459D735A459F92DC6F35D6DB5270D4A5461B5ACFE8261EED2415E2FE452FEE0A3871FFB8AA67CA1B016A2E215C2507883A850F7CA60152CED0B03077ED2F48541BFC1AA5F1CAC229AF6B5814BFA83896F0DBA6F4379CF2DFA21C5D969135B52AAE7D65AEDB50A37B7ED9BA492EEB516BA5CB6DD036ED0D2ECF542946756F23C98EB5454340F86BD4DBB7FF232E65DA95C2E83F6ED162C6FB246B9E1C6E97F559ABC03C5748AE2A0ED17206FDAD674C9E01DAFE2EC5766BC63C6C6DDFCF68B89376D6CBA04F18E1B5BAF92E11DB3B56DF9CF2D5B5A6717BAF50260B9964973A9A3CA22B715F866297738FECF0330822CA2CCDE65AA2BCA9AAA615B1896247AA6FA523691B1B47024BE124533DB7E63E50EBF71B09CA699ADA600B48937DFFF1B79739A66DE9AB2CA6D94262B0B1B55E5E22DFB58537DD5732A45AE8DA4A5F2BD2D666DBCA17F4E95C78328A5B67A34B7CBCFA7D07810950CB9747A1416CB17C5E03B2BFFD623F8EFD85D9610EC5F7E24D8AE79CD82E6822C82DC790B12E5244286E61253E4804B3D89A8BB4036856696804E1F96A7493D760D32C7CE05B94E6898501832F6E75E2DE1C5828026FE69F5745DE6F175C87EC5430C01C47459E2FE9ABC4D5CCF29E43E57E48434102CBAE0E95E369794A57D978F05D255403A0271F51541D12DF6430FC0E26B3243F77815D9C0FCDEE125B21FCB0CA00EA47D22EA6A1F9FBA6819213FE618657FF80936ECF80F6FFE0325B46661F2540000, N'6.2.0-61023')
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'8394641e-ac7d-4e22-8c60-9728649cc2d1', N'md.mohiiuddiin@gmail.com', 0, N'AF2bqF8x1Eoi6KReYYC9q8Eh9Kb3eWYIcplTRRc+gvfTg/Y9GaXv31VPmVErOll3jw==', N'677379f9-0f03-4794-bdff-b8d69c9f7f95', NULL, 0, 0, NULL, 1, 0, N'md.mohiiuddiin@gmail.com')
GO
INSERT [dbo].[Course] ([Code], [DepartmentCode], [SemesterId], [Name], [Credit], [Description], [Flag]) VALUES (N'CSE111', N'CSE', 1, N'Data Struc', CAST(3.00 AS Decimal(18, 2)), N'data steyeeu', 0)
INSERT [dbo].[Course] ([Code], [DepartmentCode], [SemesterId], [Name], [Credit], [Description], [Flag]) VALUES (N'CSE112', N'CSE', 1, N'C prog', CAST(3.00 AS Decimal(18, 2)), N'c steyeeu', 0)
INSERT [dbo].[Course] ([Code], [DepartmentCode], [SemesterId], [Name], [Credit], [Description], [Flag]) VALUES (N'CSE113', N'CSE', 1, N'Java prog', CAST(3.00 AS Decimal(18, 2)), N'no description', 0)
INSERT [dbo].[Course] ([Code], [DepartmentCode], [SemesterId], [Name], [Credit], [Description], [Flag]) VALUES (N'CSE114', N'CSE', 1, N'C sharp prog', CAST(3.00 AS Decimal(18, 2)), N'no description', 0)
INSERT [dbo].[Course] ([Code], [DepartmentCode], [SemesterId], [Name], [Credit], [Description], [Flag]) VALUES (N'CSE222', N'CSE', 8, N'Sub222', CAST(3.00 AS Decimal(18, 2)), N'dddddddd', 0)
GO
SET IDENTITY_INSERT [dbo].[CourseAssigned] ON 

INSERT [dbo].[CourseAssigned] ([Id], [DepartmentCode], [TeacherId], [CourseCode], [Flag]) VALUES (1, N'CSE', 1, N'CSE111', 0)
INSERT [dbo].[CourseAssigned] ([Id], [DepartmentCode], [TeacherId], [CourseCode], [Flag]) VALUES (2, N'CSE', 1, N'CSE112', 0)
INSERT [dbo].[CourseAssigned] ([Id], [DepartmentCode], [TeacherId], [CourseCode], [Flag]) VALUES (3, N'CSE', 1, N'CSE113', 0)
INSERT [dbo].[CourseAssigned] ([Id], [DepartmentCode], [TeacherId], [CourseCode], [Flag]) VALUES (4, N'CSE', 1, N'CSE114', 0)
INSERT [dbo].[CourseAssigned] ([Id], [DepartmentCode], [TeacherId], [CourseCode], [Flag]) VALUES (5, N'CSE', 5, N'CSE222', 0)
SET IDENTITY_INSERT [dbo].[CourseAssigned] OFF
GO
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'BBA', N'Business and Bachelor Administration')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'CE', N'Civil Engineering')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'CSE', N'Computer Science and Engineering')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'CSE111', N'dddd')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'Dep1', N'Department1')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'Dep2', N'Department2')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'Dep3', N'Department3')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'Dep4', N'Department4')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'Dep5', N'Department5')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'ELL', N'English and Literature')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'ETE', N'ETE')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'ME', N'Mechanical Engineering')
INSERT [dbo].[Department] ([Code], [Name]) VALUES (N'TE', N'Textile Engineering')
GO
SET IDENTITY_INSERT [dbo].[Designation] ON 

INSERT [dbo].[Designation] ([Id], [Name]) VALUES (1, N'Lecturer')
INSERT [dbo].[Designation] ([Id], [Name]) VALUES (2, N'Professor')
INSERT [dbo].[Designation] ([Id], [Name]) VALUES (3, N'Assis Prof')
INSERT [dbo].[Designation] ([Id], [Name]) VALUES (4, N'Dean')
SET IDENTITY_INSERT [dbo].[Designation] OFF
GO
SET IDENTITY_INSERT [dbo].[EnrollCourse] ON 

INSERT [dbo].[EnrollCourse] ([Id], [StudentId], [CourseCode], [Date], [Flag]) VALUES (1, 1, N'CSE111', CAST(N'2020-11-24' AS Date), 1)
INSERT [dbo].[EnrollCourse] ([Id], [StudentId], [CourseCode], [Date], [Flag]) VALUES (2, 2, N'CSE112', CAST(N'2020-11-24' AS Date), 1)
INSERT [dbo].[EnrollCourse] ([Id], [StudentId], [CourseCode], [Date], [Flag]) VALUES (3, 1, N'CSE112', CAST(N'2020-11-24' AS Date), 1)
INSERT [dbo].[EnrollCourse] ([Id], [StudentId], [CourseCode], [Date], [Flag]) VALUES (4, 1, N'CSE113', CAST(N'2020-11-24' AS Date), 1)
INSERT [dbo].[EnrollCourse] ([Id], [StudentId], [CourseCode], [Date], [Flag]) VALUES (5, 1, N'CSE114', CAST(N'2020-11-24' AS Date), 1)
SET IDENTITY_INSERT [dbo].[EnrollCourse] OFF
GO
INSERT [dbo].[Grade] ([Grade]) VALUES (N'A')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'A+')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'A-')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'B')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'B+')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'B-')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'C')
INSERT [dbo].[Grade] ([Grade]) VALUES (N'F')
GO
INSERT [dbo].[Room] ([RoomNo]) VALUES (101)
INSERT [dbo].[Room] ([RoomNo]) VALUES (102)
INSERT [dbo].[Room] ([RoomNo]) VALUES (103)
INSERT [dbo].[Room] ([RoomNo]) VALUES (104)
INSERT [dbo].[Room] ([RoomNo]) VALUES (105)
INSERT [dbo].[Room] ([RoomNo]) VALUES (106)
INSERT [dbo].[Room] ([RoomNo]) VALUES (107)
GO
SET IDENTITY_INSERT [dbo].[RoomAllocate] ON 

INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (1, N'CSE', N'CSE111', 101, N'Saturday', CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 0)
INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (2, N'CSE', N'CSE112', 102, N'Saturday', CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 0)
INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (3, N'CSE', N'CSE113', 103, N'Saturday', CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 0)
INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (4, N'CSE', N'CSE113', 104, N'Saturday', CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 0)
INSERT [dbo].[RoomAllocate] ([Id], [DepartmentCode], [CourseCode], [RoomNo], [Day], [From], [To], [Flag]) VALUES (5, N'CSE', N'CSE114', 102, N'Saturday', CAST(N'11:30:00' AS Time), CAST(N'12:30:00' AS Time), 0)
SET IDENTITY_INSERT [dbo].[RoomAllocate] OFF
GO
SET IDENTITY_INSERT [dbo].[Semester] ON 

INSERT [dbo].[Semester] ([Id], [Name]) VALUES (1, N'1st')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (2, N'2nd')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (3, N'3rd')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (4, N'4th')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (5, N'5th')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (6, N'6th')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (7, N'7th')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (8, N'8th')
SET IDENTITY_INSERT [dbo].[Semester] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (1, N'CSE-2020-001', N'Mohiuddin', N'md.mohiiuddiin@gmail.com', N'01818031214', CAST(N'2020-11-24' AS Date), N'ddddddddddd', N'CSE', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (2, N'CSE-2020-002', N'Mohiuddin1', N'md.mohiiuddiin01@gmail.com', N'01818031211', CAST(N'2020-11-24' AS Date), N'ddddddddddd', N'CSE', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (3, N'CSE-2020-003', N'Mohiuddin3', N'md.mohiiuddiin03@gmail.com', N'01818031213', CAST(N'2020-11-24' AS Date), N'ddddddddddd', N'CSE', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (4, N'CSE-2020-004', N'Mohiuddin5', N'md.mohiiuddiin5@gmail.com', N'02154869874', CAST(N'2020-10-07' AS Date), N'ddddddddddd', N'CSE', 1)
INSERT [dbo].[Student] ([Id], [RegNo], [Name], [Email], [ContactNo], [Date], [Address], [DepartmentCode], [Flag]) VALUES (5, N'BBA-2020-001', N'Mohiuddin6', N'md.mohiiuddiin6@gmail.com', N'00000000005', CAST(N'2020-10-07' AS Date), N'ddddddddddd', N'BBA', 1)
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentResult] ON 

INSERT [dbo].[StudentResult] ([Id], [StudentId], [CourseCode], [GradeCode], [Flag]) VALUES (1, 1, N'CSE111', N'A', 1)
INSERT [dbo].[StudentResult] ([Id], [StudentId], [CourseCode], [GradeCode], [Flag]) VALUES (2, 1, N'CSE112', N'A+', 1)
INSERT [dbo].[StudentResult] ([Id], [StudentId], [CourseCode], [GradeCode], [Flag]) VALUES (3, 1, N'CSE113', N'A-', 1)
INSERT [dbo].[StudentResult] ([Id], [StudentId], [CourseCode], [GradeCode], [Flag]) VALUES (4, 1, N'CSE114', N'A-', 1)
SET IDENTITY_INSERT [dbo].[StudentResult] OFF
GO
SET IDENTITY_INSERT [dbo].[Teacher] ON 

INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [DesignationId], [DepartmentCode], [MaximumCredit], [Flag], [CreditTaken]) VALUES (1, N'Teacher1', N'Teacher1', N'mr.terminator.01@gmail.com', N'00000000000', 1, N'CSE', CAST(12.00 AS Decimal(18, 2)), 1, CAST(12.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [DesignationId], [DepartmentCode], [MaximumCredit], [Flag], [CreditTaken]) VALUES (2, N'Teacher2', N'Teacher2', N'mr.terminator.02@gmail.com', N'00000000000', 1, N'CSE', CAST(12.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [DesignationId], [DepartmentCode], [MaximumCredit], [Flag], [CreditTaken]) VALUES (3, N'Teacher3', N'Teacher3', N'mr.terminator.03@gmail.com', N'00000000000', 1, N'CSE', CAST(12.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [DesignationId], [DepartmentCode], [MaximumCredit], [Flag], [CreditTaken]) VALUES (4, N'Teacher4', N'Teacher4', N'mr.terminator.04@gmail.com', N'00000000000', 1, N'CSE', CAST(12.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [DesignationId], [DepartmentCode], [MaximumCredit], [Flag], [CreditTaken]) VALUES (5, N'Teacher5', N'Tssss', N'mr.terminator.05@gmail.com', N'01818031217', 3, N'CSE', CAST(12.00 AS Decimal(18, 2)), 1, CAST(3.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Teacher] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 2/24/2021 1:49:27 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 2/24/2021 1:49:27 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 2/24/2021 1:49:27 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RoleId]    Script Date: 2/24/2021 1:49:27 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 2/24/2021 1:49:27 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 2/24/2021 1:49:27 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
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
