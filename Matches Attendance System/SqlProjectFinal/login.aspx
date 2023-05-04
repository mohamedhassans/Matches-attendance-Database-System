<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="SqlProjectFinal.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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

</head>
<body style="height: 298px; width: 197px; margin-left: 640px">
    <form id="form1" runat="server">
 
           <div>
               <h2 style="margin-left:20px">Please log in</h2>
        <h3 style="margin-left: 40px; width: 90px;">
            Username
        </h3>

        <p>
            <asp:TextBox ID="Username"  runat="server" MaxLength="20"></asp:TextBox>
        </p>

        <h3 style="margin-left: 40px; width: 90px;">
            Password
        </h3>

        <p >
            <asp:TextBox ID="Password" runat="server" MaxLength="20"></asp:TextBox>
       
             <h6 style="color:red" runat="server" id="warning" visible="false"> Wronge username of password        </h6>
            <asp:Button ID="Button1" runat="server" Text="Login"  style="margin-left: 40px; width: 90px;margin-top:10px" OnClick="Login_Click"/>
            <asp:Button ID="Button2" runat="server" Text="Register"  style="margin-left: 40px; width: 90px;margin-top:10px" OnClick="Register_Click"/>
            

     </div>

    </form>
<Button2</html>
