-- Post [ent1]
alter table "public"."post"  add column  "inappropriate"  bool;


-- Comment [ent3]
alter table "public"."comment"  add column  "inappropriate"  bool;


-- Group_DefaultModule [Group2DefaultModule_DefaultModule2Group]
alter table "public"."group"  add column  "module_oid"  int4;
alter table "public"."group"   add constraint fk_group_module_2 foreign key ("module_oid") references "public"."module" ("oid_module");


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table "public"."user"  add column  "group_oid"  int4;
alter table "public"."user"   add constraint fk_user_group_2 foreign key ("group_oid") references "public"."group" ("oid_group");


