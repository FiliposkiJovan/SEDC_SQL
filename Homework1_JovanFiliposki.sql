CREATE DATABASE [SEDCACADEMY]

USE[SEDCACADEMY]

CREATE TABLE [Student]
(
	Id INT IDENTITY(1,1) NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DATE NOT NULL,
	EnrolledDate DATE NOT NULL,
	Gander NVARCHAR(50) NOT NULL,
	NationalIdNumber NVARCHAR(50) NOT NULL,
	StudentCardNumber NVARCHAR(50) NOT NULL,
	CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED ( Id ASC )
)

CREATE TABLE [Teacher]
(
	Id SMALLINT IDENTITY(1,1) NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DATE NOT NULL,
	AcademicRank NVARCHAR(50) NOT NULL,
	HireDate DATE NOT NULL,
	CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED ( Id ASC )
)

CREATE TABLE [Grade]
(
	Id INT IDENTITY(1,1) NOT NULL,
	StudentId INT NOT NULL,
	CourseId INT NOT NULL,
	TeacherId INT NOT NULL,
	Grade INT NOT NULL,
	Comment NVARCHAR(250) NOT NULL,
	CreatedDate DATETIME NOT NULL,
	CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED ( Id ASC )
)

CREATE TABLE [Course]
(
	Id SMALLINT IDENTITY(1,1) NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	Credit INT NOT NULL,
	AcademicYear INT NOT NULL,
	Semester INT NOT NULL,
	CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED ( Id ASC )
)

CREATE TABLE [GradeDetails]
(
	Id INT IDENTITY(1,1) NOT NULL,
	GradeId INT NOT NULL,
	AchivmentTypeId INT NOT NULL,
	AchivmentPoints INT NOT NULL,
	AchivmentMaxPoints INT NOT NULL,
	AchivmentDate DATETIME NOT NULL,
	CONSTRAINT [PK_GradeDetails] PRIMARY KEY CLUSTERED ( Id ASC )
)

CREATE TABLE [AchivmentType]
(
	Id SMALLINT IDENTITY(1,1) NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	[Description] NVARCHAR(50) NOT NULL,
	ParticipationRate INT NOT NULL,
	CONSTRAINT [PK_AchivmentType] PRIMARY KEY CLUSTERED ( Id ASC )
)


