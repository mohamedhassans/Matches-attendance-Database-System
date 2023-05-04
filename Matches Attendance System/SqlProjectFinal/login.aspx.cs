using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SqlProjectFinal
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["type"] != null)
                Response.Redirect(Session["type"] + "");
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            SqlConnection conn = new SqlConnection(connstr);
            string user = Username.Text;
            string password = Password.Text;
            conn.Open();
            SqlCommand logic = new SqlCommand("select * from SystemUser where username=@username and password=@password ", conn);
            logic.Parameters.Add(new SqlParameter("@username", user));
            logic.Parameters.Add(new SqlParameter("@password", password));
            SqlDataReader readerUser = logic.ExecuteReader();
            Boolean flag = false;
            if (readerUser.HasRows && user != "" && password != "") flag = true;
            conn.Close();
            conn.Open();
            SqlCommand logicreadFan = new SqlCommand("select * from Fan where username=@username and status = 1", conn);
            logicreadFan.Parameters.Add(new SqlParameter("@username", user));
            SqlDataReader readerFan = logicreadFan.ExecuteReader();
            if (readerFan.HasRows && flag)
            {
                Session["username"] = user;
                Session["type"] = "FanView.aspx";
                Response.Redirect("FanView.aspx");
                return;
            }
            conn.Close();
            conn.Open();
            SqlCommand logicreadSportsAssociationManager = new SqlCommand("select * from SportsAssociationManager where username=@username", conn);
            logicreadSportsAssociationManager.Parameters.Add(new SqlParameter("@username", user));
            SqlDataReader readerSportsAssociationManager = logicreadSportsAssociationManager.ExecuteReader();
            if (readerSportsAssociationManager.HasRows && flag)
            {
                Session["username"] = user;
                Session["type"] = "SportsAssociationManagerView.aspx";
                Response.Redirect("SportsAssociationManagerView.aspx");
                return;
            }
            conn.Close();
            conn.Open();

            SqlCommand logicreadClubRepresentative = new SqlCommand("select * from ClubRepresentative where username=@username", conn);
            logicreadClubRepresentative.Parameters.Add(new SqlParameter("@username", user));
            SqlDataReader readerClubRepresentative = logicreadClubRepresentative.ExecuteReader();
            if (readerClubRepresentative.HasRows && flag)
            {
                Session["username"] = user;
                Session["type"] = "ClubRepresentativeView.aspx";
                Response.Redirect("ClubRepresentativeView.aspx");
                return;
            }
            conn.Close();
            conn.Open();

            SqlCommand logicreadStaduimManager = new SqlCommand("select * from StaduimManager where username=@username", conn);
            logicreadStaduimManager.Parameters.Add(new SqlParameter("@username", user));
            SqlDataReader readerStaduimManager = logicreadStaduimManager.ExecuteReader();
            if (readerStaduimManager.HasRows && flag)
            {

                Session["username"] = user;
                Session["type"] = "StaduimManagerView.aspx";
                Response.Redirect("StaduimManagerView.aspx");
                return;
            }
            if (user.Equals("admin") && password.Equals("admin"))
                Response.Redirect("SystemAdminView.aspx");
            else
            warning.Visible = true;
            conn.Close();

        }
        protected void Register_Click(object sender, EventArgs e)
        {

            Response.Redirect("Register.aspx");
        }

       
    }
}