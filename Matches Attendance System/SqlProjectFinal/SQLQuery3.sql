select * from Stadium
select * from match
select * from HostRequest
select * from fan
select * from ticket
select * from match
select * from dbo.xxx('1 / 1 / 2000 8:05:00 PM')

--me
go
create procedure addHostRequestWithRepUserName
@clubRepUsername varchar(20),
@stadiumName varchar(20),
@startdate datetime
as
declare @clubid int
select @clubid=club_ID from ClubRepresentative where username=@clubRepUsername

declare @stadId int
select @stadId=id from Stadium where name=@stadiumName

declare @representativeClubId int
select @representativeClubId =c.id from ClubRepresentative c
where c.club_ID=@clubid

declare @managerID int
select @managerID =s.id from StaduimManager s where s.stadium_id=@stadId

declare @matchid int
select @matchid = match_id from match where @startdate=start_time
and @clubid=host_club_ID

insert into HostRequest (representative_id,manager_id,match_id,status) values(
@representativeClubId,@managerID,@matchid,null)
go

go              
create function getSpeceficMatchesAdd
(@clubName varchar(20),@startTime datetime)
returns table
return select * from match m inner join club c 
on (m.guest_club_id = c.club_ID  or m.host_club_ID=c.club_ID)
 where @clubName=c.name and m.start_time <= @startTime and m.end_time >= @startTime
 go
create function getSpeceficMatchesDelete
(@hostClub varchar(20),@guestClub varchar(20),@startTime datetime,@endTime datetime)
returns table
return select m.* from match m inner join club hostc 
on (m.host_club_ID=hostc.club_ID)
inner join club guestc on guestc.club_ID=m.guest_club_id
where @hostClub=hostc.name and @guestClub=guestc.name and m.start_time = @startTime and m.end_time = @endTime
 go






go
create function upcomingMatchesOfClub2
(@RepUsername varchar(20))
returns table
return select c.name ClubName , c2.name CompetingClubName, m.start_time,m.end_time,s.name StadiumName
from match m inner join club c 
on (m.guest_club_id = c.club_ID  or m.host_club_ID=c.club_ID)
 left outer join Stadium s on s.id = m.stadium_ID
 inner join club c2 on (c2.club_ID =m.guest_club_id and c.club_ID<>m.guest_club_id) 
 or (c2.club_ID =m.host_club_ID and c.club_ID<>m.host_club_ID)
 inner join ClubRepresentative cr on cr.club_ID=c.club_ID
 where @RepUsername=cr.username and m.start_time > CURRENT_TIMESTAMP 
 go



go
create function getStadium
(@usernameManager varchar(20))
returns table
return 
select s.id,s.name,s.location,s.capacity,s.status from stadium s inner join StaduimManager sm on (sm.stadium_id=s.id)
where sm.username=@usernameManager
go
go
create function getRequest
(@usernameManager varchar(20))
returns table
return 
select hr.id RequestID, sm.name representativeUserName ,c1.name HostClubName,
c2.name GuestClubName ,m.start_time StartTime ,
m.end_time EndTime ,hr.status Status
from HostRequest hr inner join StaduimManager sm 
on sm.id=hr.manager_id inner join match m
on m.match_ID=hr.match_id  inner join club c1 on c1.club_ID=m.host_club_ID
inner join club c2 on c2.club_ID=m.guest_club_id
where sm.username=@usernameManager
go
--------



--------Yousefffff



create view allMatchesplayed as
select
c2.name host_competing_club,	
c1.name guest_competing_club,
m.start_time,m.end_time
from match m inner join club c1 on m.guest_club_id=c1.club_ID
inner join club c2 on m.host_club_ID=c2.club_ID where m.end_time<CURRENT_TIMESTAMP
go
create view allMatchesnotplayed as
select
c2.name host_competing_club,	
c1.name guest_competing_club,
m.start_time,m.end_time
from match m inner join club c1 on m.guest_club_id=c1.club_ID
inner join club c2 on m.host_club_ID=c2.club_ID where m.start_time>CURRENT_TIMESTAMP
go

create proc deleteMatchnew
@hostClub varchar(20),
@guestClub varchar(20),
@stime datetime,
@etime datetime

as
begin
declare @HostId int
select @HostId = club_id  from club where name=@hostClub

declare @guestId int
select @guestId = club_id from club where name=@guestClub


delete from HostRequest where match_id in(select m.match_id from match m where m.host_club_ID=@HostId and 
m.guest_club_id = @guestId)
delete from match where host_club_ID=@HostId and guest_club_id=@guestId and start_time=@stime and end_time=@etime
end
go
------------------




select * from fan
--mohamed hassan
go 
create proc mohamedPurchaseTicket
@userName varchar(20),
@hostName varchar(20),
@guestName varchar(20),
@startTime datetime
as
declare @IDuser varchar(20)
select @IDuser=f.nationalID  from Fan f where @userName=f.username
exec purchaseTicket @IDuser,@hostName,@guestName,@startTime
go
drop function xxx
select * from match
select * from stadium

select * from dbo.xxx('01012000 12:00:00 pm')
go
 create function xxx
 (@startTime datetime)
returns table
return select c1.name hostClubName , c2.name guestClubName ,m.start_time , s.name Stadiumname,s.location Stadiumlocation
from match m
inner join Stadium s on m.stadium_ID = s.id
inner join Club c1 on c1.club_ID = m.host_club_ID
inner join Club c2 on c2.club_ID = m.guest_club_id 
where m.start_time >= @startTime and exists (select * from ticket where 
status =1 and match_ID=m.match_ID)
go



go
create proc addClub 
@name varchar(20),
@location varchar(20),
@res int output
as
begin
if(@name = '' or @location ='')
begin
 set @res = 1
end
else if( exists(select* from Club c where @name= c.name))
begin
   set @res = 2
end
else 
 begin
   set @res = 3
   insert into club values(@name,@location)
end
end


go
create proc deleteClub
@name varchar(20),
@res int output
as
if(@name='')
begin
    set @res=1
end
else if(not exists(select* from Club c where c.name=@name))
begin
    set @res=2
end
else
begin
  set @res=3
  declare @guestID int
  select @guestID = c.club_ID from Club c where c.name=@name
  delete from match where guest_club_id = @guestID
  delete from club where name=@name
end

-------------------------------------------







------------------------












----~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
exec addAssociationManager 'Mark','Mark02','Mark123'
exec addAssociationManager 'Ramez','Ramez02','Ramez123'
exec addAssociationManager 'Moahmed','Moahmed02','Moahmed123'
exec addAssociationManager 'Youssef','Youssef02','youssef123'

exec addClub 'Ahly','Cairo'
exec addClub 'Zamalek','Geiza'
exec addClub 'Ismaily','Ismaelia'
exec addClub 'Pyramids','Pyramids'

exec addNewMatch 'Ahly','Zamalek','20120618 08:30:00 PM','20120618 10:30:00 PM'
exec addNewMatch 'Zamalek','Ahly','20230618 08:30:00 PM','20230618 10:30:00 PM'
exec addNewMatch 'Zamalek','Ismaily','20200618 08:30:00 PM','20200618 10:30:00 PM'
exec addNewMatch 'Ismaily','Ahly','20240618 08:30:00 PM','20240618 10:30:00 PM'


exec addStadium 'Cairo Stadium','Cairo','65000'
exec addStadium 'Borg el Arab Stadium','Alexandria','80000'
exec addStadium 'Ismaelia Stadium','Ismaelia','45000'

exec addRepresentative 'Mortada Mansour','Zamalek','Mortada1911','Mortada123'
exec addRepresentative 'Mahmoud El Khateeb','Ahly','Khateeb1907','Khateeb123'
exec addRepresentative 'Yehia El Komy','Ismaily','Komy1924','Komy123'


exec addStadiumManager 'Ali Darwish','Cairo Stadium','Darwish','Darwish123'
exec addStadiumManager 'Hamza El Gamal','Ismaelia Stadium','ElGamal','ElGamal123'
exec addStadiumManager 'Youssef Shawky','Borg el Arab Stadium','Shawky','Shawky123'

exec addHostRequest 'Ismaily','Ismaelia Stadium','20240618 08:30:00 PM'
exec addHostRequest 'Zamalek','Cairo Stadium','20200618 08:30:00 PM'
exec addHostRequest 'Zamalek','Cairo Stadium','20230618 08:30:00 PM'
exec addHostRequest 'Zamalek','Cairo Stadium','20230618 08:30:00 PM'

exec acceptRequest 'ElGamal','Ismaily','Ahly','20240618 08:30:00 PM'

exec addFan 'Mahmoud','Housssssssssssssssssssssssssssssssssssssssda','Houda123','120798433310987','20040618 08:30:00 PM','Helwan , Cairo','0122343345'
exec addFan 'Mostafa','Tifa','Tifa123','1207984356723','20000212 08:30:00 PM','Maghagha , AlMenia','012223423'
exec addFan 'Ziad','Zoza','Zoza123','1207984320987','20010618 08:30:00 PM','Helwan , Cairo','01524543345'
----~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

select * from stadium
go
create proc createAllTables
as 
begin
create table SystemUser(username varchar(20),
password varchar(20),
constraint SysetemUse_PK primary key(username));
create table Fan(nationalID varchar(20),
name varchar(20),
brith_date datetime,
address varchar(20),
phone_no int,
status BIT,
username varchar(20),
constraint fan_FK foreign key(username) references SystemUser
on delete cascade
on update cascade
,
constraint fan_PK primary key(nationalID)
)
create table Stadium (
id int  identity(1,1),
name varchar(20),
location varchar(20),
capacity int,
status BIT,
constraint Stadium_PK primary key(id)
)
create table Club(	
club_ID int identity(1,1),
name varchar(20),
location varchar(20),
constraint club_PK primary key(club_ID)
)
create table StaduimManager(
id int IDENTITY(1,1),
name varchar(20),
stadium_id int,
username varchar(20),
constraint staduimManager_PK primary key(id),
constraint staduimManager_FK1 foreign key(username)  
references SystemUser
on delete cascade
on update cascade
,
constraint staduimManager_FK2 foreign key(stadium_id)  
references stadium
on delete cascade
on update cascade
)
create table ClubRepresentative(
id int identity(1,1),
name varchar(20),
club_ID int,
username varchar(20),
constraint ClubRepresentative_PK primary key(id),
constraint ClubRepresentative_FK1 foreign key(club_ID)
references Club
on delete cascade
on update cascade
,
constraint ClubRepresentative_FK2 foreign key(username)
references SystemUser
on delete cascade
on update cascade
) 
create table SportsAssociationManager(
id int identity(1,1),
name varchar(20),
username varchar(20),
constraint SportsAssociationManager_PK primary key(id),
constraint SportsAssociationManager_FK foreign key(username)
references SystemUser
on delete cascade
on update cascade
)
create table SysetemAdmin(id int identity(1,1),
name varchar(20),
username varchar(20),
constraint SysetemAdmin_PK primary key(id),
constraint SysetemAdmin_FK foreign key(username)
references SystemUser
on delete cascade
on update cascade
)
create table match(
match_ID int  identity(1,1),
start_time datetime,
end_time datetime,
host_club_ID int,
guest_club_id int,
stadium_ID int,
constraint match_PK primary key(match_ID),
constraint match_FK1 foreign key(host_club_ID)
references club
on delete cascade
on update cascade
,
constraint match_FK2 foreign key(guest_club_ID)
references club
on delete no action
on update no action
,
constraint match_FK3 foreign key(stadium_ID)
references Stadium
on delete cascade
on update cascade
)
create table ticket (
id int identity(1,1),
status BIT,
match_ID int,
constraint ticket_PK primary key(id),
constraint ticket_FK foreign key(match_ID)
references match
on delete cascade
on update cascade
)
create table TicketBuyingTransactions(
fan_nationalID varchar(20),
ticket_ID int,
constraint TicketBuyingTransactions_FK1 foreign key(fan_nationalID)
references Fan
on delete cascade
on update cascade
,
constraint TicketBuyingTransactions_FK2 foreign key(ticket_ID)
references Ticket
on delete cascade
on update cascade
,
constraint TicketBuyingTransactions_PK primary key(
fan_nationalID,ticket_ID
))
create table HostRequest (
id int identity(1,1),
representative_id int,
manager_id int,
match_id int,
status bit,
constraint HostRequest_PK primary key(id),
constraint HostRequest_FK1 foreign key(representative_id)
references ClubRepresentative
on delete cascade
on update cascade
,
constraint HostRequest_FK2 foreign key(manager_id)
references StaduimManager on delete no action
on update no action

,
constraint HostRequest_FK3 foreign key(match_id)
references Match on delete no action
on update no action

)
end
go
create proc dropAllTables as
begin
drop table HostRequest
drop table TicketBuyingTransactions;
drop table ticket;
drop table match;
drop table SysetemAdmin;
drop table SportsAssociationManager;
drop table ClubRepresentative;
drop table StaduimManager;
drop table Club;
drop table Stadium ;
drop table Fan;
drop table SystemUser;
end



go 
create proc dropAllProceduresFunctionsViews 
as
begin
drop proc createAllTables;
drop proc dropAllTables;
drop proc clearAllTables;
drop view allAssocManagers;
drop view allClubRepresentatives;
drop view allStadiumManagers;
drop view allFans;
drop view allMatches;
drop view allTickets;
drop view allCLubs;
drop view allStadiums;
drop view allRequests;
drop proc addAssociationManager;
drop proc addNewMatch;
drop view clubsWithNoMatches;
drop proc deleteMatch;
drop proc deleteMatchesOnStadium;
drop proc addClub;
drop proc addTicket;
drop proc deleteClub;
drop proc addStadium;
drop proc deleteStadium;
drop proc blockFan;
drop proc unblockFan;
drop proc addRepresentative;
drop function viewAvailableStadiumsOn;
drop proc addHostRequest;
drop function allUnassignedMatches;
drop proc addStadiumManager;
drop function allPendingRequests;
drop proc acceptRequest;
drop proc rejectRequest;
drop proc addFan;
drop function upcomingMatchesOfClub;
drop function availableMatchesToAttend;
drop proc purchaseTicket;
drop proc updateMatchHost;
drop view matchesPerTeam;
drop view clubsNeverMatched;
drop function clubsNeverPlayed;
drop function matchWithHighestAttendance;
drop function matchesRankedByAttendance;
drop function requestsFromClub;
end
go
go
create proc clearAllTables as
begin
delete from HostRequest
delete from TicketBuyingTransactions
delete from ticket
delete from match
delete from ClubRepresentative
delete from StaduimManager
delete from Club
delete from Stadium
delete from Fan
delete from SportsAssociationManager
delete from SysetemAdmin
delete from SystemUser
end
go



--2.2 a
go
create view allAssocManagers as 
select s.username,u.password,s.name from 
SportsAssociationManager s inner join SystemUser u on s.username=u.username
go
--2.2 b
go
create view allClubRepresentatives as
select r.username,u.password,r.name representativeName,c.name clubName
from ClubRepresentative r inner join Club c on r.club_ID=c.club_ID
inner join SystemUser u on u.username=r.username
go
--2.2 c
go
create view allStadiumManagers as 
select s.username,u.password,s.name stadiumMangerName,st.name stadiumName
from StaduimManager s inner join Stadium st on s.stadium_id=st.id
inner join SystemUser u on u.username = s.username
go

--2.2 d
create view allFans as
select u.username,u.password,f.name,f.nationalID,f.brith_date,f.status
from Fan f
inner join SystemUser u on u.username=f.username

--2.2 e
go
create view allMatches as
select
c2.name host_competing_club,	
c1.name guest_competing_club,
m.start_time
from match m inner join club c1 on m.guest_club_id=c1.club_ID
inner join club c2 on m.host_club_ID=c2.club_ID
go

--2.2 f
create view allTickets as 
select 
c2.name host_competing_club,
c1.name guest_competing_club,	
s.name Stadium_Name,
m.start_time
from ticket t
inner join match m on t.match_ID=m.match_ID
inner join club c1 on m.guest_club_id=c1.club_ID
inner join club c2 on m.host_club_ID=c2.club_ID
inner join Stadium s on s.id=m.stadium_ID



--2.2 g
go
create view allCLubs
as 
select c.name,c.location
from club c



--2.2 h
go 
create view allStadiums
as 
select s.name,s.location,s.capacity,s.status
from Stadium s

--2.2 i
go
create view allRequests
as 
select c.username representativeUserName , s.username managerUserrName, h.status
from HostRequest h inner join ClubRepresentative c on  
h.representative_id = c.id inner join SportsAssociationManager s on h.manager_id =s.id

--2.3 i 
go
create procedure addAssociationManager 
@name varchar(20),
@username varchar(20),
@password varchar(20)
as
begin
insert into SystemUser(Username ,password) values(@username,@password)
insert into SportsAssociationManager (name,username) values(@name,@username)
end

--2.3 ii
go
create procedure addNewMatch 
@hostclub varchar(20),
@guestClub varchar(20),
@startTime datetime,
@endTime datetime
as
begin
declare @hostClubId int 
select @hostClubId=club_id from club where name=@hostclub
declare @guestclubid int
select @guestClubid=club_ID from club where name=@guestClub
insert into match (start_time,end_time,host_club_ID,guest_club_id) 
values (@startTime,@endTime,@HostClubId,@guestclubid)
end

--2.3 iii
go 
create view clubsWithNoMatches 
as 
select *
from Club c
where not exists (select * from match m where m.guest_club_id=c.club_ID or m.host_club_ID=c.club_ID )

--2.3 iv
go
create proc deleteMatch
@hostClub varchar(20),
@guestClub varchar(20)
as
begin
declare @HostId int
select @HostId = club_id  from club where name=@hostClub

declare @guestId int
select @guestId = club_id from club where name=@guestClub


delete from HostRequest where match_id in(select m.match_id from match m where m.host_club_ID=@HostId and 
m.guest_club_id = @guestId)
delete from match where host_club_ID=@HostId and guest_club_id=@guestId
end
go
--2.3 v

go
create proc deleteMatchesOnStadium 
@stadName varchar(20)
as
begin
declare @matchID int
declare @stadId int
select @stadId=id  from Stadium where name=@stadName
delete from HostRequest where match_id in (select m.match_id from match m where  stadium_ID=@stadId
and CURRENT_TIMESTAMP<start_time )
delete from match where  match_id in (select match_id from match where  stadium_ID=@stadId
and CURRENT_TIMESTAMP<start_time )
end

--2.3 vi
go
create proc addClub 
@name varchar(20),
@location varchar(20)
as
begin
insert into club values(@name,@location)
end



--2.3 vii
go
create proc addTicket 
@hostname varchar(20),
@guestname varchar(20),
@startTime datetime
as
begin
declare @HostClubId int
select @HostClubId = club_id  from club where name=@hostname

declare @GuestClubId int
select @GuestClubId = club_id from club where name=@guestname

declare @MatchId int
select @MatchId =match_ID from match where guest_club_id=@GuestClubId and host_club_ID=@HostClubId
and start_time=@startTime

declare @status BIT=1
insert into ticket values(@status,@MatchId)

end



--2.3 viii
go
create proc deleteClub
@name varchar(20)
as
declare @guestID int
select @guestID = c.club_ID from Club c where c.name=@name
delete from match where guest_club_id = @guestID
delete from club where name=@name




--2.3 ix
go
create proc addStadium
@name varchar(20),
@location varchar(20),
@capacity int
as 
begin
insert into Stadium values(@name,@location,@capacity,1);

end



--2.3 x
go
create proc deleteStadium
@name varchar(20)
as 
begin
declare @stadID int
select @stadID=ID from Stadium where name=@name
declare @managerID int
select @managerID=ID from StaduimManager where stadium_id=@stadID
delete from HostRequest where manager_id=@managerID
delete from Stadium where name=@name;
end


--2.3 xi
go
create proc blockFan
@ID varchar(20)
as
begin
update Fan 
set status =0 where nationalID = @ID
end


--2.3 xii
go
create proc unblockFan
@ID varchar(20)
as
begin
update Fan 
set status =1 where nationalID = @ID
end

--2.3 xiii
go
create proc addRepresentative
@name varchar(20),
@clubName varchar(20),
@username varchar(20),
@password varchar (20)
as
begin
declare @ID int
select @Id=club_ID from club where name=@clubName
insert into SystemUser values(@username,@password)
insert into ClubRepresentative (name,club_ID,username)values(@name,@ID,@username)
end





--2.3 xiv
go
create function viewAvailableStadiumsOn
(@date datetime)
returns  table
return
select  s.name ,s.location,s.capacity 
from Stadium s where not exists( 
select * from match m where m.stadium_ID = s.id  and (m.start_time < @date and @date < m.end_time ) ) 
go
--2.3 xv
go 
create procedure addHostRequest
@clubName varchar(20),
@stadiumName varchar(20),
@startdate datetime
as
declare @clubid int
select @clubid=club_ID from club where name=@clubName

declare @stadId int
select @stadId=id from Stadium where name=@stadiumName

declare @representativeClubId int
select @representativeClubId =c.id from ClubRepresentative c
where c.club_ID=@clubid

declare @managerID int
select @managerID =s.id from StaduimManager s where s.stadium_id=@stadId

declare @matchid int
select @matchid = match_id from match where @startdate=start_time
and @clubid=host_club_ID

insert into HostRequest (representative_id,manager_id,match_id,status) values(
@representativeClubId,@managerID,@matchid,null)
go



--2.3 xvi
go
create function allUnassignedMatches
(@clubName varchar(20))
returns table
return 
select cg.name ,m.start_time from club c1 inner join 
match m on m.host_club_ID=c1.club_ID
inner join club cg on cg.club_id=m.guest_club_id
where m.stadium_ID is null
and @clubName = c1.name
go



--2.3 xvii
go
create proc addStadiumManager(
@name varchar(20),
@stadiumname varchar(20),
@username varchar(20),
@password varchar(20))
as
declare @stadiumId int
select @stadiumId = id from Stadium where name=@stadiumname
insert into SystemUser values(@username,@password)
insert into StaduimManager values(@name,@stadiumId,@username)
go


--2.3 xviii
go
create function allPendingRequests
(@username varchar(20))
returns table
return 
select cr.name clubRerpresentativeName,cg.name clubGuestName,m.start_time from 
StaduimManager sm
inner join HostRequest hr on hr.manager_id=sm.id
inner join match m on m.match_ID=hr.match_id
inner join club cg on cg.club_ID=m.guest_club_id
inner join clubRepresentative cr on cr.id=hr.representative_id
where sm.username=@username
and hr.status is null
go
select * from HostRequest
--2.3 xix  done
select * from Fan where  status = 1 

go
create procedure acceptRequest
@requestId int
as
begin
declare @managerID int
select @managerID = hr.manager_id from HostRequest hr where hr.id=@requestId

declare @matchID int
select @matchID = hr.match_id from HostRequest hr where hr.id=@requestId

declare @representativeID int
select @representativeID =hr.representative_id from HostRequest hr where hr.id=@requestId

declare @hostClubID int 
select @hostClubID = m.host_club_ID from match m where m.match_ID=@matchID

declare @guestClubID int 
select @guestClubID =m.guest_club_id from match m where m.match_ID=@matchID

update HostRequest
set status =1 where representative_id=@representativeID and match_id=@matchID
and manager_id=@managerID

declare @stadiumId int
select @stadiumId=cr.stadium_id  from StaduimManager cr where cr.id=@managerID
update match 
set stadium_ID =@stadiumId where match_ID = @matchID

declare @hostClubName varchar(20)
select @hostClubName=c.club_ID from club c where c.club_ID=@hostClubID
declare @GuestClubName varchar(20)
select @GuestClubName=c.club_ID from club c where c.club_ID=@guestClubID
declare @starttime datetime
select @starttime=m.start_time from match m where m.match_ID=@matchID

declare @capacity int 
select @capacity=capacity from Stadium where id=@stadiumId
print @capacity
declare @i int=0 
while @i<@capacity
begin
insert into ticket values(1,@matchID)
set @i=@i+1
end

end

go
create procedure acceptRequest
@username varchar(20),
@hostClubName varchar(20),
@GuestClubName varchar(20),
@starttime datetime
as
begin
declare @managerID int
select @managerID = id from StaduimManager where username=@username

declare @hostClubID int 
select @hostClubID = Club_ID from Club where name = @hostClubName

declare @guestClubID int 
select @guestClubID = Club_ID from Club where name = @GuestClubName


declare @matchID int
select @matchID =match_id from match where start_time=@starttime and 
host_club_ID=@hostClubID and guest_club_id=@guestClubID

declare @representativeID int
select @representativeID =id from ClubRepresentative where club_ID=@hostClubID

update HostRequest
set status =1 where representative_id=@representativeID and match_id=@matchID
and manager_id=@managerID

declare @stadiumId int
select @stadiumId = s.stadium_id from StaduimManager s where s.username=@username
update match 
set stadium_ID =@stadiumId where match_ID = @matchID

declare @capacity int 
select @capacity=capacity from Stadium where id=@stadiumId
print @capacity
declare @i int=0 
while @i<@capacity
begin
exec addTicket @hostClubName ,@GuestClubName, @starttime
set @i=@i+1
end

end

--2.3 xx done
go
create procedure rejectRequest
@username varchar(20),
@hostClubName varchar(20),
@GuestClubName varchar(20),
@starttime datetime
as
begin
declare @managerID int
select @managerID = id from StaduimManager where username=@username

declare @hostClubID int 
select @hostClubID = Club_ID from Club where name = @hostClubName

declare @guestClubID int 
select @guestClubID = Club_ID from Club where name = @GuestClubName


declare @matchID int
select @matchID =match_id from match where start_time=@starttime and 
host_club_ID=@hostClubID and guest_club_id=@guestClubID

declare @representativeID int
select @representativeID =id from ClubRepresentative where club_ID=@hostClubID

update HostRequest
set status =0 where representative_id=@representativeID and match_id=@matchID
and manager_id=@managerID

end
go

--2.3 xxi  done
go
create procedure addFan
@name varchar(20),
@username varchar(20),
@password  varchar(20),
@nationalID varchar(20),
@birthDate datetime,
@address varchar(20),
@phoneNUmber int
as
begin
insert into SystemUser values(@username,@password)
insert into Fan values(@nationalID,@name,@birthDate,@address,@phoneNUmber,1,@username)
end
go
--2.3 xxii done
go
create function upcomingMatchesOfClub
(@clubName varchar(20))
returns table
return select c.name givenClubName , c2.name CompetingClubName, m.start_time,s.name
from match m inner join club c 
on (m.guest_club_id = c.club_ID  or m.host_club_ID=c.club_ID)
 inner join Stadium s on s.id = m.stadium_ID
 inner join club c2 on (c2.club_ID =m.guest_club_id and c.club_ID<>m.guest_club_id) 
 or (c2.club_ID =m.host_club_ID and c.club_ID<>m.host_club_ID)
 where @clubName=c.name and m.start_time > CURRENT_TIMESTAMP
 go




 --2.3 xxiii  done
 go
 create function availableMatchesToAttend
 (@startTime datetime)
returns table
return select c1.name hostClubName , c2.name guestClubName ,m.start_time , s.name
from match m
inner join Stadium s on m.stadium_ID = s.id
inner join Club c1 on c1.club_ID = m.host_club_ID
inner join Club c2 on c2.club_ID = m.guest_club_id 
where m.start_time >= @startTime and exists (select * from ticket where 
status =1 and match_ID=m.match_ID)
go


--xxiv done
go
create proc purchaseTicket
@nID varchar(20),
@hostName varchar(20),
@guestName varchar(20),
@startTime datetime
as
declare @IDhost int 
declare @IDguest int 
select @IDhost=c.club_ID
from Club c
where @hostName=c.name

select @IDguest=c.club_ID
from Club c
where @guestName=c.name

declare @matchID int 
select @matchID=m.match_ID
from match m
where m.host_club_ID=@IDhost and m.guest_club_id=@IDguest
and m.start_time=@startTime

declare @idTicket int
select top 1 @idTicket=t.id
from ticket t
where t.match_ID=@matchID and t.status= 1

update ticket 
set status=0
where @idTicket=id

insert into TicketBuyingTransactions values (@nID,@idTicket)

go





--xxv done
go
create proc updateMatchHost
@hostName varchar(20),
@guestName varchar(20),
@startTime datetime
as
declare @IDhost int 
declare @IDguest int 
select @IDhost=c.club_ID
from Club c
where @hostName=c.name

select @IDguest=c.club_ID
from Club c
where @guestName=c.name

declare @matchID int 
select @matchID=m.match_ID
from match m
where m.host_club_ID=@IDhost and m.guest_club_id=@IDguest
and m.start_time=@startTime

 
update match
set host_club_ID=@IDguest ,guest_club_id=@IDhost
where match_id=@matchID
 
go

--xxvi done
go
create view matchesPerTeam
as
select c.name, count(*) numberOfMatches
from Club c inner join match m on 
c.club_ID=m.guest_club_id or c.club_ID=m.host_club_ID
where m.end_time<current_timeStamp
group by c.name
go
--xxvii
go
create view clubsNeverMatched
as
select c1.name Club1,c2.name Club2
from club c1,club c2
where  c1.club_ID>c2.club_ID and not exists(
select*
from match m
where (m.host_club_ID=c1.club_ID and m.guest_club_id=c2.club_ID) or
(m.host_club_ID=c2.club_ID and m.guest_club_id=c1.club_ID)
)
go

--xxviii  done
go
create function clubsNeverPlayed(@clubName varchar(20))
returns table
return
select  c2.name Clubs
from club c1,club c2
where  c1.club_ID<>c2.club_ID and c1.name=@clubName and c2.name<>c1.name and not exists(
select*
from match m
where (m.host_club_ID=c1.club_ID and m.guest_club_id=c2.club_ID) or
(m.host_club_ID=c2.club_ID and m.guest_club_id=c1.club_ID)
)
go


---xxix done
go
create function matchWithHighestAttendance
()
returns table
return 
select c1.name hostName,c2.name guestName
from club c1 inner join match m on c1.club_ID=m.host_club_ID
inner join club c2 on m.guest_club_id=c2.club_ID
where (select COUNT(*)
from match m2 inner join ticket t on m2.match_ID=t.match_ID
where m2.match_ID=m.match_ID and t.status=0
)>= 
all (  select count(*)
from match m3 inner join ticket t1 on m3.match_ID=t1.match_ID
where t1.status=0
group by m3.match_ID)
go



--xxx done
go

create function matchesRankedByAttendance
()
returns table


return (
select c1.name club1,c2.name club2,  count(case t.status when 0 then 1 else null end) number_tickets
from club c1 
inner join match m on c1.club_ID=m.host_club_ID
inner join club c2 on m.guest_club_id=c2.club_ID
inner join ticket t on m.match_ID=t.match_ID
group by c1.name,c2.name  
order by number_tickets desc
offset 0 rows
)

--end
go




--xxxi
go
create function requestsFromClub(
@stadiumName varchar(20),
@clubName varchar(20))
returns table
return (
select c1.name hostClub ,c2.name guestClub from 
club c1
inner join ClubRepresentative cr on c1.club_ID=cr.club_ID
inner join HostRequest hr on hr.representative_id=cr.id
inner join StaduimManager sm on hr.manager_id=sm.id
inner join Stadium stad on sm.stadium_id=stad.id
inner join match m on hr.match_id=m.match_ID
inner join club c2 on m.guest_club_id = c2.club_ID
where c1.name=@clubName and stad.name=@stadiumName
)
go


