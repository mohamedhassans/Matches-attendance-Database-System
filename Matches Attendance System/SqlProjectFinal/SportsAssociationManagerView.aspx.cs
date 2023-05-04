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
    public partial class SportsAssociationManagerView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = (string)Session["username"];
            if (Session["type"] == null || !Session["type"].Equals("SportsAssociationManagerView.aspx"))
                Response.Redirect("login.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            SqlConnection conn = new SqlConnection(connstr);
            conn.Open();
            string first = TextBox1.Text;
            string second = TextBox2.Text;

            Boolean flag = true;
            SqlCommand logicread = new SqlCommand("Select * from Club where name=@firstClub", conn);
            logicread.Parameters.Add("@firstClub", first);
            SqlDataReader reader = logicread.ExecuteReader();
            if (!reader.HasRows)
                flag = false;
            conn.Close();
            conn.Open();
            logicread = new SqlCommand("Select * from Club where name=@secondClub", conn);
            logicread.Parameters.Add("@secondClub", second);
            reader = logicread.ExecuteReader();
            if (!reader.HasRows)
                flag = false;
            conn.Close();
            if (first.Equals(second))
                flag = false;
            if (!flag)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Wrong Club Name Info');", true);
                return;
            }
            flag = true;

           try
            {
                conn.Open();
                DateTime start = DateTime.ParseExact(TextBox3.Text + " " + TextBox.Text, "yyyy-MM-dd HH:mm", null);
                DateTime end = DateTime.ParseExact(TextBox4.Text + " " + TextBox9.Text, "yyyy-MM-dd HH:mm", null);
                SqlCommand logic = new SqlCommand("select * from [dbo].getSpeceficMatchesAdd(@hostClub,@starttime)", conn);
                logic.Parameters.Add("@hostClub",first);
                logic.Parameters.Add("@starttime",start);
                SqlDataReader reader2 = logic.ExecuteReader();
                if (reader2.HasRows) {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('"+"the host club has match in that time"+"');", true);
                    return;
                }
                conn.Close();


                conn.Open();
                logic = new SqlCommand("select * from [dbo].getSpeceficMatchesAdd(@hostClub,@starttime)", conn);
                logic.Parameters.Add("@hostClub", second);
                logic.Parameters.Add("@starttime", start);
                reader2 = logic.ExecuteReader();
                if (reader2.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + "the host Guest has match in that time" + "');", true);
                    return;
                }
                conn.Close();

                conn.Open();
                logic = new SqlCommand("exec addNewMatch @hostClub,@guestClub,@stime,@etime", conn);
                logic.Parameters.Add("@hostClub", first);
                logic.Parameters.Add("@guestClub", second);
                logic.Parameters.Add("@stime", start);
                logic.Parameters.Add("@etime", end);
                if (start.CompareTo(end) >= 0)
                    flag = false;
                else
                {
                    logic.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Match added successfully');", true);

                }
                conn.Close();

            }
          catch (Exception ee){           
                flag = false;}

            if (!flag)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Wrong Match Info');", true);
            }
            conn.Close();


        }
        string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
        protected void Button2_Click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection(connstr);

            conn.Open();
            string first = TextBox5.Text;
            string second = TextBox6.Text;
            Boolean flag = true;
            SqlCommand logicread = new SqlCommand("Select * from Club where name=@firstClub", conn);
            logicread.Parameters.Add("@firstClub", first);
            SqlDataReader reader = logicread.ExecuteReader();
            if (!reader.HasRows)
                flag = false;
            conn.Close();
            conn.Open();
            logicread = new SqlCommand("Select * from Club where name=@secondClub", conn);
            logicread.Parameters.Add("@secondClub", second);
            reader = logicread.ExecuteReader();
            if (!reader.HasRows)
                flag = false;
            conn.Close();
            if (first.Equals(second))
                flag = false;
            if (!flag)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Wrong Club Name Info');", true);
                return;
            }

            try
            {

                DateTime start = DateTime.ParseExact(TextBox7.Text + " " + TextBox77.Text, "yyyy-MM-dd HH:mm", null);
                DateTime end = DateTime.ParseExact(TextBox8.Text + " " + TextBox10.Text, "yyyy-MM-dd HH:mm", null);

                conn.Open();
              
                logicread = new SqlCommand("Select * from dbo.getSpeceficMatchesDelete(@hostClub,@guestClub,@startTime,@endTime)", conn);
                logicread.Parameters.Add("@hostClub", first);
                logicread.Parameters.Add("@guestClub", second);
                logicread.Parameters.Add("@startTime", start);
                logicread.Parameters.Add("@endTime", end);
                reader = logicread.ExecuteReader();
                if (!reader.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No Match with that info');", true);
                    return;
                }
                conn.Close();



                conn.Open();
                SqlCommand logic = new SqlCommand("exec deleteMatchnew @hostClub,@guestClub,@stime,@etime", conn);
                logic.Parameters.Add("@hostClub", first);
                logic.Parameters.Add("@guestClub", second);
                logic.Parameters.Add("@stime", start);
                logic.Parameters.Add("@etime", end);
                if (start.CompareTo(end) >= 0)
                    flag = false;
                else
                {
                    logic.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Match deleted successfully');", true);

                }

            }
            catch (Exception ee)
            {
                flag = false;
            }
            conn.Close();
            if (!flag)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Wrong Match Info');", true);
            }
            conn.Close();

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            SqlConnection conn = new SqlConnection(connstr);
            conn.Open();
            SqlDataAdapter sqlData = new SqlDataAdapter("Select * from allMatchesnotplayed", conn);
            DataTable dtbl = new DataTable();
            sqlData.Fill(dtbl);
            UpcomingMatches.DataSource = dtbl;
            UpcomingMatches.DataBind();
            conn.Close();

        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            SqlConnection conn = new SqlConnection(connstr);
            conn.Open();          
            SqlDataAdapter sqlData = new SqlDataAdapter("Select * from allMatchesplayed", conn);
            DataTable dtbl = new DataTable();
            sqlData.Fill(dtbl);
            UpcomingMatches.DataSource = dtbl;
            UpcomingMatches.DataBind();
            conn.Close();
        }
        protected void Button5_Click(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            SqlConnection conn = new SqlConnection(connstr);
            conn.Open();

            SqlDataAdapter sqlData = new SqlDataAdapter("Select * from clubsNeverMatched", conn);
            DataTable dtbl = new DataTable();
            sqlData.Fill(dtbl);
            PairNeverPlayed.DataSource = dtbl;
            PairNeverPlayed.DataBind();
            conn.Close();

        }

        protected void Tournament_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}