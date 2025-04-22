-- Vérifier si la base de données existe déjà
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'MaillotsDB')
BEGIN
    -- Créer la base de données
    CREATE DATABASE MaillotsDB;
END
GO

USE MaillotsDB;
GO

-- Vérifier si la table Maillot existe déjà
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Maillot]') AND type in (N'U'))
BEGIN
    -- Créer la table Maillot
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
    );
END
GO

-- Vérifier si l'index sur l'ordre existe déjà
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Maillot_Ordre' AND object_id = OBJECT_ID('dbo.Maillot'))
BEGIN
    -- Créer l'index sur l'ordre
    CREATE INDEX [IX_Maillot_Ordre] ON [dbo].[Maillot] ([Ordre]);
END
GO

-- Insérer quelques données de test si la table est vide
IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].[Maillot])
BEGIN
    -- Insérer des données de test
    INSERT INTO [dbo].[Maillot] ([Nom], [Description], [Prix], [Couleur], [ImageUrl], [Equipe], [Taille], [Disponibilite], [Ordre], [DateAjout])
    VALUES 
    ('Maillot Domicile Canada', 'Maillot officiel de l''équipe nationale du Canada pour la Coupe du Monde 2026', 89.99, 'Rouge', 'https://example.com/canada-home.jpg', 'Canada', 'M', 1, 1, GETDATE()),
    ('Maillot Extérieur Canada', 'Maillot officiel extérieur de l''équipe nationale du Canada pour la Coupe du Monde 2026', 89.99, 'Blanc', 'https://example.com/canada-away.jpg', 'Canada', 'M', 1, 2, GETDATE()),
    ('Maillot Domicile USA', 'Maillot officiel de l''équipe nationale des USA pour la Coupe du Monde 2026', 89.99, 'Bleu', 'https://example.com/usa-home.jpg', 'USA', 'M', 1, 3, GETDATE()),
    ('Maillot Extérieur USA', 'Maillot officiel extérieur de l''équipe nationale des USA pour la Coupe du Monde 2026', 89.99, 'Blanc', 'https://example.com/usa-away.jpg', 'USA', 'M', 1, 4, GETDATE()),
    ('Maillot Domicile Mexique', 'Maillot officiel de l''équipe nationale du Mexique pour la Coupe du Monde 2026', 89.99, 'Vert', 'https://example.com/mexico-home.jpg', 'Mexique', 'M', 1, 5, GETDATE()),
    ('Maillot Extérieur Mexique', 'Maillot officiel extérieur de l''équipe nationale du Mexique pour la Coupe du Monde 2026', 89.99, 'Noir', 'https://example.com/mexico-away.jpg', 'Mexique', 'M', 1, 6, GETDATE());
END
GO 