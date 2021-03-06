##  ********************************************
##  Coppermine Photo Gallery
##  ************************
##  Copyright (c) 2003-2009 Coppermine Dev Team
##  v1.1 originally written by Gregory DEMAR
##
##  This program is free software; you can redistribute it and/or modify
##  it under the terms of the GNU General Public License version 3
##  as published by the Free Software Foundation.
##
##  ********************************************
##  Coppermine version: 1.5.1
##  $HeadURL$
##  $Revision$
##  $LastChangedBy$
##  $Date$
##  ********************************************

#
# Table structure for table CPG_albums
#
CREATE TABLE CPG_albums (
  aid int(11) NOT NULL auto_increment,
  title varchar(255) NOT NULL default '',
  description text NOT NULL,
  visibility int(11) NOT NULL default '0',
  uploads enum('YES','NO') NOT NULL default 'NO',
  comments enum('YES','NO') NOT NULL default 'YES',
  votes enum('YES','NO') NOT NULL default 'YES',
  pos int(11) NOT NULL default '0',
  category int(11) NOT NULL default '0',
  owner int(11) NOT NULL DEFAULT '1',
  thumb int(11) NOT NULL default '0',
  keyword VARCHAR( 50 ),
  alb_password VARCHAR( 32 ),
  alb_password_hint TEXT,
  moderator_group INT NOT NULL default 0,
  alb_hits INT( 10 ) NOT NULL default 0,
  PRIMARY KEY  (aid),
  KEY alb_category (category),
  KEY `moderator_group` (`moderator_group`),
  KEY `visibility` (`visibility`)
) TYPE=MyISAM COMMENT='Used to store albums';
# --------------------------------------------------------

#
# Table structure for table CPG_banned
#
CREATE TABLE CPG_banned (
        ban_id int(11) NOT NULL auto_increment,
        user_id int(11) DEFAULT NULL,
        user_name varchar(255) NOT NULL default '',
        email varchar(255) NOT NULL default '',
        ip_addr tinytext,
        expiry datetime DEFAULT NULL,
        brute_force tinyint(5) NOT NULL default '0',
        PRIMARY KEY  (ban_id)
) TYPE=MyISAM COMMENT='Data about banned users';
#---------------------------------------------------------


#
# Table structure for table CPG_bridge
#
CREATE TABLE CPG_bridge (
  name varchar(40) NOT NULL default '0',
  value varchar(255) NOT NULL default '',
  UNIQUE KEY name (name)
) TYPE=MyISAM COMMENT='Stores the bridging data, not used when unbridged';
# --------------------------------------------------------

#
# Table structure for table CPG_categories
#
CREATE TABLE CPG_categories (
  cid int(11) NOT NULL auto_increment,
  owner_id int(11) NOT NULL default '0',
  name varchar(255) NOT NULL default '',
  description text NOT NULL,
  pos int(11) NOT NULL default '0',
  parent int(11) NOT NULL default '0',
  thumb int(11) NOT NULL default '0',
  lft mediumint(8) unsigned NOT NULL default '0',
  rgt mediumint(8) unsigned NOT NULL default '0',
  depth tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (cid),
  KEY cat_parent (parent),
  KEY cat_pos (pos),
  KEY cat_owner_id (owner_id),
  KEY `depth_cid` (`depth`,`cid`),
  KEY `lft_depth` (`lft`,`depth`)
) TYPE=MyISAM COMMENT='Used to store categories';
# --------------------------------------------------------

#
# Table structure for table CPG_categorymap
#
CREATE TABLE IF NOT EXISTS `CPG_categorymap` (
  cid int(11) NOT NULL,
  group_id int(11) NOT NULL,
  PRIMARY KEY  (cid,group_id)
) ENGINE=MyISAM COMMENT='Holds the categories where groups can create albums';
# --------------------------------------------------------

#
# Table structure for table CPG_comments
#
CREATE TABLE CPG_comments (
  pid mediumint(10) NOT NULL default '0',
  msg_id mediumint(10) NOT NULL auto_increment,
  msg_author varchar(25) NOT NULL default '',
  msg_body text NOT NULL,
  msg_date datetime NOT NULL default '0000-00-00 00:00:00',
  msg_raw_ip tinytext,
  msg_hdr_ip tinytext,
  author_md5_id varchar(32) NOT NULL default '',
  author_id int(11) NOT NULL default '0',
  approval enum('YES','NO') NOT NULL default 'YES',
  spam enum('YES','NO') NOT NULL default 'NO',
  PRIMARY KEY  (msg_id),
  KEY com_pic_id (pid)
) TYPE=MyISAM COMMENT='Used to store comments made on pics';
# --------------------------------------------------------

#
# Table structure for table CPG_config
#
CREATE TABLE CPG_config (
  name varchar(40) NOT NULL default '',
  value varchar(255) NOT NULL default '',
  PRIMARY KEY  (name)
) TYPE=MyISAM COMMENT='Used to store the configuration options';
# --------------------------------------------------------


#
# Table structure for table CPG_dict
#
CREATE TABLE CPG_dict (
  keyId bigint(20) NOT NULL auto_increment,
  keyword varchar(60) NOT NULL,
  PRIMARY KEY  (keyId),
  UNIQUE KEY (keyword)
) TYPE=MyISAM COMMENT='Holds the keyword dictionary';
# --------------------------------------------------------

#
# Table structure for table CPG_ecards
#
CREATE TABLE CPG_ecards (
  eid int(11) NOT NULL auto_increment,
  sender_name varchar(50) NOT NULL default '',
  sender_email text NOT NULL,
  recipient_name varchar(50) NOT NULL default '',
  recipient_email text NOT NULL,
  link text NOT NULL,
  date tinytext NOT NULL,
  sender_ip tinytext NOT NULL,
  PRIMARY KEY  (eid)
) TYPE=MyISAM COMMENT='Used to log ecards';
# --------------------------------------------------------

#
# Table structure for table CPG_exif
#
CREATE TABLE CPG_exif (
  `pid` int(11) NOT NULL,
  `exifData` text NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=MyISAM COMMENT='Stores EXIF data from individual pics';
# --------------------------------------------------------

#
# Table structure for table CPG_favpics
#
CREATE TABLE CPG_favpics (
`user_id` INT( 11 ) NOT NULL ,
`user_favpics` TEXT NOT NULL ,
PRIMARY KEY ( `user_id` )
) TYPE = MyISAM COMMENT = 'Stores the server side favourites';
# --------------------------------------------------------

#
# Table structure for table CPG_filetypes
#
CREATE TABLE IF NOT EXISTS CPG_filetypes (
  extension char(7) NOT NULL default '',
  mime char(254) default NULL,
  content char(15) default NULL,
  player varchar(5) default NULL,
  PRIMARY KEY (extension)
) TYPE=MyISAM COMMENT='Used to store the file extensions';
# --------------------------------------------------------

#
# Table structure for table CPG_hit_stats
#
CREATE TABLE CPG_hit_stats (
  `sid` int(11) NOT NULL auto_increment,
  `pid` varchar(100) NOT NULL default '',
  `ip` varchar(20) NOT NULL default '',
  `search_phrase` varchar(255) NOT NULL default '',
  `sdate` bigint(20) NOT NULL default '0',
  `referer` text NOT NULL,
  `browser` varchar(255) NOT NULL default '',
  `os` varchar(50) NOT NULL default '',
  `uid` INT(11) NOT NULL default '0',
  PRIMARY KEY  (`sid`)
) TYPE = MyISAM COMMENT='Detailed stats about hits, only used when enabled';
# --------------------------------------------------------

#
# Table structure for table CPG_languages
#
CREATE TABLE CPG_languages (
  lang_id  varchar(40) NOT NULL default '',
  english_name varchar(70) default NULL,
  native_name varchar(70) default NULL,
  custom_name varchar(70) default NULL,
  flag varchar(15) default NULL,
  abbr varchar(15) NOT NULL default '',
  available enum('YES','NO') NOT NULL default 'NO',
  enabled enum('YES','NO') NOT NULL default 'NO',
  complete enum('YES','NO') NOT NULL default 'NO',
  PRIMARY KEY (lang_id)
) TYPE=MyISAM COMMENT='Contains the language file definitions';
# --------------------------------------------------------

#
# Table structure for table CPG_pictures
#
CREATE TABLE CPG_pictures (
  pid int(11) NOT NULL auto_increment,
  aid int(11) NOT NULL default '0',
  filepath varchar(255) NOT NULL default '',
  filename varchar(255) NOT NULL default '',
  filesize int(11) NOT NULL default '0',
  total_filesize int(11) NOT NULL default '0',
  pwidth smallint(6) NOT NULL default '0',
  pheight smallint(6) NOT NULL default '0',
  hits int(10) NOT NULL default '0',
  mtime datetime NOT NULL default '0000-00-00 00:00:00' ,
  ctime int(11) NOT NULL default '0',
  owner_id int(11) NOT NULL default '0',
  owner_name varchar(40) NOT NULL default '',
  pic_rating int(11) NOT NULL default '0',
  votes int(11) NOT NULL default '0',
  title varchar(255) NOT NULL default '',
  caption text NOT NULL,
  keywords varchar(255) NOT NULL default '',
  approved enum('YES','NO') NOT NULL default 'NO',
  galleryicon int(11) NOT NULL default '0',
  user1 varchar(255) NOT NULL default '',
  user2 varchar(255) NOT NULL default '',
  user3 varchar(255) NOT NULL default '',
  user4 varchar(255) NOT NULL default '',
  url_prefix tinyint(4) NOT NULL default '0',
#  randpos int(11) NOT NULL default '0',
  pic_raw_ip tinytext,
  pic_hdr_ip tinytext,
  lasthit_ip tinytext,
  PRIMARY KEY  (pid),
  KEY owner_id (owner_id),
  KEY pic_hits (hits),
  KEY pic_rate (pic_rating),
  KEY aid_approved (aid,approved),
#  KEY randpos (randpos),
  KEY pic_aid (aid),
  position INT(11) NOT NULL default '0',
  FULLTEXT KEY search (title,caption,keywords,filename)
) TYPE=MyISAM COMMENT='Used to store data about individual pics';
# --------------------------------------------------------

#
# Table structure for table CPG_plugins
#
CREATE TABLE CPG_plugins (
  plugin_id int(10) unsigned NOT NULL auto_increment,
  name varchar(64) NOT NULL default '',
  path varchar(128) NOT NULL default '',
  priority int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (plugin_id),
  UNIQUE KEY name (name),
  UNIQUE KEY path (path)
) TYPE=MyISAM COMMENT='Stores the plugins';
# --------------------------------------------------------

#
# Table structure for table CPG_sessions
#
CREATE TABLE CPG_sessions (
  session_id varchar(40) NOT NULL default '',
  user_id int(11) default '0',
  time int(11) default NULL,
  remember int(1) default '0',
  PRIMARY KEY (session_id)
) TYPE=MyISAM COMMENT='Used to store sessions';
# --------------------------------------------------------

#
# Table structure for table CPG_temp_data
#
CREATE TABLE IF NOT EXISTS CPG_temp_data (
`unique_ID` CHAR( 8 ) NOT NULL ,
`encoded_string` BLOB NOT NULL ,
`timestamp` INT( 11 ) UNSIGNED NOT NULL ,
PRIMARY KEY ( `unique_ID` )
) TYPE = MyISAM COMMENT = 'Holds temporary file data for multiple file uploads';
# --------------------------------------------------------

#
# Table structure for table CPG_temp_messages
#
CREATE TABLE CPG_temp_messages (
  message_id varchar(80) NOT NULL default '',
  user_id int(11) default '0',
  time int(11) default NULL,
  message text NOT NULL,
  PRIMARY KEY (message_id)
) TYPE=MyISAM COMMENT='Used to store messages from one page to the other';
# --------------------------------------------------------


#
# Table structure for table CPG_usergroups
#
CREATE TABLE CPG_usergroups (
  group_id int(11) NOT NULL auto_increment,
  group_name varchar(255) NOT NULL default '',
  group_quota int(11) NOT NULL default '0',
  has_admin_access tinyint(4) NOT NULL default '0',
  can_rate_pictures tinyint(4) NOT NULL default '0',
  can_send_ecards tinyint(4) NOT NULL default '0',
  can_post_comments tinyint(4) NOT NULL default '0',
  can_upload_pictures tinyint(4) NOT NULL default '0',
  can_create_albums tinyint(4) NOT NULL default '0',
  pub_upl_need_approval tinyint(4) NOT NULL default '1',
  priv_upl_need_approval tinyint(4) NOT NULL default '1',
  upload_form_config tinyint(4) NOT NULL default '3',
  custom_user_upload tinyint(4) NOT NULL default '0',
  num_file_upload tinyint(4) NOT NULL default '1',
  num_URI_upload tinyint(4) NOT NULL default '0',
  access_level tinyint(4) NOT NULL default '3',
  PRIMARY KEY  (group_id)
) TYPE=MyISAM;
# --------------------------------------------------------

#
# Table structure for table CPG_users
#
CREATE TABLE CPG_users (
  user_id int(11) NOT NULL auto_increment,
  user_group int(11) NOT NULL default '2',
  user_active enum('YES','NO') NOT NULL default 'NO',
  user_name varchar(25) NOT NULL default '',
  user_password varchar(40) NOT NULL default '',
  user_lastvisit datetime NOT NULL default '0000-00-00 00:00:00',
  user_regdate datetime NOT NULL default '0000-00-00 00:00:00',
  user_group_list varchar(255) NOT NULL default '',
  user_email varchar(255) NOT NULL default '',
  user_profile1 varchar(255) NOT NULL default '',
  user_profile2 varchar(255) NOT NULL default '',
  user_profile3 varchar(255) NOT NULL default '',
  user_profile4 varchar(255) NOT NULL default '',
  user_profile5 varchar(255) NOT NULL default '',
  user_profile6 text NOT NULL,
  user_actkey varchar(32) NOT NULL default '',
  user_language varchar(40) NOT NULL default '',

  PRIMARY KEY  (user_id),
  UNIQUE KEY user_name (user_name)
) TYPE=MyISAM COMMENT='Used to store users, not used when bridged';
# --------------------------------------------------------

#
# Table structure for table CPG_votes
#
CREATE TABLE CPG_votes (
  pic_id mediumint(9) NOT NULL default '0',
  user_md5_id varchar(32) NOT NULL default '',
  vote_time int(11) NOT NULL default '0',
  PRIMARY KEY  (pic_id,user_md5_id)
) TYPE=MyISAM COMMENT='Stores votes for individual pics';
#---------------------------------------------------------

#
# Table structure for table CPG_vote_stats
#
CREATE TABLE CPG_vote_stats (
  `sid` int(11) NOT NULL auto_increment,
  `pid` varchar(100) NOT NULL default '',
  `rating` smallint(6) NOT NULL default '0',
  `ip` varchar(20) NOT NULL default '',
  `sdate` bigint(20) NOT NULL default '0',
  `referer` text NOT NULL,
  `browser` varchar(255) NOT NULL default '',
  `os` varchar(50) NOT NULL default '',
  `uid` INT(11) NOT NULL default '0',
  PRIMARY KEY  (`sid`)
) TYPE=MyISAM COMMENT='Detailed stats about votes, only used when enabled';
# --------------------------------------------------------