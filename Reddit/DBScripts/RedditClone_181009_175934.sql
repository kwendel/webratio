-- Group [Group]
create table "public"."group" (
   "oid"  int4  not null,
   "groupname"  varchar(255),
  primary key ("oid")
);


-- Module [Module]
create table "public"."module" (
   "oid"  int4  not null,
   "moduleid"  varchar(255),
   "modulename"  varchar(255),
  primary key ("oid")
);


-- Registered User [User]
create table "public"."user" (
   "oid_user"  int4  not null,
   "username"  varchar(255),
   "password"  varchar(255),
   "email"  varchar(255),
   "reputation"  int4,
   "last_activity"  timestamp,
   "registration"  timestamp,
   "nickname"  varchar(255),
  primary key ("oid_user")
);


-- Post [ent1]
create table "public"."post" (
   "oid_post"  int4  not null,
   "text"  varchar(255),
   "link"  varchar(255),
   "publication"  timestamp,
   "title"  varchar(255),
   "downvotes"  int4,
   "upvotes"  int4,
  primary key ("oid_post")
);


-- Channel [ent2]
create table "public"."channel" (
   "oid_channel"  int4  not null,
   "private"  bool,
   "title"  varchar(255),
   "tags"  varchar(255),
   "description"  varchar(255),
  primary key ("oid_channel")
);


-- Comment [ent3]
create table "public"."comment" (
   "oid_comment"  int4  not null,
   "content"  varchar(255),
   "publication"  timestamp,
   "title"  varchar(255),
   "upvotes"  int4,
   "downvotes"  int4,
  primary key ("oid_comment")
);


-- Group_DefaultModule [Group2DefaultModule_DefaultModule2Group]
alter table "public"."group"  add column  "module_oid"  int4;
alter table "public"."group"   add constraint fk_group_module foreign key ("module_oid") references "public"."module" ("oid");


-- Group_Module [Group2Module_Module2Group]
create table "public"."group_module" (
   "group_oid"  int4 not null,
   "module_oid"  int4 not null,
  primary key ("group_oid", "module_oid")
);
alter table "public"."group_module"   add constraint fk_group_module_group foreign key ("group_oid") references "public"."group" ("oid");
alter table "public"."group_module"   add constraint fk_group_module_module foreign key ("module_oid") references "public"."module" ("oid");


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table "public"."user"  add column  "group_oid"  int4;
alter table "public"."user"   add constraint fk_user_group foreign key ("group_oid") references "public"."group" ("oid");


-- User_Group [User2Group_Group2User]
create table "public"."user_group" (
   "user_oid"  int4 not null,
   "group_oid"  int4 not null,
  primary key ("user_oid", "group_oid")
);
alter table "public"."user_group"   add constraint fk_user_group_user foreign key ("user_oid") references "public"."user" ("oid_user");
alter table "public"."user_group"   add constraint fk_user_group_group foreign key ("group_oid") references "public"."group" ("oid");


-- Channel_Moderators [rel1]
create table "public"."channel_moderators" (
   "channel_oid_channel"  int4 not null,
   "user_oid_user"  int4 not null,
  primary key ("channel_oid_channel", "user_oid_user")
);
alter table "public"."channel_moderators"   add constraint fk_channel_moderators_channel foreign key ("channel_oid_channel") references "public"."channel" ("oid_channel");
alter table "public"."channel_moderators"   add constraint fk_channel_moderators_user foreign key ("user_oid_user") references "public"."user" ("oid_user");


-- Channel_Subscribed [rel2]
create table "public"."channel_subscribed" (
   "user_oid_user"  int4 not null,
   "channel_oid_channel"  int4 not null,
  primary key ("user_oid_user", "channel_oid_channel")
);
alter table "public"."channel_subscribed"   add constraint fk_channel_subscribed_user foreign key ("user_oid_user") references "public"."user" ("oid_user");
alter table "public"."channel_subscribed"   add constraint fk_channel_subscribed_channel foreign key ("channel_oid_channel") references "public"."channel" ("oid_channel");


-- Post_Channel [rel3]
alter table "public"."post"  add column  "channel_oid_channel"  int4;
alter table "public"."post"   add constraint fk_post_channel foreign key ("channel_oid_channel") references "public"."channel" ("oid_channel");


-- Post Owner [rel4]
alter table "public"."post"  add column  "user_oid_user"  int4;
alter table "public"."post"   add constraint fk_post_user foreign key ("user_oid_user") references "public"."user" ("oid_user");


-- Comment_Post [rel5]
alter table "public"."comment"  add column  "post_oid_post"  int4;
alter table "public"."comment"   add constraint fk_comment_post foreign key ("post_oid_post") references "public"."post" ("oid_post");


-- Comment_Registered User [rel6]
alter table "public"."comment"  add column  "user_oid_user"  int4;
alter table "public"."comment"   add constraint fk_comment_user foreign key ("user_oid_user") references "public"."user" ("oid_user");


