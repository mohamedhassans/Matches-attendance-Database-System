using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SqlProjectFinal
{
    public partial class Register : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
          
            string connstr = WebConfigurationManager.ConnectionStrings["dbProject"].ToString();
            conn = new SqlConnection(connstr);
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            String s = DropDownList1.SelectedValue;
            if (s.Equals("Fan"))
            {
                Button4.Visible = true;
                formAll.Visible = true;
                formFan.Visible = false;
                formRepresentative.Visible = false;
                formSportsManager.Visible = false;
                formStadiumManager.Visible = false;
                formFan.Visible = true;
            }
            if (s.Equals("Stadium Manager"))
            {
                Button4.Visible = true;
                formAll.Visible = true;
                formFan.Visible = false;
                formRepresentative.Visible = false;
                formSportsManager.Visible = false;
                formStadiumManager.Visible = false;
                formStadiumManager.Visible = true;
            }
            if (s.Equals("Sports Association Manager"))
            {
                Button4.Visible = true;
                formAll.Visible = true;
                formFan.Visible = false;
                formRepresentative.Visible = false;
                formSportsManager.Visible = false;
                formStadiumManager.Visible = false;
                formSportsManager.Visible = true;
            }
            if (s.Equals("Club Representative"))
            {
                Button4.Visible = true;
                formAll.Visible = true;
                formFan.Visible = false;
                formRepresentative.Visible = false;
                formSportsManager.Visible = false;
                formStadiumManager.Visible = false;
                formRepresentative.Visible = true;
            }
            if (s.Equals("Select your type"))
            {
                Button4.Visible = false;
                formAll.Visible = false;
                formFan.Visible = false;
                formRepresentative.Visible = false;
                formSportsManager.Visible = false;
                formStadiumManager.Visible = false;
            }
        }



        private Boolean registerAsStadium_Manager()
        {
            string sname = name.Text;
            string susername = UserName.Text;
            string spassword = Password.Text;
            string sstadiumname = StadiumName.Text;
            if (sname.Equals("") || susername.Equals("") || spassword.Equals("") || sstadiumname.Equals(""))
            {
                return false;
            }
            try
            {


                conn.Open();
                SqlCommand logicc = new SqlCommand("select * from Stadium where name=@stadiumName", conn);
                logicc.Parameters.Add(new SqlParameter("@stadiumName", sstadiumname));
                SqlDataReader readerUser = logicc.ExecuteReader();
                if (!readerUser.HasRows)
                {

                    regwarningused.InnerText = "No stadium with that name";
                    regwarningused.Visible = true;
                    conn.Close();
                    return false;
                }
                else
                    regwarningused.Visible = false;
                conn.Close();




                conn.Open();
                SqlCommand logic = new SqlCommand("addStadiumManager @name,@stadiumname,@username,@password", conn);
                logic.Parameters.Add(new SqlParameter("@name", sname));
                logic.Parameters.Add(new SqlParameter("@stadiumname", sstadiumname));
                logic.Parameters.Add(new SqlParameter("@username", susername));

                logic.Parameters.Add(new SqlParameter("@password", spassword));
                logic.ExecuteNonQuery();
                conn.Close();
            }
            catch (Exception e)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('"+e.Message+"');", true);
                return false;
            }
            return true;
        }

        private Boolean registerAsSports_Association_Manager()
        {
            string sname = name.Text;
            string susername = UserName.Text;
            string spassword = Password.Text;
            if (sname.Equals("") || susername.Equals("") || spassword.Equals(""))
            {
                return false;
            }
            try
            {
                conn.Open();
                SqlCommand logic = new SqlCommand("addAssociationManager @name,@username,@password", conn);
                logic.Parameters.Add(new SqlParameter("@name", sname));
                logic.Parameters.Add(new SqlParameter("@username", susername));
                logic.Parameters.Add(new SqlParameter("@password", spassword));
                logic.ExecuteNonQuery();
                conn.Close();
            }
            catch (Exception e)
            {
                Response.Write(e.Message);
                return false;
            }
            return true;
        }

        private Boolean registerAsClub_Representative()
        {
            string sname = name.Text;
            string susername = UserName.Text;
            string spassword = Password.Text;
            string sclubName = ClubName.Text;
            if (sname.Equals("") || susername.Equals("") || spassword.Equals("") || sclubName.Equals(""))
            {
                return false;
            }
            try
            {


                conn.Open();
                SqlCommand logicc = new SqlCommand("select * from club where name=@clubname", conn);
                logicc.Parameters.Add(new SqlParameter("@clubname", sclubName));
                SqlDataReader readerUser = logicc.ExecuteReader();
                if (!readerUser.HasRows)
                {

                    regwarningused.InnerText = "No club with that name";
                    regwarningused.Visible = true;
                    conn.Close();
                    return false;
                }
                else
                    regwarningused.Visible = false;
                conn.Close();



                conn.Open();
                SqlCommand logic = new SqlCommand("addRepresentative  @name ,@clubName ,@username , @password", conn);
                logic.Parameters.Add(new SqlParameter("@name", sname));
                logic.Parameters.Add(new SqlParameter("@username", susername));
                logic.Parameters.Add(new SqlParameter("@password", spassword));
                logic.Parameters.Add(new SqlParameter("@clubName", sclubName));
                Response.Write(spassword);
                logic.ExecuteNonQuery();
                conn.Close();
            }
            catch (Exception e)
            {
                Response.Write(e.Message);
                return false;
            }
            return true;
        }

        private Boolean registerAsFan()
        {
            string sname = name.Text;
            string susername = UserName.Text;
            string spassword = Password.Text;
            string snationalId = nationalID.Text;
            string sbirth_date = birth_date.Text;
            string saddress = address.Text;
            string sphoneNumber = phone_no.Text;
            if (sname.Equals("") || susername.Equals("") || spassword.Equals("") || snationalId.Equals("") || sbirth_date.Equals("") || saddress.Equals("") || sphoneNumber.Equals(""))
            {
                return false;
            }
            DateTime date = new DateTime();
            try
            {
                date = DateTime.ParseExact(sbirth_date, "yyyy-M-dd", new System.Globalization.CultureInfo("en-US"));
                conn.Open();
                SqlCommand logic = new SqlCommand("addFan @name,@username,@password ,@nationalID,@birthDate ,@address ,@phoneNUmber", conn);
                logic.Parameters.Add(new SqlParameter("@name", sname));
                logic.Parameters.Add(new SqlParameter("@username", susername));
                logic.Parameters.Add(new SqlParameter("@nationalID", snationalId));
                logic.Parameters.Add(new SqlParameter("@password", spassword));
                logic.Parameters.Add(new SqlParameter("@birthDate", date));
                logic.Parameters.Add(new SqlParameter("@address", saddress));
                logic.Parameters.Add(new SqlParameter("@phoneNUmber", sphoneNumber));
                logic.ExecuteNonQuery();
                conn.Close();
            }
            catch (Exception e)
            {
                Response.Write(e.Message);
                return false;
            }


            return true;
        }

        protected void Register_click(object sender, EventArgs e)
        {
            conn.Open();
            SqlCommand logic = new SqlCommand("select * from SystemUser where username=@username", conn);
            logic.Parameters.Add(new SqlParameter("@username", UserName.Text));
            SqlDataReader readerUser = logic.ExecuteReader();
            if (readerUser.HasRows && !UserName.Text.Equals(""))
            {
                regwarningused.InnerText = "Already used username";
                regwarningused.Visible = true;
                conn.Close();
                return;
            }
            else
                regwarningused.Visible = false;
            conn.Close();

            String s = DropDownList1.SelectedValue;
            Boolean flag = true;
            if (s.Equals("Fan"))
            {
                flag = registerAsFan();
            }
            if (s.Equals("Stadium Manager"))
            {
                flag = registerAsStadium_Manager();
            }
            if (s.Equals("Sports Association Manager"))
            {
                flag = registerAsSports_Association_Manager();

            }
            if (s.Equals("Club Representative"))
            {
                Response.Write("club Representative");
                flag = registerAsClub_Representative();
            }
            if (!flag)
            {
                regwarning.Visible = true;
            }
            else
                regwarning.Visible = false;

        }
    }
}