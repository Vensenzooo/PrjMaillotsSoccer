-- Réinitialiser l'identité de la table
DBCC CHECKIDENT ('Maillot', RESEED, 0);

-- Supprimer toutes les données existantes
DELETE FROM Maillot;

-- Insérer les maillots pour le Canada
INSERT INTO Maillot (Nom, Description, Prix, Couleur, ImageUrl, Equipe, Taille, Disponibilite, Ordre)
VALUES 
('Maillot Domicile Canada 2026', 
'Maillot officiel de l''équipe nationale du Canada pour la Coupe du Monde 2026. Design élégant en rouge vif avec la feuille d''érable emblématique.', 
119.99, 'Rouge', 'https://th.bing.com/th/id/OIP.OYZ1nFbHlIKq9wC8ZXFeXQHaHx?w=161&h=180&c=7&r=0&o=5&pid=1.7', 'Canada', 'M', 1, 1),

('Maillot Extérieur Canada 2026',
'Version extérieure du maillot canadien en blanc pur avec détails rouges. Tissu léger et respirant avec technologie ClimaCool.',
119.99, 'Blanc', 'https://th.bing.com/th/id/OIP.OYZ1nFbHlIKq9wC8ZXFeXQHaHx?w=161&h=180&c=7&r=0&o=5&pid=1.7', 'Canada', 'L', 1, 2),

('Maillot Alternatif Canada',
'Edition spéciale avec un design noir élégant et des accents rouges. Parfait pour les supporters passionnés.',
129.99, 'Noir', 'https://th.bing.com/th/id/OIP.OYZ1nFbHlIKq9wC8ZXFeXQHaHx?w=161&h=180&c=7&r=0&o=5&pid=1.7', 'Canada', 'S', 1, 3);

-- Insérer les maillots pour les USA
INSERT INTO Maillot (Nom, Description, Prix, Couleur, ImageUrl, Equipe, Taille, Disponibilite, Ordre)
VALUES 
('Maillot Domicile USA 2026',
'Maillot domicile officiel de l''équipe américaine. Design moderne avec bandes bleues et étoiles représentant le drapeau américain.',
119.99, 'Blanc', 'https://th.bing.com/th/id/OIP.OYZ1nFbHlIKq9wC8ZXFeXQHaHx?w=161&h=180&c=7&r=0&o=5&pid=1.7', 'USA', 'L', 1, 4),

('Maillot Extérieur USA 2026',
'Maillot extérieur en bleu marine avec détails rouges et blancs. Technologie DriFit pour un confort optimal.',
119.99, 'Bleu', 'https://th.bing.com/th/id/OIP.OYZ1nFbHlIKq9wC8ZXFeXQHaHx?w=161&h=180&c=7&r=0&o=5&pid=1.7', 'USA', 'M', 1, 5),

('Maillot Spécial USA',
'Edition collector avec un design inspiré du drapeau américain. Parfait pour les grands matchs.',
139.99, 'Rouge', 'https://th.bing.com/th/id/OIP.OYZ1nFbHlIKq9wC8ZXFeXQHaHx?w=161&h=180&c=7&r=0&o=5&pid=1.7', 'USA', 'XL', 0, 6);

-- Insérer les maillots pour le Mexique
INSERT INTO Maillot (Nom, Description, Prix, Couleur, ImageUrl, Equipe, Taille, Disponibilite, Ordre)
VALUES 
('Maillot Domicile Mexique 2026',
'Maillot traditionnel vert avec motifs aztèques subtils. Un classique modernisé pour 2026.',
119.99, 'Vert', 'https://th.bing.com/th/id/OIP.OYZ1nFbHlIKq9wC8ZXFeXQHaHx?w=161&h=180&c=7&r=0&o=5&pid=1.7', 'Mexique', 'M', 1, 7),

('Maillot Extérieur Mexique 2026',
'Design blanc épuré avec détails verts et rouges. Tissu léger et confortable.',
119.99, 'Blanc', 'https://th.bing.com/th/id/OIP.OYZ1nFbHlIKq9wC8ZXFeXQHaHx?w=161&h=180&c=7&r=0&o=5&pid=1.7', 'Mexique', 'S', 1, 8),

('Maillot Commémoratif Mexique',
'Edition spéciale noire avec motifs aztèques dorés. Une pièce de collection unique.',
139.99, 'Noir', 'https://th.bing.com/th/id/OIP.OYZ1nFbHlIKq9wC8ZXFeXQHaHx?w=161&h=180&c=7&r=0&o=5&pid=1.7', 'Mexique', 'L', 0, 9);

-- Insérer des variantes de taille pour les maillots populaires
INSERT INTO Maillot (Nom, Description, Prix, Couleur, ImageUrl, Equipe, Taille, Disponibilite, Ordre)
VALUES 
('Maillot Domicile Canada 2026',
'Maillot officiel de l''équipe nationale du Canada pour la Coupe du Monde 2026. Design élégant en rouge vif avec la feuille d''érable emblématique.',
119.99, 'Rouge', 'https://th.bing.com/th/id/OIP.OYZ1nFbHlIKq9wC8ZXFeXQHaHx?w=161&h=180&c=7&r=0&o=5&pid=1.7', 'Canada', 'S', 1, 10),

('Maillot Domicile Canada 2026',
'Maillot officiel de l''équipe nationale du Canada pour la Coupe du Monde 2026. Design élégant en rouge vif avec la feuille d''érable emblématique.',
119.99, 'Rouge', 'https://th.bing.com/th/id/OIP.OYZ1nFbHlIKq9wC8ZXFeXQHaHx?w=161&h=180&c=7&r=0&o=5&pid=1.7', 'Canada', 'L', 1, 11),

('Maillot Domicile USA 2026',
'Maillot domicile officiel de l''équipe américaine. Design moderne avec bandes bleues et étoiles représentant le drapeau américain.',
119.99, 'Blanc', 'https://th.bing.com/th/id/OIP.OYZ1nFbHlIKq9wC8ZXFeXQHaHx?w=161&h=180&c=7&r=0&o=5&pid=1.7', 'USA', 'S', 1, 12),

('Maillot Domicile Mexique 2026',
'Maillot traditionnel vert avec motifs aztèques subtils. Un classique modernisé pour 2026.',
119.99, 'Vert', 'https://th.bing.com/th/id/OIP.OYZ1nFbHlIKq9wC8ZXFeXQHaHx?w=161&h=180&c=7&r=0&o=5&pid=1.7', 'Mexique', 'XL', 1, 13);

-- Mettre à jour les statistiques de la table
UPDATE STATISTICS Maillot; 