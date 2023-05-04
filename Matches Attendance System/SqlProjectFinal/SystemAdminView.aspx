<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemAdminView.aspx.cs" Inherits="SqlProjectFinal.SystemAdminView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Add a new club: "></asp:Label>
        <div>
            <asp:Label ID="Label2" runat="server" Text="Club Name " MaxLength="20" ></asp:Label>
        </div>
        <p>
            <asp:TextBox ID="name" runat="server" MaxLength="20"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label3" runat="server" Text="Club Location" MaxLength="20"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="location" runat="server" MaxLength="20"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Add" runat="server" OnClick ="add" Text="Add" />
            
        </p>
    <hr size="3" color="Black">
    <p>
        <asp:Label ID="Label4" runat="server" Text="Delete Club:"></asp:Label>
        </p>
        <asp:Label ID="Label6" runat="server" Text="Club Name"></asp:Label>
        <p>
        <asp:TextBox ID="delete" runat="server" MaxLength="20"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="deletebutton" runat="server" OnClick="deletefunc" Text="Delete" />
        </p>
            <hr size="3" color="Black">
        <p>
        <asp:Label ID="Label5" runat="server" Text="Add a new stadium:"></asp:Label>
        </p>
        <p>
            <asp:Label ID="Label7" runat="server" Text="Stadium Name"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="stadiumname" runat="server" MaxLength="20"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label8" runat="server" Text="Stadium Location"></asp:Label>
        </p>
        <asp:TextBox ID="stadiumlocation" runat="server" MaxLength="20"></asp:TextBox>
        <p>
            <asp:Label ID="Label9" runat="server" Text="Stadium Capacity"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="stadiumcapacity" runat="server" MaxLength="20"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="addstadium" Text="Add" />

        </p>
        <hr size="3" color="Black">
        <asp:Label ID="Label10" runat="server" Text="Delete a stadium:"></asp:Label>
        <p>
            <asp:Label ID="Label11" runat="server" Text="Stadium Name"></asp:Label>
        </p>
        <asp:TextBox ID="deletestadium" runat="server" MaxLength="20"></asp:TextBox>
        <p>
            <asp:Button ID="Button2" runat="server" OnClick="deletestadiumfunc" Text="Delete" />
        
        </p>
        <hr size="3" color="Black">
        
        
        <asp:Label ID="Label12" runat="server" Text=" Block a fan:"></asp:Label>
        <p>
            <asp:Label ID="Label13" runat="server" Text="Fan ID"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="FanID" runat="server" MaxLength="20"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button3" runat="server" OnClick="blockfunc" Text="Block" />
        </p>
    </form>
    </body>
</html>