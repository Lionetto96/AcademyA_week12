USE [master]
GO
/****** Object:  Database [AziendaConsulenzaInformatica2]    Script Date: 2/17/2022 2:36:45 PM ******/
CREATE DATABASE [AziendaConsulenzaInformatica2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AziendaConsulenzaInformatica2', FILENAME = N'C:\Users\alessia.lionetto\AziendaConsulenzaInformatica2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AziendaConsulenzaInformatica2_log', FILENAME = N'C:\Users\alessia.lionetto\AziendaConsulenzaInformatica2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AziendaConsulenzaInformatica2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET ARITHABORT OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET  MULTI_USER 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET QUERY_STORE = OFF
GO
USE [AziendaConsulenzaInformatica2]
GO
/****** Object:  Table [dbo].[Clienti]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clienti](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NomeCliente] [nvarchar](50) NOT NULL,
	[Città] [nvarchar](50) NOT NULL,
	[Regione] [nvarchar](50) NOT NULL,
	[Provincia] [nvarchar](50) NOT NULL,
	[IdDimensioneAzienda] [int] NOT NULL,
	[NomeAzienda] [nvarchar](100) NOT NULL,
	[CognomeAzienda] [nvarchar](100) NOT NULL,
	[MailAzienda] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Commessa]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Commessa](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NomeCommessa] [nvarchar](50) NOT NULL,
	[DescrizoneLavoro] [nvarchar](max) NOT NULL,
	[DataInizio] [datetime] NOT NULL,
	[DataFine] [datetime] NOT NULL,
	[IdCliente] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ClientiSenzaCommesseView]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ClientiSenzaCommesseView]
as 
select distinct c.NomeCliente,c.Città,c.NomeAzienda
from Clienti as c 
join Commessa as cm
on cm.IdCliente=c.Id
where  YEAR(cm.DataFine) < YEAR (getdate())
GO
/****** Object:  Table [dbo].[Attività]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attività](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NomeAttività] [nvarchar](50) NOT NULL,
	[OreAllocateXilLavoro] [int] NOT NULL,
	[CostoSingolaOra] [decimal](18, 0) NOT NULL,
	[IdDipendente] [int] NOT NULL,
	[IdCommessa] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ClientiImportanti]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ClientiImportanti]
as
select c.NomeAzienda,cm.NomeCommessa,
		sommaOreAttivitaCommesse= sum(a.OreAllocateXilLavoro),
		fatturato=sum(a.OreAllocateXilLavoro*a.CostoSingolaOra)
from Clienti as c 
join Commessa as cm
on cm.IdCliente= c.Id
join Attività as a 
on a.IdCommessa=cm.Id
group by c.NomeAzienda,cm.NomeCommessa
GO
/****** Object:  Table [dbo].[TimeSheet]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeSheet](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DataRifLavoroSvolto] [datetime] NOT NULL,
	[NumOreSvolte] [int] NOT NULL,
	[IdAttività] [int] NOT NULL,
	[IdDipendente] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CommessaCompletamenteAllocata]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[CommessaCompletamenteAllocata]
as
select c.NomeCommessa,ts.IdAttività,c.IdCliente,
		SommaOreAllocateCommessa=sum(a.OreAllocateXilLavoro),
		SommaOreSvoltePerDipendente=sum(ts.NumOreSvolte),
		AllocazioneCompleta=iif(sum(ts.NumOreSvolte)>=sum(a.OreAllocateXilLavoro),1,0)
from Commessa as c 
join Attività as a 
on a.IdCommessa=c.Id
join TimeSheet as ts
on ts.IdAttività=a.Id
group by c.NomeCommessa,ts.IdAttività,c.IdCliente
having sum(ts.NumOreSvolte)>=sum(a.OreAllocateXilLavoro)
GO
/****** Object:  View [dbo].[FatturatoDipendente]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[FatturatoDipendente]
as
select ts.IdDipendente,fatturato=sum(a.CostoSingolaOra*a.OreAllocateXilLavoro),
		mese=month(ts.DataRifLavoroSvolto)	
from TimeSheet as ts
join Attività a
on a.Id=ts.IdAttività
group by month(ts.DataRifLavoroSvolto)	,ts.IdDipendente
GO
/****** Object:  Table [dbo].[Dipendenti]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dipendenti](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](50) NOT NULL,
	[Cognome] [nvarchar](50) NOT NULL,
	[DataNascita] [datetime] NOT NULL,
	[DataInizioAttività] [datetime] NOT NULL,
	[Mail] [nvarchar](100) NOT NULL,
	[CostoSingolaOraLavorata] [decimal](18, 0) NOT NULL,
	[IdMansione] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PercAllocazioneMedia]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[PercAllocazioneMedia]
as
select nomeDipendente=d.Nome,CognomeDipendente=d.Cognome,DataRifLavoroSvolto,
		allMedia=(cast(sum(ts.NumOreSvolte) as float))/160*100
from TimeSheet as ts
join Dipendenti as d 
on d.Id=ts.IdDipendente
join Attività as a 
on a.Id=ts.IdAttività
group by MONTH(ts.DataRifLavoroSvolto),d.Nome,ts.DataRifLavoroSvolto,d.Cognome
GO
/****** Object:  View [dbo].[Guadagno]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Guadagno]
as
select dipendente=d.Nome+' '+d.Cognome,nomeMese=DATENAME(month,ts.DataRifLavoroSvolto),
	fatturato=(d.CostoSingolaOraLavorata*ts.NumOreSvolte),
	guadagno=((d.CostoSingolaOraLavorata*ts.NumOreSvolte)-sum(d.CostoSingolaOraLavorata))/160
from Dipendenti d 
join TimeSheet ts
on ts.IdDipendente= d.Id
group by d.Nome,d.Cognome,ts.DataRifLavoroSvolto,d.CostoSingolaOraLavorata,ts.NumOreSvolte
GO
/****** Object:  Table [dbo].[DimensioneAzienda]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimensioneAzienda](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Grandezza] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mansioni]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mansioni](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Ruolo] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Attività] ON 

INSERT [dbo].[Attività] ([Id], [NomeAttività], [OreAllocateXilLavoro], [CostoSingolaOra], [IdDipendente], [IdCommessa]) VALUES (1, N'Attività1', 40, CAST(10 AS Decimal(18, 0)), 1, 4)
INSERT [dbo].[Attività] ([Id], [NomeAttività], [OreAllocateXilLavoro], [CostoSingolaOra], [IdDipendente], [IdCommessa]) VALUES (2, N'Attività2', 60, CAST(20 AS Decimal(18, 0)), 2, 5)
INSERT [dbo].[Attività] ([Id], [NomeAttività], [OreAllocateXilLavoro], [CostoSingolaOra], [IdDipendente], [IdCommessa]) VALUES (3, N'Attività3', 80, CAST(15 AS Decimal(18, 0)), 3, 6)
SET IDENTITY_INSERT [dbo].[Attività] OFF
GO
SET IDENTITY_INSERT [dbo].[Clienti] ON 

INSERT [dbo].[Clienti] ([Id], [NomeCliente], [Città], [Regione], [Provincia], [IdDimensioneAzienda], [NomeAzienda], [CognomeAzienda], [MailAzienda]) VALUES (1, N'Giacomo ', N'Milano', N'Lombardia', N'Milano', 4, N'Giacomo & Co', N'Giacometti', N'g.giacometti@azienda.it')
INSERT [dbo].[Clienti] ([Id], [NomeCliente], [Città], [Regione], [Provincia], [IdDimensioneAzienda], [NomeAzienda], [CognomeAzienda], [MailAzienda]) VALUES (2, N'Franco ', N'Roma', N'Lazio', N'Roma', 3, N'Arredamenti Bianchi', N'Bianchi', N'f.bianchi@arredeamentibianchi.it')
INSERT [dbo].[Clienti] ([Id], [NomeCliente], [Città], [Regione], [Provincia], [IdDimensioneAzienda], [NomeAzienda], [CognomeAzienda], [MailAzienda]) VALUES (3, N'Giovanni ', N'Firenze', N'Toscana', N'Firenze', 2, N'Elettrodomestici Gianni', N'De Paolo', N'g.depaolo1@elettrodomesticigianni.it')
SET IDENTITY_INSERT [dbo].[Clienti] OFF
GO
SET IDENTITY_INSERT [dbo].[Commessa] ON 

INSERT [dbo].[Commessa] ([Id], [NomeCommessa], [DescrizoneLavoro], [DataInizio], [DataFine], [IdCliente]) VALUES (4, N'Commessa1', N'descrizione1', CAST(N'2022-02-16T08:00:00.000' AS DateTime), CAST(N'2025-12-31T07:00:00.000' AS DateTime), 1)
INSERT [dbo].[Commessa] ([Id], [NomeCommessa], [DescrizoneLavoro], [DataInizio], [DataFine], [IdCliente]) VALUES (5, N'Commessa2', N'descrizione lavoro', CAST(N'2021-02-01T12:00:00.000' AS DateTime), CAST(N'2022-02-01T05:00:00.000' AS DateTime), 2)
INSERT [dbo].[Commessa] ([Id], [NomeCommessa], [DescrizoneLavoro], [DataInizio], [DataFine], [IdCliente]) VALUES (6, N'Commessa3', N'descrizione2 lavoro', CAST(N'2020-09-20T10:00:00.000' AS DateTime), CAST(N'2023-09-21T21:00:00.000' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[Commessa] OFF
GO
SET IDENTITY_INSERT [dbo].[DimensioneAzienda] ON 

INSERT [dbo].[DimensioneAzienda] ([Id], [Grandezza]) VALUES (1, N'Enterprise')
INSERT [dbo].[DimensioneAzienda] ([Id], [Grandezza]) VALUES (2, N'Grande')
INSERT [dbo].[DimensioneAzienda] ([Id], [Grandezza]) VALUES (3, N'Media')
INSERT [dbo].[DimensioneAzienda] ([Id], [Grandezza]) VALUES (4, N'Piccola')
SET IDENTITY_INSERT [dbo].[DimensioneAzienda] OFF
GO
SET IDENTITY_INSERT [dbo].[Dipendenti] ON 

INSERT [dbo].[Dipendenti] ([Id], [Nome], [Cognome], [DataNascita], [DataInizioAttività], [Mail], [CostoSingolaOraLavorata], [IdMansione]) VALUES (1, N'Alessia', N'Lionetto', CAST(N'1996-08-19T09:46:00.000' AS DateTime), CAST(N'2021-11-15T12:00:00.000' AS DateTime), N'ale.lio@gmail.com', CAST(12 AS Decimal(18, 0)), 1)
INSERT [dbo].[Dipendenti] ([Id], [Nome], [Cognome], [DataNascita], [DataInizioAttività], [Mail], [CostoSingolaOraLavorata], [IdMansione]) VALUES (2, N'Alessio', N'Loss', CAST(N'1996-09-22T21:46:00.000' AS DateTime), CAST(N'2021-11-30T13:00:00.000' AS DateTime), N'ale.loss@gmail.com', CAST(10 AS Decimal(18, 0)), 2)
INSERT [dbo].[Dipendenti] ([Id], [Nome], [Cognome], [DataNascita], [DataInizioAttività], [Mail], [CostoSingolaOraLavorata], [IdMansione]) VALUES (3, N'Paolo', N'Rossi', CAST(N'1992-06-15T18:32:00.000' AS DateTime), CAST(N'2021-01-10T14:00:00.000' AS DateTime), N'paolo.rossi@gmail.com', CAST(9 AS Decimal(18, 0)), 3)
INSERT [dbo].[Dipendenti] ([Id], [Nome], [Cognome], [DataNascita], [DataInizioAttività], [Mail], [CostoSingolaOraLavorata], [IdMansione]) VALUES (4, N'Mario', N'Verdi', CAST(N'1985-01-19T08:26:00.000' AS DateTime), CAST(N'2016-04-15T18:00:00.000' AS DateTime), N'mario.verdi@gmail.com', CAST(8 AS Decimal(18, 0)), 4)
SET IDENTITY_INSERT [dbo].[Dipendenti] OFF
GO
SET IDENTITY_INSERT [dbo].[Mansioni] ON 

INSERT [dbo].[Mansioni] ([Id], [Ruolo]) VALUES (1, N'Manager')
INSERT [dbo].[Mansioni] ([Id], [Ruolo]) VALUES (2, N'Senior Consultant')
INSERT [dbo].[Mansioni] ([Id], [Ruolo]) VALUES (3, N'Consultant')
INSERT [dbo].[Mansioni] ([Id], [Ruolo]) VALUES (4, N'Senior Analyst')
INSERT [dbo].[Mansioni] ([Id], [Ruolo]) VALUES (5, N'Analyst')
SET IDENTITY_INSERT [dbo].[Mansioni] OFF
GO
SET IDENTITY_INSERT [dbo].[TimeSheet] ON 

INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (1, CAST(N'2022-01-12T00:00:00.000' AS DateTime), 8, 1, 1)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (2, CAST(N'2022-01-18T00:00:00.000' AS DateTime), 6, 1, 1)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (3, CAST(N'2022-01-23T00:00:00.000' AS DateTime), 4, 1, 1)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (4, CAST(N'2022-01-11T00:00:00.000' AS DateTime), 9, 1, 1)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (5, CAST(N'2022-01-12T00:00:00.000' AS DateTime), 7, 1, 1)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (6, CAST(N'2022-01-30T00:00:00.000' AS DateTime), 5, 2, 2)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (7, CAST(N'2022-02-13T00:00:00.000' AS DateTime), 4, 2, 2)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (8, CAST(N'2022-02-01T00:00:00.000' AS DateTime), 6, 2, 2)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (9, CAST(N'2022-01-18T00:00:00.000' AS DateTime), 9, 2, 2)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (10, CAST(N'2022-01-15T00:00:00.000' AS DateTime), 8, 2, 2)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (11, CAST(N'2022-01-12T00:00:00.000' AS DateTime), 6, 1, 3)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (12, CAST(N'2022-01-28T00:00:00.000' AS DateTime), 6, 3, 3)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (13, CAST(N'2022-02-17T00:00:00.000' AS DateTime), 4, 2, 3)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (14, CAST(N'2022-02-04T00:00:00.000' AS DateTime), 5, 1, 3)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (15, CAST(N'2022-02-06T00:00:00.000' AS DateTime), 9, 3, 3)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (16, CAST(N'2022-02-01T00:00:00.000' AS DateTime), 3, 2, 4)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (17, CAST(N'2022-02-10T00:00:00.000' AS DateTime), 7, 2, 4)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (18, CAST(N'2022-02-08T00:00:00.000' AS DateTime), 9, 1, 4)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (19, CAST(N'2022-02-13T00:00:00.000' AS DateTime), 8, 3, 4)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (20, CAST(N'2022-01-21T00:00:00.000' AS DateTime), 4, 1, 4)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (21, CAST(N'2022-01-12T00:00:00.000' AS DateTime), 8, 1, 1)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (22, CAST(N'2022-01-18T00:00:00.000' AS DateTime), 6, 1, 1)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (23, CAST(N'2022-01-23T00:00:00.000' AS DateTime), 4, 1, 1)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (24, CAST(N'2022-01-11T00:00:00.000' AS DateTime), 9, 1, 1)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (25, CAST(N'2022-01-12T00:00:00.000' AS DateTime), 7, 1, 1)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (26, CAST(N'2022-01-30T00:00:00.000' AS DateTime), 5, 2, 2)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (27, CAST(N'2022-02-13T00:00:00.000' AS DateTime), 4, 2, 2)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (28, CAST(N'2022-02-01T00:00:00.000' AS DateTime), 6, 2, 2)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (29, CAST(N'2022-01-18T00:00:00.000' AS DateTime), 3, 2, 2)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (30, CAST(N'2022-01-15T00:00:00.000' AS DateTime), 8, 2, 2)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (31, CAST(N'2022-01-12T00:00:00.000' AS DateTime), 6, 1, 3)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (32, CAST(N'2022-01-28T00:00:00.000' AS DateTime), 6, 3, 3)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (33, CAST(N'2022-02-17T00:00:00.000' AS DateTime), 4, 2, 3)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (34, CAST(N'2022-02-04T00:00:00.000' AS DateTime), 5, 1, 3)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (35, CAST(N'2022-02-06T00:00:00.000' AS DateTime), 7, 3, 3)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (36, CAST(N'2022-02-01T00:00:00.000' AS DateTime), 3, 2, 4)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (37, CAST(N'2022-02-10T00:00:00.000' AS DateTime), 7, 2, 4)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (38, CAST(N'2022-02-08T00:00:00.000' AS DateTime), 5, 1, 4)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (39, CAST(N'2022-02-13T00:00:00.000' AS DateTime), 8, 3, 4)
INSERT [dbo].[TimeSheet] ([Id], [DataRifLavoroSvolto], [NumOreSvolte], [IdAttività], [IdDipendente]) VALUES (40, CAST(N'2022-01-21T00:00:00.000' AS DateTime), 4, 1, 4)
SET IDENTITY_INSERT [dbo].[TimeSheet] OFF
GO
ALTER TABLE [dbo].[Attività]  WITH CHECK ADD  CONSTRAINT [FK_Commessa] FOREIGN KEY([IdCommessa])
REFERENCES [dbo].[Commessa] ([Id])
GO
ALTER TABLE [dbo].[Attività] CHECK CONSTRAINT [FK_Commessa]
GO
ALTER TABLE [dbo].[Attività]  WITH CHECK ADD  CONSTRAINT [FK_Dipendente] FOREIGN KEY([IdDipendente])
REFERENCES [dbo].[Dipendenti] ([Id])
GO
ALTER TABLE [dbo].[Attività] CHECK CONSTRAINT [FK_Dipendente]
GO
ALTER TABLE [dbo].[Clienti]  WITH CHECK ADD  CONSTRAINT [FK_DimAzienda] FOREIGN KEY([IdDimensioneAzienda])
REFERENCES [dbo].[DimensioneAzienda] ([Id])
GO
ALTER TABLE [dbo].[Clienti] CHECK CONSTRAINT [FK_DimAzienda]
GO
ALTER TABLE [dbo].[Commessa]  WITH CHECK ADD  CONSTRAINT [FK_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clienti] ([Id])
GO
ALTER TABLE [dbo].[Commessa] CHECK CONSTRAINT [FK_Cliente]
GO
ALTER TABLE [dbo].[Dipendenti]  WITH CHECK ADD  CONSTRAINT [FK_1] FOREIGN KEY([IdMansione])
REFERENCES [dbo].[Mansioni] ([Id])
GO
ALTER TABLE [dbo].[Dipendenti] CHECK CONSTRAINT [FK_1]
GO
ALTER TABLE [dbo].[TimeSheet]  WITH CHECK ADD  CONSTRAINT [FK_Attività] FOREIGN KEY([IdAttività])
REFERENCES [dbo].[Attività] ([Id])
GO
ALTER TABLE [dbo].[TimeSheet] CHECK CONSTRAINT [FK_Attività]
GO
ALTER TABLE [dbo].[TimeSheet]  WITH CHECK ADD  CONSTRAINT [FK_Dipendente2] FOREIGN KEY([IdDipendente])
REFERENCES [dbo].[Dipendenti] ([Id])
GO
ALTER TABLE [dbo].[TimeSheet] CHECK CONSTRAINT [FK_Dipendente2]
GO
ALTER TABLE [dbo].[Commessa]  WITH CHECK ADD  CONSTRAINT [Chk_DataFine] CHECK  (([DataFine]>[DataInizio]))
GO
ALTER TABLE [dbo].[Commessa] CHECK CONSTRAINT [Chk_DataFine]
GO
/****** Object:  StoredProcedure [dbo].[RegistroOre]    Script Date: 2/17/2022 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RegistroOre]
 @dataRif datetime,@orelavorate int,@IdAttività int, @IdDipendente int
as 
insert into TimeSheet
values (@dataRif ,@orelavorate,@IdAttività,@IdDipendente )
GO
USE [master]
GO
ALTER DATABASE [AziendaConsulenzaInformatica2] SET  READ_WRITE 
GO
