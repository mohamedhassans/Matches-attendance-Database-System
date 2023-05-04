<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRepresentativeView.aspx.cs" Inherits="SqlProjectFinal.ClubReqpresentativeView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left:700px">
            <h3 style="margin-bottom: 2px">Club infromation </h3>
            <asp:Button ID="ViewClubInfo" runat="server"  Text="View" OnClick="ViewClubInfo_Click" 
                style="margin-left:90px"/>
            <asp:GridView runat="server" ID="clubInfo" AutoGenerateColumns="false">

                 <Columns>
            <asp:BoundField DataField="name" HeaderText="name"/>
            <asp:BoundField DataField="location" HeaderText="location" /> 
        </Columns>


            </asp:GridView>
            <br />
            <br />
            <h3 style="margin-bottom: 3px">Club upcoming matches</h3>
            <asp:Button ID="Button2" style="margin-left:90px" runat="server" OnClick="ViewUpComingMatches" Text="View" />         
            <asp:GridView runat="server" AutoGenerateColumns="false" ID="upcoming">

            <Columns>
            <asp:BoundField DataField="ClubName" HeaderText="Host Club Name"/>
            <asp:BoundField DataField="CompetingClubName" HeaderText="Guest Club Name" /> 
            <asp:BoundField DataField="start_time" HeaderText="Start time" /> 
            <asp:BoundField DataField="end_time" HeaderText="End time" /> 
            <asp:BoundField DataField="StadiumName" HeaderText="Stadium Name" /> 
            </Columns>

            </asp:GridView>
            <br />   
            <br />
            <br />
            <h3> available stadiums</h3>
            <asp:TextBox type="date" runat="server" ID="availbledate" MaxLength="20" ></asp:TextBox>
            <asp:TextBox type="time" runat="server" ID="availabetime" MaxLength="20" ></asp:TextBox>
            <br />
            <asp:Button ID="Button3" runat="server" OnClick="AvailabeMatches" style="margin-left:100px" Text="View" />
            <asp:GridView runat="server" 
                AutoGenerateColumns="false" ID="availableStadiums">
            <Columns>
            <asp:BoundField DataField="name" HeaderText="Stadium Name"/>
            <asp:BoundField DataField="location" HeaderText="Location" /> 
            <asp:BoundField DataField="capacity" HeaderText="Capacity" /> 
            </Columns>


            </asp:GridView>
           <br />
            <br />
            <h3 >  Send a request</h3>
            <h6 style="margin-bottom: 2px" >Stadium Name</h6>
            <asp:TextBox type="text" id="StadiumName" runat="server" style="margin-top: 0px" MaxLength="20"></asp:TextBox>
            <br />
            <h6 style="margin-bottom: 6px">Start Time</h6>
            <asp:TextBox type="date" runat="server" ID="CRVstartDate"></asp:TextBox>
            <asp:TextBox type="time" runat="server" ID="CRVstartTime"></asp:TextBox>
            <br />
            <asp:Button ID="Button4" runat="server" OnClick="Button2_Click" Text="View"
                style="margin-left:100px"/>
            <asp:GridView runat="server"></asp:GridView>
        </div>
    </form>
</body>
</html>