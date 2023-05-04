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
    public partial class FanView : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            string username = (string)Session["username"];
            if (Session["type"] == null || !Session["type"].Equals("FanView.aspx"))
                Response.Redirect("login.aspx");
        }

        protected void viewTable(String ss)
        {
            DateTime hh;
            if (DateTime.TryParse(ss, out hh))
            {
                DateTime dtt = Convert.ToDateTime(ss);
                string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
                //create a new connection
                SqlConnection conn = new SqlConnection(connstr);
                SqlCommand checkifexists = new SqlCommand("select * from dbo.xxx('" + dtt + "')", conn); 
                Response.Write(dtt);
                SqlDataAdapter sd = new SqlDataAdapter(checkifexists);
                DataTable dt = new DataTable();
                sd.Fill(dt);
                if (dt.Rows.Count == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('There is no matches on the entered date');", true);
                }
                else
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter a valid date');", true);

            }

        }

        protected void funshow(object sender, EventArgs e)
        {

            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connstr);
            String str = dateid.Text;

            viewTable(str);
            //viewTable(str);

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connstr);
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            string username = (string)Session["username"];
            string hostClubName = gvr.Cells[0].Text;
            string guestClubName = gvr.Cells[1].Text;
            string start_time = gvr.Cells[2].Text;
            DateTime dtt = Convert.ToDateTime(start_time);
            SqlCommand loginproc = new SqlCommand("mohamedPurchaseTicket", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@userName", username));
            loginproc.Parameters.Add(new SqlParameter("@hostName", hostClubName));
            loginproc.Parameters.Add(new SqlParameter("@guestName", guestClubName));
            loginproc.Parameters.Add(new SqlParameter("@startTime", dtt));
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Purchased Successfully');", true);
            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();
            //  string guestClubName = (gvr.Cells[0].FindControl("hostClubName") as Label).Text;




        }
        protected void MyButtonClick(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connstr);
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            string username = (string)Session["username"];
            string hostClubName = gvr.Cells[0].Text;
            string guestClubName = gvr.Cells[1].Text;
            string start_time = gvr.Cells[2].Text;
            DateTime dtt = Convert.ToDateTime(start_time);
            SqlCommand loginproc = new SqlCommand("mohamedPurchaseTicket", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@userName", username));
            loginproc.Parameters.Add(new SqlParameter("@hostName", hostClubName));
            loginproc.Parameters.Add(new SqlParameter("@guestName", guestClubName));
            loginproc.Parameters.Add(new SqlParameter("@startTime", dtt));
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Purchased Successfully');", true);
            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();
            //  string guestClubName = (gvr.Cells[0].FindControl("hostClubName") as Label).Text;


        }
    }
}