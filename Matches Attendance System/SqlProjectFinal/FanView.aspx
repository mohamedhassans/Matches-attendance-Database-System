<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FanView.aspx.cs" Inherits="SqlProjectFinal.FanView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   </head>
<body>    

    <form id="form1" runat="server" >
        <div>
            <asp:Label ID="Label1" runat="server" Text="Search for a match" style=></asp:Label>
        </div>
         
        <p>
            <asp:TextBox ID="dateid" type="datetime-local" runat="server" MaxLength="20"></asp:TextBox>
        </p>
        <p>
        <asp:Button ID="Button1" runat="server" onClick="funshow" Text="Show Available Matches" Width="227px" />
        </p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            <Columns>
            <asp:BoundField DataField="hostClubName" HeaderText="Host Club"/>
            <asp:BoundField DataField="guestClubName" HeaderText="Guest Club"/>
            <asp:BoundField DataField="start_time" HeaderText="Start Time"/>
            <asp:BoundField DataField="Stadiumname" HeaderText="Stadium Name"/>
            <asp:BoundField DataField="Stadiumlocation" HeaderText="Stadium Location"/>
                <asp:TemplateField>
                         <ItemTemplate>
                             <asp:Button ID="Button1" runat="server" Text="Buy a Ticket" 
                                   OnClick="MyButtonClick" />
                         </ItemTemplate>
                     </asp:TemplateField>
             
        </Columns>
                </asp:GridView>
    </form>
</body>
</html>
