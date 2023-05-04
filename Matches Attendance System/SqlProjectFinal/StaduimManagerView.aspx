<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StaduimManagerView.aspx.cs" Inherits="SqlProjectFinal.StaduimManagerView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h3 style="margin-left:600px">
            Managed Stadiums
        </h3> 
        <div>
             <asp:GridView runat="server" AutoGenerateColumns="false" ID="gridviewstadiums" style="margin-left:550px">
                 <Columns>
                     <asp:BoundField DataField="id" HeaderText="id"/>
                     <asp:BoundField DataField="name" HeaderText="name"/>
                     <asp:BoundField DataField="location" HeaderText="location"/>
                     <asp:BoundField DataField="capacity" HeaderText="capacity"/>
                     <asp:BoundField DataField="status" HeaderText="status"/>
                 </Columns>
             </asp:GridView>
        </div>
        <br />
            <br />
         <h3 style="margin-left:600px">
                All Requests
        </h3> 
        <div>
            
              <asp:GridView runat="server" AutoGenerateColumns="true" ID="gridviewRequests" OnSelectedIndexChanged="gridviewRequests_SelectedIndexChanged">
                 <Columns>
                     <asp:BoundField DataField="RequestID" HeaderText="RequestID"/>
                     <asp:BoundField DataField="representativeUserName" HeaderText="representative Name"/>
                     <asp:BoundField DataField="HostClubName" HeaderText="Host Club Name"/>
                     <asp:BoundField DataField="GuestClubName" HeaderText="Guest Club Name"/>
                     <asp:BoundField DataField="StartTime" HeaderText="StartTime"/>
                     <asp:BoundField DataField="EndTime" HeaderText="EndTime"/>
                     <asp:BoundField DataField="Status" HeaderText="Status"/>
                     <asp:TemplateField>
                         <ItemTemplate>
                             <asp:LinkButton ID="lnkAccept" Text="Accept" runat="server"
                                 CommandArgument='<%# Eval("RequestID") %>' onClick="lnkAccept_Click"></asp:LinkButton>
                         </ItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField>
                         <ItemTemplate>
                             <asp:LinkButton ID="lnkReject" Text="Reject" runat="server"
                                 CommandArgument='<%# Eval("RequestID")  %>' onClick="lnkReject_Click"></asp:LinkButton>
                         </ItemTemplate>
                     </asp:TemplateField>
                 </Columns>
             </asp:GridView>
        </div>
    </form>
</body>
</body>
</html>
