IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE SEQUENCE [Blog_hilo] START WITH 1 INCREMENT BY 10 NO MINVALUE NO MAXVALUE NO CYCLE;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE SEQUENCE [Post_hilo] START WITH 1 INCREMENT BY 10 NO MINVALUE NO MAXVALUE NO CYCLE;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE SEQUENCE [PostTag_hilo] START WITH 1 INCREMENT BY 10 NO MINVALUE NO MAXVALUE NO CYCLE;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE SEQUENCE [Recompte_hilo] START WITH 1 INCREMENT BY 10 NO MINVALUE NO MAXVALUE NO CYCLE;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE SEQUENCE [Session_hilo] START WITH 1 INCREMENT BY 10 NO MINVALUE NO MAXVALUE NO CYCLE;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE SEQUENCE [Tag_hilo] START WITH 1 INCREMENT BY 10 NO MINVALUE NO MAXVALUE NO CYCLE;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE SEQUENCE [User_hilo] START WITH 1 INCREMENT BY 10 NO MINVALUE NO MAXVALUE NO CYCLE;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE TABLE [BlogStatus] (
        [Id] int NOT NULL DEFAULT 1,
        [Name] nvarchar(200) NOT NULL DEFAULT N'',
        CONSTRAINT [PK_BlogStatus] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE TABLE [Recomptes] (
        [Id] int NOT NULL,
        [BlogName] nvarchar(450) NULL,
        [NumeroDeCanvisDeTitol] int NOT NULL,
        CONSTRAINT [PK_Recomptes] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE TABLE [Tags] (
        [Id] int NOT NULL,
        [Label] nvarchar(450) NOT NULL DEFAULT N'',
        [NumeroDePostsQueElFanServir] int NOT NULL,
        CONSTRAINT [PK_Tags] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE TABLE [Users] (
        [Id] int NOT NULL,
        [Username] nvarchar(50) NOT NULL DEFAULT N'',
        [Nom] nvarchar(50) NOT NULL DEFAULT N'',
        [Cognoms] nvarchar(250) NOT NULL DEFAULT N'',
        [EsMaster] bit NOT NULL DEFAULT CAST(0 AS bit),
        CONSTRAINT [PK_Users] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE TABLE [Blogs] (
        [Id] int NOT NULL,
        [Name] nvarchar(450) NOT NULL DEFAULT N'',
        [NumeroDePosts] int NOT NULL DEFAULT 0,
        [NumeroMaximDePosts] int NOT NULL,
        [TimeStamp] rowversion NULL,
        [ElMeuEstatId] int NULL,
        CONSTRAINT [PK_Blogs] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Blogs_BlogStatus_ElMeuEstatId] FOREIGN KEY ([ElMeuEstatId]) REFERENCES [BlogStatus] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE TABLE [Sessions] (
        [Id] int NOT NULL,
        [JWT] nvarchar(450) NULL,
        [MomentDeCreacio] datetime2 NOT NULL,
        [UsuariId] int NULL,
        CONSTRAINT [PK_Sessions] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Sessions_Users_UsuariId] FOREIGN KEY ([UsuariId]) REFERENCES [Users] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE TABLE [Posts] (
        [Id] int NOT NULL,
        [Title] nvarchar(450) NOT NULL DEFAULT N'',
        [MyBlogId] int NULL,
        CONSTRAINT [PK_Posts] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Posts_Blogs_MyBlogId] FOREIGN KEY ([MyBlogId]) REFERENCES [Blogs] ([Id]) ON DELETE SET NULL
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE TABLE [PostTags] (
        [Id] int NOT NULL,
        [MyPostId] int NOT NULL,
        [MyTagId] int NOT NULL,
        CONSTRAINT [PK_PostTags] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_PostTags_Posts_MyPostId] FOREIGN KEY ([MyPostId]) REFERENCES [Posts] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_PostTags_Tags_MyTagId] FOREIGN KEY ([MyTagId]) REFERENCES [Tags] ([Id]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE INDEX [IX_Blogs_ElMeuEstatId] ON [Blogs] ([ElMeuEstatId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE UNIQUE INDEX [IX_Blogs_Name] ON [Blogs] ([Name]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE INDEX [IX_Posts_MyBlogId] ON [Posts] ([MyBlogId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE UNIQUE INDEX [IX_Posts_Title_MyBlogId] ON [Posts] ([Title], [MyBlogId]) WHERE [MyBlogId] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE INDEX [IX_PostTags_MyTagId] ON [PostTags] ([MyTagId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE UNIQUE INDEX [IX_PostTags_MyPostId_MyTagId] ON [PostTags] ([MyPostId], [MyTagId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE UNIQUE INDEX [IX_Recomptes_BlogName] ON [Recomptes] ([BlogName]) WHERE [BlogName] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE UNIQUE INDEX [IX_Sessions_JWT] ON [Sessions] ([JWT]) WHERE [JWT] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE INDEX [IX_Sessions_UsuariId] ON [Sessions] ([UsuariId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE UNIQUE INDEX [IX_Tags_Label] ON [Tags] ([Label]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    CREATE UNIQUE INDEX [IX_Users_Username] ON [Users] ([Username]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190531134420_inicial')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190531134420_inicial', N'3.0.0');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190603114944_configadded')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190603114944_configadded', N'3.0.0');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190606144154_moment')
BEGIN
    ALTER TABLE [Sessions] ADD [MomentUltimaOperacio] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190606144154_moment')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190606144154_moment', N'3.0.0');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190916063330_tags_tree')
BEGIN
    DROP INDEX [IX_PostTags_MyPostId_MyTagId] ON [PostTags];
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190916063330_tags_tree')
BEGIN
    ALTER TABLE [Tags] ADD [ParentId] int NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190916063330_tags_tree')
BEGIN
    CREATE INDEX [IX_Tags_ParentId] ON [Tags] ([ParentId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190916063330_tags_tree')
BEGIN
    CREATE INDEX [IX_PostTags_MyPostId] ON [PostTags] ([MyPostId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190916063330_tags_tree')
BEGIN
    ALTER TABLE [Tags] ADD CONSTRAINT [FK_Tags_Tags_ParentId] FOREIGN KEY ([ParentId]) REFERENCES [Tags] ([Id]) ON DELETE NO ACTION;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190916063330_tags_tree')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190916063330_tags_tree', N'3.0.0');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191001114504_tags_hierarchy')
BEGIN
    CREATE TABLE [TagsHierarchy] (
        [Id] int NOT NULL IDENTITY,
        [AncestorId] int NOT NULL,
        [DescendantId] int NOT NULL,
        [AncestorLevel] int NOT NULL,
        [DescendantLevel] int NOT NULL,
        CONSTRAINT [PK_TagsHierarchy] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_TagsHierarchy_Tags_AncestorId] FOREIGN KEY ([AncestorId]) REFERENCES [Tags] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_TagsHierarchy_Tags_DescendantId] FOREIGN KEY ([DescendantId]) REFERENCES [Tags] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191001114504_tags_hierarchy')
BEGIN
    CREATE UNIQUE INDEX [IX_TagsHierarchy_AncestorId_DescendantId] ON [TagsHierarchy] ([AncestorId], [DescendantId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191001114504_tags_hierarchy')
BEGIN
    CREATE UNIQUE INDEX [IX_TagsHierarchy_DescendantId_AncestorId] ON [TagsHierarchy] ([DescendantId], [AncestorId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191001114504_tags_hierarchy')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191001114504_tags_hierarchy', N'3.0.0');
END;

GO

