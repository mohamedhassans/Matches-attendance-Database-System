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
    public partial class SystemAdminView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void add(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connstr);
            String name1 = name.Text;
            String location1 = location.Text;
            SqlCommand loginproc = new SqlCommand("addClub", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@name", name1));
            loginproc.Parameters.Add(new SqlParameter("@location", location1));
            SqlParameter sucess = loginproc.Parameters.Add("@res", SqlDbType.Int);
            sucess.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();

            if (sucess.Value.ToString() == "1")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('You have to enter a club name and a location');", true);


                // Response.Write("<script>alert('You have to enter a club name and a location');</script>");
                // Response.Write("You have to enter User name and a location");

            }
            else if (sucess.Value.ToString() == "2")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('The club is aleary exists');", true);

                //Response.Write("<script>alert('The club is aleary exists');</script>");
                // Response.Write("The club is aleary exists");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('added successfully');", true);

                //  Response.Write("<script>alert('added successfully');</script>");
                // Response.Write("added successfully");

            }


        }

        protected void deletefunc(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connstr);
            String name = delete.Text;
            SqlCommand loginproc = new SqlCommand("deleteClub", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@name", name));

            SqlParameter sucess = loginproc.Parameters.Add("@res", SqlDbType.Int);
            sucess.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();

            if (sucess.Value.ToString() == "1")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('You have to enter a club name');", true);


                // Response.Write("<script>alert('You have to enter a club name and a location');</script>");
                // Response.Write("You have to enter User name and a location");

            }
            else if (sucess.Value.ToString() == "2")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('The club does not exist');", true);

                //Response.Write("<script>alert('The club is aleary exists');</script>");
                // Response.Write("The club is aleary exists");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('deleted successfully');", true);

                //  Response.Write("<script>alert('added successfully');</script>");
                // Response.Write("added successfully");

            }

        }

        protected void addstadium(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connstr);
            String name = stadiumname.Text;
            String location = stadiumlocation.Text;
            String capacity = stadiumcapacity.Text;


            int number;
            bool isNumber = Int32.TryParse(capacity, out number);


            if (isNumber && location != "" && name != "")
            {

                SqlCommand checkifexists = new SqlCommand("select* from Stadium s where s.name= '" + name + "'", conn);
                SqlDataAdapter sd = new SqlDataAdapter(checkifexists);
                DataTable dt = new DataTable();
                sd.Fill(dt);
                if (dt.Rows.Count == 0)
                {


                    int capacitynum = Int32.Parse(capacity);
                    SqlCommand loginproc = new SqlCommand("addStadium", conn);
                    loginproc.CommandType = CommandType.StoredProcedure;
                    loginproc.Parameters.Add(new SqlParameter("@name", name));
                    loginproc.Parameters.Add(new SqlParameter("@location", location));
                    loginproc.Parameters.Add(new SqlParameter("@capacity", capacitynum));
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Added successfully');", true);
                    conn.Open();
                    loginproc.ExecuteNonQuery();
                    conn.Close();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('The stadium is already exists');", true);


                }

            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Some inputs are not valid! Please Enter a valid inputs');", true);

            }


        }

        protected void deletestadiumfunc(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connstr);
            String name = deletestadium.Text;
            if (name != null)
            {

                SqlCommand checkifexists = new SqlCommand("select* from Stadium s where s.name= '" + name + "'", conn);
                SqlDataAdapter sd = new SqlDataAdapter(checkifexists);
                DataTable dt = new DataTable();
                sd.Fill(dt);
                if (dt.Rows.Count != 0)
                {
                    SqlCommand loginproc = new SqlCommand("deleteStadium", conn);
                    loginproc.CommandType = CommandType.StoredProcedure;
                    loginproc.Parameters.Add(new SqlParameter("@name", name));
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Deleted successfully');", true);
                    conn.Open();
                    loginproc.ExecuteNonQuery();
                    conn.Close();

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('The stadium does not exist');", true);

                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter a valid input');", true);

            }
        }

        protected void blockfunc(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connstr);
            String fanid = FanID.Text;


            SqlCommand checkifexists = new SqlCommand("select* from fan f where f.nationalID= '" + fanid + "'", conn);
            SqlDataAdapter sd = new SqlDataAdapter(checkifexists);
            DataTable dt = new DataTable();
            sd.Fill(dt);

            if (fanid == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter a valid Fan ID');", true);

            }
            else if (dt.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('This Id does not exist');", true);

            }
            else
            {
                SqlCommand loginproc = new SqlCommand("blockFan", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@ID", fanid));
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Blocked successfully');", true);
                conn.Open();
                loginproc.ExecuteNonQuery();
                conn.Close();
            }
        }

    }
}