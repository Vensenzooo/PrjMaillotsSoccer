using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace PrjMaillotsSoccer
{
    public partial class DetailMaillot : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(id))
                {
                    ChargerDetailsMaillot(Convert.ToInt32(id));
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        private void ChargerDetailsMaillot(int id)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnexionMaillots"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT Id, Nom, Description, Prix, Couleur, ImageUrl, Equipe, Taille, Disponibilite 
                               FROM Maillot WHERE Id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblNom.Text = reader["Nom"].ToString();
                            lblDescription.Text = reader["Description"].ToString();
                            lblPrix.Text = string.Format("{0:C}", reader["Prix"]);
                            lblCouleur.Text = reader["Couleur"].ToString();
                            lblEquipe.Text = reader["Equipe"].ToString();
                            lblTaille.Text = reader["Taille"].ToString();
                            imgMaillot.ImageUrl = reader["ImageUrl"].ToString();
                            lblDisponibilite.Text = Convert.ToBoolean(reader["Disponibilite"]) ? "En stock" : "Rupture de stock";
                            lblDisponibilite.CssClass = Convert.ToBoolean(reader["Disponibilite"]) ? "badge bg-success" : "badge bg-danger";
                        }
                        else
                        {
                            Response.Redirect("Default.aspx");
                        }
                    }
                }
            }
        }

        // Méthode pour obtenir l'URL du drapeau correspondant à l'équipe
        protected string GetTeamFlag(string equipe)
        {
            if (equipe.Contains("Canada"))
            {
                return "https://flagcdn.com/w40/ca.png";
            }
            else if (equipe.Contains("USA") || equipe.Contains("États-Unis"))
            {
                return "https://flagcdn.com/w40/us.png";
            }
            else if (equipe.Contains("Mexique"))
            {
                return "https://flagcdn.com/w40/mx.png";
            }
            else if (equipe.Contains("Brésil"))
            {
                return "https://flagcdn.com/w40/br.png";
            }
            else if (equipe.Contains("Argentine"))
            {
                return "https://flagcdn.com/w40/ar.png";
            }
            else if (equipe.Contains("France"))
            {
                return "https://flagcdn.com/w40/fr.png";
            }
            else if (equipe.Contains("Allemagne"))
            {
                return "https://flagcdn.com/w40/de.png";
            }
            else if (equipe.Contains("Espagne"))
            {
                return "https://flagcdn.com/w40/es.png";
            }

            // Par défaut
            return "https://flagcdn.com/w40/un.png";
        }

        protected void btnRetour_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void btnModifier_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            Response.Redirect($"ModifierMaillot.aspx?id={id}");
        }

        protected void btnSupprimer_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(id))
            {
                // Supprimer le maillot de la base de données
                if (SupprimerMaillot(Convert.ToInt32(id)))
                {
                    // Rediriger vers la page d'accueil avec un message de succès
                    Session["SuccessMessage"] = "Le maillot a été supprimé avec succès.";
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    // Afficher un message d'erreur en cas d'échec
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage",
                        "alert('Une erreur est survenue lors de la suppression du maillot.');", true);
                }
            }
        }

        private bool SupprimerMaillot(int id)
        {
            bool resultat = false;
            string connectionString = ConfigurationManager.ConnectionStrings["ConnexionMaillots"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    string query = "DELETE FROM Maillot WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        resultat = (rowsAffected > 0);
                    }
                }
                catch (Exception ex)
                {
                    // Log l'exception
                    System.Diagnostics.Debug.WriteLine("Erreur lors de la suppression du maillot : " + ex.Message);
                    resultat = false;
                }
            }

            return resultat;
        }
    }
}