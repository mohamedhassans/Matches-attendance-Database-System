<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="SqlProjectFinal.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/bootstrap-datetimepicker.css" rel="stylesheet" />
    <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="Content/bootstrap-theme.css" rel="stylesheet" />
    <link href="Content/bootstrap-theme.min.css" rel="stylesheet" />
           <link href="Content/bootstrap.min.css" rel="stylesheet" />
 <script src="Scripts/jquery-1.9.1.min.js"></script>
    <script src="Scripts/jquery-1.9.1.js"></script>
    <script src="Scripts/moment.min.js"></script>
    <script src="Scripts/jquery-1.9.1.intellisense.js"></script>
    <script src="Scripts/bootstrap-datetimepicker.js"></script>
    <script src="Scripts/bootstrap-datetimepicker.min.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/jquery-1.9.1.intellisense.js"></script>
    <script src="Scripts/jquery-1.9.1.js"></script>
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <script src="Scripts/moment-with-locales.js"></script>
    <script src="Scripts/moment-with-locales.min.js"></script>
    <script src="Scripts/moment.js"></script>

    <title></title>

</head>
<body>
    <form runat="server">
        <div >
            <asp:DropDownList ID="DropDownList1"  OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true" runat="server">
                <asp:ListItem>Select your type</asp:ListItem>
                <asp:ListItem>Fan</asp:ListItem>
                <asp:ListItem>Stadium Manager</asp:ListItem>
                <asp:ListItem>Sports Association Manager</asp:ListItem>
                <asp:ListItem>Club Representative</asp:ListItem>
            </asp:DropDownList>
        </div>
      <div id="formAll" runat="server"  visible="false">
               <label for="name">Name:</label><br>
              <asp:TextBox type="text" id="name" name="name" runat="server" MaxLength="20"></asp:TextBox><br>
              <label for="UserName">UserName:</label><br>
              <asp:TextBox type="text" id="UserName" name="UserName" runat="server" MaxLength="20"></asp:TextBox><br>
              <label for="Password">Password:</label><br>
              <asp:TextBox type="text" id="Password" name="Password" runat="server" MaxLength="20"></asp:TextBox><br>
        </div>
      
        <div id="formFan" runat="Server"  visible="false">
            <label for="nationalID">National ID:</label><br>
            <asp:TextBox type="text" id="nationalID" name="nationalID" runat="server" MaxLength="20"></asp:TextBox><br>
            <label for="birth_date">Birth Date:</label><br>
            <asp:TextBox type="date" id="birth_date" name="birth_date" runat="server" MaxLength="20"></asp:TextBox><br>
             <label for="address">Address:</label><br>
            <asp:TextBox type="text" id="address" name="address" runat="server" MaxLength="20"></asp:TextBox><br>
              <label for="phone_no">Phone Number:</label><br>
          <asp:TextBox type="number" id="phone_no" name="phone_no" runat="server" MaxLength="20"></asp:TextBox><br>
    </div>
    <div id="formStadiumManager" runat="server" visible="false">
         <label for="StadiumName">Stadium:</label><br>
         <asp:TextBox type="text" id="StadiumName" name="StadiumName" runat="server" MaxLength="20"></asp:TextBox><br>
    </div>
    <div id="formSportsManager" runat="server"  visible="false">
    </div> 
    <div id="formRepresentative" runat="server" visible="false">
         <label for="ClubName">Club:</label><br>
         <asp:TextBox type="text" id="ClubName" name="ClubName" runat="server" MaxLength="20"></asp:TextBox><br>
    </div>
        <div>
            <asp:Button ID="Button4" runat="server" Text="Register" onclick="Register_click" style="margin-top:20px; height: 29px;" Visible="false"/>
        </div>
      <b>
        <h4 style="color:red" visible="false" runat="server" id="regwarning">
            wrong info
        </h4>
          <h4 style="color:red" visible="false" runat="server" id="regwarningused">
            already used username
        </h4>

  </form>
</body>
</html>