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
    public partial class StaduimManagerView : System.Web.UI.Page
    {
        string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            string username = (string)Session["username"];
            if (Session["type"] == null || !Session["type"].Equals("StaduimManagerView.aspx"))
                Response.Redirect("login.aspx");
            // Session["username"] = "Darwish";
            using (SqlConnection conn = new SqlConnection(connstr))
            {
                conn.Open();
                SqlDataAdapter sqlData = new SqlDataAdapter("select * from [dbo].getStadium(@username)", conn);
                sqlData.SelectCommand.Parameters.Add("@username", (string)Session["username"]);
                DataTable dtbl = new DataTable();
                sqlData.Fill(dtbl);
                gridviewstadiums.DataSource = dtbl;
                gridviewstadiums.DataBind();
                conn.Close();
            }


            using (SqlConnection conn = new SqlConnection(connstr))
            {
                conn.Open();
                SqlDataAdapter sqlData = new SqlDataAdapter("select * from [dbo].getRequest(@username)", conn);
                sqlData.SelectCommand.Parameters.Add("@username", (string)Session["username"]);
                DataTable dtbl = new DataTable();
                sqlData.Fill(dtbl);
                gridviewRequests.DataSource = dtbl;
                gridviewRequests.DataBind();
            }

        }

        protected void lnkAccept_Click(object sender, EventArgs e)
        {
            int requestId = Convert.ToInt16((sender as LinkButton).CommandArgument);
            using (SqlConnection conn = new SqlConnection(connstr))
            {
                conn.Open();
                SqlCommand logic = new SqlCommand("exec acceptRequest @id", conn);
                logic.Parameters.Add("@id", requestId);
                logic.ExecuteNonQuery();
                Response.Redirect("StaduimManagerView.aspx");
                conn.Close();
            }
        }
        protected void lnkReject_Click(object sender, EventArgs e)
        {
            int requestId = Convert.ToInt16((sender as LinkButton).CommandArgument);
            using (SqlConnection conn = new SqlConnection(connstr))
            {
                conn.Open();
                SqlCommand logic = new SqlCommand("update HostRequest" +
                " set status = 0 where id=@id  ", conn);
                logic.Parameters.Add("@id", requestId);
                logic.ExecuteNonQuery();
                Response.Redirect("StaduimManagerView.aspx");
                conn.Close();
            }
        }

        protected void gridviewRequests_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}