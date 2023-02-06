/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.7.19 : Database - survey
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`survey` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `survey`;

/*Table structure for table `activities` */

DROP TABLE IF EXISTS `activities`;

CREATE TABLE `activities` (
  `acid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '发布人',
  `suid` int(11) NOT NULL COMMENT '发布的调查问卷',
  `started_at` datetime NOT NULL COMMENT '开始时间',
  `ended_at` datetime NOT NULL COMMENT '截至时间',
  PRIMARY KEY (`acid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='已发布的调查问卷';

/*Data for the table `activities` */

insert  into `activities`(`acid`,`uid`,`suid`,`started_at`,`ended_at`) values (1,1,1,'2023-01-14 21:30:00','2024-01-14 21:30:00');

/*Table structure for table `questions` */

DROP TABLE IF EXISTS `questions`;

CREATE TABLE `questions` (
  `quid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '题目创建人',
  `question` varchar(200) NOT NULL COMMENT '题目',
  `options` text NOT NULL COMMENT '选项的 JSON 串，必须是数组',
  PRIMARY KEY (`quid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='题库中的题目，仅支持 4 个选项的单选题';

/*Data for the table `questions` */

insert  into `questions`(`quid`,`uid`,`question`,`options`) values (1,1,'答案是A','[\"A\",\"B\",\"C\",\"D\"]'),(2,1,'建议选B','[\"A\",\"B\",\"C\",\"D\"]'),(3,1,'测试题目','[\"1\",\"23\",\"45\",\"6\"]'),(4,1,'颜色','[\"黄\",\"绿\",\"黑\",\"白\"]'),(5,1,'体型','[\"胖\",\"瘦\",\"不胖不瘦\",\"小\"]'),(6,1,'种类','[\"加菲\",\"英短\",\"肥猫\",\"无毛猫\"]');

/*Table structure for table `results` */

DROP TABLE IF EXISTS `results`;

CREATE TABLE `results` (
  `resid` int(11) NOT NULL AUTO_INCREMENT,
  `acid` int(11) NOT NULL COMMENT '调查活动',
  `nickname` varchar(100) NOT NULL COMMENT '被调查人称谓',
  `phone` varchar(20) NOT NULL COMMENT '被调查人电话',
  `gender` int(11) NOT NULL COMMENT '被调查人性别 1 是 男；2 是 女',
  `age` int(11) NOT NULL COMMENT '被调查人年龄',
  `answer` text NOT NULL COMMENT '被调查人的回答',
  PRIMARY KEY (`resid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='调查结果';

/*Data for the table `results` */

insert  into `results`(`resid`,`acid`,`nickname`,`phone`,`gender`,`age`,`answer`) values (1,1,'zzz','13911111111',1,22,'{}');

/*Table structure for table `survey_question_relations` */

DROP TABLE IF EXISTS `survey_question_relations`;

CREATE TABLE `survey_question_relations` (
  `sqrid` int(11) NOT NULL AUTO_INCREMENT,
  `suid` int(11) NOT NULL COMMENT '调查问卷',
  `quid` int(11) NOT NULL COMMENT '题目',
  PRIMARY KEY (`sqrid`),
  UNIQUE KEY `suid` (`suid`,`quid`) COMMENT '一份调查问卷不能出现相同的一道题'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='调查问卷和题目的绑定关系';

/*Data for the table `survey_question_relations` */

insert  into `survey_question_relations`(`sqrid`,`suid`,`quid`) values (3,1,4),(4,1,5),(5,1,6);

/*Table structure for table `surveys` */

DROP TABLE IF EXISTS `surveys`;

CREATE TABLE `surveys` (
  `suid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '调查问卷创建人',
  `title` varchar(200) NOT NULL COMMENT '标题',
  `brief` varchar(400) NOT NULL COMMENT '背景介绍',
  PRIMARY KEY (`suid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='未发布的调查问卷';

/*Data for the table `surveys` */

insert  into `surveys`(`suid`,`uid`,`title`,`brief`) values (1,1,'你喜欢什么猫','动物题目');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(60) NOT NULL,
  `password` char(60) NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='系统用户，不包括填写调查问卷的人';

/*Data for the table `users` */

insert  into `users`(`uid`,`username`,`password`) values (1,'admin','$2a$10$UmX/FpBH1rhRz1U51WDpI.Vc0P5cMUKx4/L36BMeMRQhAaRJYD1jS');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
