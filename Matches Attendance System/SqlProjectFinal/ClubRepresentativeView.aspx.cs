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
    public partial class ClubReqpresentativeView : System.Web.UI.Page
    {
        string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            string username = (string)Session["username"];
            if (Session["type"] == null || !Session["type"].Equals("ClubRepresentativeView.aspx"))
                Response.Redirect("login.aspx");

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            SqlConnection conn = new SqlConnection(connstr);
            conn.Open();

            string stadiumName = StadiumName.Text;
          try
            {

                if (CRVstartDate.Text.Equals("") || CRVstartTime.Text.Equals("")) {
                    throw new Exception("Please choose Time and Date");
                }
                DateTime start = DateTime.ParseExact(CRVstartDate.Text + " " + CRVstartTime.Text, "yyyy-MM-dd HH:mm", null);
     
            SqlCommand logic = new SqlCommand("Select * from stadium where name=@stadiumName", conn);
            logic.Parameters.Add("@stadiumName", stadiumName);
            SqlDataReader reader = logic.ExecuteReader();
            if (!reader.HasRows)
                throw new Exception("Wrong Stadium Name");
            conn.Close();


            conn.Open();
            logic = new SqlCommand("Select * from match m inner join ClubRepresentative cr "
                                  +"on m.host_club_ID = cr.club_ID where m.start_time = @startTime and"
                                  +" cr.username = @username", conn);
            logic.Parameters.Add("@startTime", start);
            logic.Parameters.Add("@username", Session["username"]);               
                reader = logic.ExecuteReader();
                if (!reader.HasRows)
                {
                    throw new Exception("Wrong startTime from Match");
                }
                else {
                }
                conn.Close();


                conn.Open();
            logic = new SqlCommand("exec addHostRequestWithRepUserName @clubRepUsername,@stadiumName,@startdate", conn);
            logic.Parameters.Add("@clubRepUsername",Session["username"]);
            logic.Parameters.Add("@stadiumName", stadiumName);
            logic.Parameters.Add("@startdate", start);
            logic.ExecuteNonQuery();

        }
         catch (Exception ee) {             ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('"+ee.Message+"');", true);}

        conn.Close();



        }



        protected void ViewUpComingMatches(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connstr))
            {
                conn.Open();
                SqlDataAdapter sqlData = new SqlDataAdapter("select * from [dbo].upcomingMatchesOfClub2(@username)", conn);
                sqlData.SelectCommand.Parameters.Add("@username", (string)Session["username"]);
                DataTable dtbl = new DataTable();
                sqlData.Fill(dtbl);
                upcoming.DataSource = dtbl;
                upcoming.DataBind();
                conn.Close();
            }
        }

        protected void AvailabeMatches(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connstr))
            {
                conn.Open();
                try
                {
                    SqlDataAdapter sqlData = new SqlDataAdapter("select * from [dbo].viewAvailableStadiumsOn(@date)", conn);
                    DateTime start = DateTime.ParseExact(availbledate.Text + " " + availabetime.Text, "yyyy-MM-dd HH:mm", null);
                    sqlData.SelectCommand.Parameters.Add("@date", start);
                    DataTable dtbl = new DataTable();
                    sqlData.Fill(dtbl);
                    availableStadiums.DataSource = dtbl;
                    availableStadiums.DataBind();
                }
                catch (Exception ee) {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Wrong Info');", true);
                }
                conn.Close();
            }
        }

        protected void ViewClubInfo_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connstr))
            {
                conn.Open();
                SqlDataAdapter sqlData = new SqlDataAdapter("select c.name,c.location from club c inner join ClubRepresentative cr on(cr.club_ID=c.club_ID) where cr.username=@username", conn);
                sqlData.SelectCommand.Parameters.Add("@username", (string)Session["username"]);
                DataTable dtbl = new DataTable();
                sqlData.Fill(dtbl);
                clubInfo.DataSource = dtbl;
                clubInfo.DataBind();
                conn.Close();
            }
        }

    }
}