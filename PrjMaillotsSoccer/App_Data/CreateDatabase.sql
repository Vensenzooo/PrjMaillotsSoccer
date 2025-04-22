-- Création de la base de données si elle n'existe pas
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'MaillotsDB')
BEGIN
    CREATE DATABASE MaillotsDB;
END
GO

USE MaillotsDB;
GO

-- Création de la table Maillot si elle n'existe pas
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Maillot]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Maillot](
        [Id] [int] IDENTITY(1,1) NOT NULL,
        [Nom] [nvarchar](100) NOT NULL,
        [Description] [nvarchar](500) NULL,
        [Prix] [decimal](10, 2) NOT NULL,
        [Couleur] [nvarchar](50) NULL,
        [ImageUrl] [nvarchar](500) NULL,
        [Equipe] [nvarchar](100) NULL,
        [Taille] [nvarchar](20) NULL,
        [Disponibilite] [bit] NOT NULL DEFAULT(1),
        [Ordre] [int] NOT NULL DEFAULT(0),
        [DateAjout] [datetime] NOT NULL DEFAULT(GETDATE()),
        CONSTRAINT [PK_Maillot] PRIMARY KEY CLUSTERED ([Id] ASC)
    )
END
GO

-- Création d'un index sur l'ordre pour faciliter le tri
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Maillot_Ordre' AND object_id = OBJECT_ID('dbo.Maillot'))
BEGIN
    CREATE INDEX [IX_Maillot_Ordre] ON [dbo].[Maillot] ([Ordre])
END
GO 