/* Table structure for table `access` */

CREATE TABLE IF NOT EXISTS `{:prefix}access` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`access_level_id` INT(11) NOT NULL,
	`user_id` INT(11) NOT NULL,
	`created` DATETIME DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `access_level_id` (`access_level_id`),
	KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Users with certain access' AUTO_INCREMENT=1;

/* Table structure for table `access_levels` */

CREATE TABLE IF NOT EXISTS `{:prefix}access_levels` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(30) NOT NULL,
	`level` INT(11) NOT NULL,
	`is_admin` SMALLINT(6) NOT NULL DEFAULT '0',
	`is_super` SMALLINT(6) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Access levels for users' AUTO_INCREMENT=1;

INSERT INTO `{:prefix}access_levels` (`id`, `title`, `level`, `is_admin`, `is_super`) VALUES
	(1, 'Member', 1, 0, 0),
	(2, 'Moderator', 4, 0, 0),
	(3, 'Super Moderator', 7, 0, 1),
	(4, 'Administrator', 10, 1, 1);

/* Table structure for table `forums` */

CREATE TABLE IF NOT EXISTS `{:prefix}forums` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`access_level_id` SMALLINT(6) NOT NULL DEFAULT '0',
	`title` VARCHAR(50) NOT NULL,
	`slug` VARCHAR(60) NOT NULL,
	`status` SMALLINT(6) NOT NULL DEFAULT '0',
	`orderNo` SMALLINT(6) NOT NULL DEFAULT '0',
	`accessView` SMALLINT(6) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`),
	KEY `access_level_id` (`access_level_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Containing forums' AUTO_INCREMENT=1;

INSERT INTO `{:prefix}forums` (`id`, `access_level_id`, `title`, `slug`, `status`, `orderNo`, `accessView`) VALUES
	(1, 0, 'Cupcake Forums', 'cupcake-forums', 0, 1, 0);

/* Table structure for table `forum_categories` */

CREATE TABLE IF NOT EXISTS `{:prefix}forum_categories` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`forum_id` INT(11) NOT NULL,
	`parent_id` INT(11) NOT NULL DEFAULT '0',
	`access_level_id` SMALLINT(6) NOT NULL DEFAULT '0',
	`title` VARCHAR(50) NOT NULL,
	`slug` VARCHAR(60) NOT NULL,
	`description` VARCHAR(255) NOT NULL,
	`status` SMALLINT(6) NOT NULL DEFAULT '0',
	`orderNo` SMALLINT(6) NOT NULL DEFAULT '0',
	`topic_count` INT(11) NOT NULL DEFAULT '0',
	`post_count` INT(11) NOT NULL DEFAULT '0',
	`accessRead` SMALLINT(6) NOT NULL DEFAULT '0',
	`accessPost` SMALLINT(6) NOT NULL DEFAULT '1',
	`accessReply` SMALLINT(6) NOT NULL DEFAULT '1',
	`accessPoll` SMALLINT(6) NOT NULL DEFAULT '1',
	`settingPostCount` SMALLINT(6) NOT NULL DEFAULT '1',
	`settingAutoLock` SMALLINT(6) NOT NULL DEFAULT '1',
	`lastTopic_id` INT(11) NOT NULL DEFAULT '0',
	`lastPost_id` INT(11) NOT NULL DEFAULT '0',
	`lastUser_id` INT(11) NOT NULL DEFAULT '0',
	`created` DATETIME DEFAULT NULL,
	`modified` DATETIME DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `lastTopic_id` (`lastTopic_id`),
	KEY `lastPost_id` (`lastPost_id`),
	KEY `lastUser_id` (`lastUser_id`),
	KEY `forum_id` (`forum_id`),
	KEY `parent_id` (`parent_id`),
	KEY `access_level_id` (`access_level_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Forum categories to post topics to' AUTO_INCREMENT=1;

INSERT INTO `{:prefix}forum_categories` (`id`, `forum_id`, `parent_id`, `access_level_id`, `title`, `slug`, `description`, `status`, `orderNo`, `topic_count`, `post_count`, `accessRead`, `accessPost`, `accessReply`, `accessPoll`, `settingPostCount`, `settingAutoLock`, `lastTopic_id`, `lastPost_id`, `lastUser_id`, `created`, `modified`) VALUES
	(1, 1, 0, 0, 'General Discussion', 'general-discussion', 'This is a forum category, which is a child of the forum. You can add, edit or delete these categories by visiting the administration panel, but first you would need to give a user admin rights.', 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, NOW(), NOW());

/* Table structure for table `moderators` */

CREATE TABLE IF NOT EXISTS `{:prefix}moderators` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`forum_category_id` INT(11) NOT NULL,
	`user_id` INT(11) NOT NULL,
	`created` DATETIME DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `user_id` (`user_id`),
	KEY `forum_category_id` (`forum_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Moderators to forums' AUTO_INCREMENT=1;

/* Table structure for table `polls` */

CREATE TABLE IF NOT EXISTS `{:prefix}polls` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`topic_id` INT(11) NOT NULL,
	`created` DATETIME DEFAULT NULL,
	`modified` DATETIME DEFAULT NULL,
	`expires` DATETIME DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `topic_id` (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Polls attached to topics' AUTO_INCREMENT=1;

/* Table structure for table `poll_options` */

CREATE TABLE IF NOT EXISTS `{:prefix}poll_options` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`poll_id` INT(11) NOT NULL,
	`option` VARCHAR(100) NOT NULL,
	`vote_count` INT(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`),
	KEY `poll_id` (`poll_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Options/Questions for a poll' AUTO_INCREMENT=1;

/* Table structure for table `poll_votes` */

CREATE TABLE IF NOT EXISTS `{:prefix}poll_votes` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`poll_id` INT(11) NOT NULL,
	`poll_option_id` INT(11) NOT NULL,
	`user_id` INT(11) NOT NULL,
	PRIMARY KEY (`id`),
	KEY `poll_id` (`poll_id`),
	KEY `poll_option_id` (`poll_option_id`),
	KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Votes for polls' AUTO_INCREMENT=1;

/* Table structure for table `posts` */

CREATE TABLE IF NOT EXISTS `{:prefix}posts` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`topic_id` INT(11) NOT NULL,
	`user_id` INT(11) NOT NULL,
	`userIP` VARCHAR(100) NOT NULL,
	`content` text NOT NULL,
	`created` DATETIME DEFAULT NULL,
	`modified` DATETIME DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `topic_id` (`topic_id`),
	KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Posts to topics' AUTO_INCREMENT=1;

/* Table structure for table `reported` */

CREATE TABLE IF NOT EXISTS `{:prefix}reported` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`item_id` INT(11) NOT NULL,
	`itemType` VARCHAR(15) NOT NULL,
	`user_id` INT(11) NOT NULL,
	`comment` VARCHAR(255) NOT NULL,
	`created` DATETIME DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `item_id` (`item_id`),
	KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reported topics, posts, users, etc' AUTO_INCREMENT=1;

/* Table structure for table `topics` */

CREATE TABLE IF NOT EXISTS `{:prefix}topics` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`forum_category_id` INT(11) NOT NULL,
	`user_id` INT(11) NOT NULL,
	`title` VARCHAR(100) NOT NULL,
	`slug` VARCHAR(110) NOT NULL,
	`status` SMALLINT(6) NOT NULL DEFAULT '0',
	`type` SMALLINT(6) NOT NULL DEFAULT '0',
	`post_count` INT(11) NOT NULL DEFAULT '0',
	`view_count` INT(11) NOT NULL DEFAULT '0',
	`firstPost_id` INT(11) NOT NULL,
	`lastPost_id` INT(11) NOT NULL,
	`lastUser_id` INT(11) NOT NULL,
	`created` DATETIME DEFAULT NULL,
	`modified` DATETIME DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `user_id` (`user_id`),
	KEY `firstPost_id` (`firstPost_id`),
	KEY `lastPost_id` (`lastPost_id`),
	KEY `lastUser_id` (`lastUser_id`),
	KEY `forum_category_id` (`forum_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Discussion topics' AUTO_INCREMENT=1;

/* Table structure for table `topics` */

CREATE TABLE IF NOT EXISTS `{:prefix}settings` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`key` VARCHAR(50) NOT NULL,
	`value` VARCHAR(100) NOT NULL,
	`modified` DATETIME DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Forum settings' AUTO_INCREMENT=1;

INSERT INTO `{:prefix}settings` (`id`, `key`, `value`, `modified`) VALUES
	(NULL, 'site_name', 'CakePHP Forum Plugin', NOW()),
	(NULL, 'site_email', 'noreply@example.com', NOW()),
	(NULL, 'site_main_url', 'http://example.com', NOW()),
	(NULL, 'topics_per_page', 20, NOW()),
	(NULL, 'topics_per_hour', 3, NOW()),
	(NULL, 'topic_flood_interval', 300, NOW()),
	(NULL, 'topic_pages_till_truncate', 10, NOW()),
	(NULL, 'posts_per_page', 15, NOW()),
	(NULL, 'posts_per_hour', 15, NOW()),
	(NULL, 'posts_till_hot_topic', 35, NOW()),
	(NULL, 'post_flood_interval', 60, NOW()),
	(NULL, 'days_till_autolock', 21, NOW()),
	(NULL, 'whos_online_interval', 15, NOW()),
	(NULL, 'security_question', 'What framework does this plugin run on?', NOW()),
	(NULL, 'security_answer', 'cakephp', NOW()),
	(NULL, 'enable_quick_reply', 1, NOW()),
	(NULL, 'enable_gravatar', 1, NOW()),
	(NULL, 'censored_words', '', NOW()),
	(NULL, 'default_locale', 'eng', NOW()),
	(NULL, 'default_timezone', '-8', NOW()),
	(NULL, 'title_separator', ' &raquo; ', NOW());
