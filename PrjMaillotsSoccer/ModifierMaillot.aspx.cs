using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;

namespace PrjMaillotsSoccer
{
    public partial class ModifierMaillot : System.Web.UI.Page
    {
        // Utiliser une propriété de ViewState pour conserver l'ID du maillot entre les postbacks
        private int MaillotId
        {
            get { return ViewState["MaillotId"] != null ? (int)ViewState["MaillotId"] : 0; }
            set { ViewState["MaillotId"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    MaillotId = Convert.ToInt32(Request.QueryString["id"]);
                    ChargerMaillot(MaillotId);
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        private void ChargerMaillot(int id)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnexionMaillots"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT Nom, Description, Prix, Couleur, ImageUrl, Equipe, Taille, Disponibilite 
                                   FROM Maillot WHERE Id = @Id";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        conn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtNom.Text = reader["Nom"].ToString();
                                txtDescription.Text = reader["Description"].ToString();
                                txtPrix.Text = Convert.ToDecimal(reader["Prix"]).ToString(CultureInfo.InvariantCulture);
                                txtCouleur.Text = reader["Couleur"].ToString();
                                txtImageUrl.Text = reader["ImageUrl"].ToString();
                                txtEquipe.Text = reader["Equipe"].ToString();
                                ddlTaille.SelectedValue = reader["Taille"].ToString();
                                chkDisponibilite.Checked = Convert.ToBoolean(reader["Disponibilite"]);
                            }
                            else
                            {
                                Response.Redirect("Default.aspx");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = $"Erreur : {ex.Message}";
            }
        }

        protected void btnEnregistrer_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNom.Text) || string.IsNullOrWhiteSpace(txtPrix.Text))
            {
                lblMessage.Text = "Veuillez remplir tous les champs obligatoires.";
                return;
            }

            if (!decimal.TryParse(txtPrix.Text.Replace(",", "."), NumberStyles.Any, CultureInfo.InvariantCulture, out decimal prix))
            {
                lblMessage.Text = "Veuillez entrer un prix valide.";
                return;
            }

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnexionMaillots"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE Maillot 
                                   SET Nom = @Nom, 
                                       Description = @Description, 
                                       Prix = @Prix, 
                                       Couleur = @Couleur, 
                                       ImageUrl = @ImageUrl, 
                                       Equipe = @Equipe, 
                                       Taille = @Taille, 
                                       Disponibilite = @Disponibilite 
                                   WHERE Id = @Id";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", MaillotId);
                        cmd.Parameters.AddWithValue("@Nom", txtNom.Text);
                        cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                        cmd.Parameters.AddWithValue("@Prix", prix);
                        cmd.Parameters.AddWithValue("@Couleur", txtCouleur.Text);
                        cmd.Parameters.AddWithValue("@ImageUrl", txtImageUrl.Text);
                        cmd.Parameters.AddWithValue("@Equipe", txtEquipe.Text);
                        cmd.Parameters.AddWithValue("@Taille", ddlTaille.SelectedValue);
                        cmd.Parameters.AddWithValue("@Disponibilite", chkDisponibilite.Checked);

                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Redirection avec le paramètre d'ID correct et un paramètre de timestamp pour forcer le rafraîchissement
                            Response.Redirect($"DetailMaillot?id={MaillotId}&t={DateTime.Now.Ticks}");
                        }
                        else
                        {
                            lblMessage.Text = "Erreur : Aucun maillot n'a été mis à jour.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = $"Erreur : {ex.Message}";
            }
        }

        protected void btnAnnuler_Click(object sender, EventArgs e)
        {
            Response.Redirect($"DetailMaillot?id={MaillotId}");
        }
    }
}