use ig_clone;
-- 1.Create an ER diagram or draw a schema for the given database.--

     -- > The ER diagram is neatly drawn ,took photograph of it and attached with the archive file ( mandatory project ) --

-- 2. We want to reward the user who has been around the longest, Find the 5 oldest users --

select * 
from ig_clone.users 
order by created_at asc 
limit 5;

-- 3.To understand when to run the ad campaign, figure out the day of the week most users register on? -- 

select dayname(created_at) as Day,count(*) as Day_count 
FROM IG_CLONE.USERS 
group by 1 
having Day_count = '16' 
order by 2 desc;

-- 4.To target inactive users in an email ad campaign, find the users who have never posted a photo.--

select u.id , u.username as Inactive_Customers  
from users u left join photos p on u.id=p.user_id 
where p.image_url is null 
order by 1;

-- 5.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won -- 

select u.username,u.id ,count(l.user_id) as Number_of_likes 
from users u join photos p on u.id=p.user_id 
join likes l on u.id=l.user_id 
group by u.id 
order by 3 desc 
limit 1;

-- 6.The investors want to know how many times does the average user post.--

select
count(*) / count(distinct user_id) as Average_user_Posts,
count(distinct user_id) as Total_posted_users
from photos;

-- 7.A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.--

select tag_name,count(*) as Times_of_usage 
from tags t join photo_tags pt on t.id=pt.tag_id 
group by tag_name 
order by 2 desc 
limit 5;

-- 8.To find out if there are bots, find users who have liked every single photo on the site. --

select u.username,l.user_id,count(*) as number_of_likes 
from users u join likes l on u.id=l.user_id 
group by 2 having Number_of_likes = 
'257' order by 3 desc;

-- 9.To know who the celebrities are, find users who have never commented on a photo. --

select * from users u left join comments c on u.id=c.user_id
where c.comment_text is null ;

-- 10.Now it's time to find both of them together, 
-- find the users who have never commented on any photo or have commented on every photo. -- 

select u.username,c.user_id,count(*) as No_of_Comments 
from users u left join comments c on u.id=c.user_id
where c.comment_text is null group by 1 
union all 
select u.username,c.user_id,count(*) as No_of_Comments 
from users u left join comments c on u.id=c.user_id 
group by 1 HAVING No_of_comments='257' order by 3 desc ;