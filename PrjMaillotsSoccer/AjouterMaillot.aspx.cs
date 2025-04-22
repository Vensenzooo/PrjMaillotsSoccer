using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace PrjMaillotsSoccer
{
    public partial class AjouterMaillot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerMaillots();
            }
        }

        protected void btnAjouter_Click(object sender, EventArgs e)
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
                    // Récupérer le plus grand ordre actuel
                    string queryOrdre = "SELECT ISNULL(MAX(Ordre), 0) FROM Maillot";
                    int nouvelOrdre;
                    using (SqlCommand cmd = new SqlCommand(queryOrdre, conn))
                    {
                        conn.Open();
                        nouvelOrdre = Convert.ToInt32(cmd.ExecuteScalar()) + 1;
                    }

                    // Insérer le nouveau maillot
                    string query = @"INSERT INTO Maillot (Nom, Description, Prix, Couleur, ImageUrl, Equipe, Taille, Disponibilite, Ordre, DateAjout) 
                                   VALUES (@Nom, @Description, @Prix, @Couleur, @ImageUrl, @Equipe, @Taille, @Disponibilite, @Ordre, GETDATE())";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Nom", txtNom.Text);
                        cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                        cmd.Parameters.AddWithValue("@Prix", prix);
                        cmd.Parameters.AddWithValue("@Couleur", txtCouleur.Text);
                        cmd.Parameters.AddWithValue("@ImageUrl", txtImageUrl.Text);
                        cmd.Parameters.AddWithValue("@Equipe", txtEquipe.Text);
                        cmd.Parameters.AddWithValue("@Taille", ddlTaille.SelectedValue);
                        cmd.Parameters.AddWithValue("@Disponibilite", chkDisponibilite.Checked);
                        cmd.Parameters.AddWithValue("@Ordre", nouvelOrdre);

                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Redirect("Default.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = $"Erreur : {ex.Message}";
            }
        }

        protected void btnRetour_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        private void ChargerMaillots()
        {
            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnexionMaillots"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT Id, Nom, Prix, ImageUrl FROM Maillot ORDER BY Id DESC";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        List<object> maillots = new List<object>();

                        while (reader.Read())
                        {
                            maillots.Add(new
                            {
                                id = Convert.ToInt32(reader["Id"]),
                                nom = reader["Nom"].ToString(),
                                prix = Convert.ToDecimal(reader["Prix"], CultureInfo.InvariantCulture),
                                ImageUrl = reader["ImageUrl"].ToString()
                            });
                        }

                        GridViewMaillots.DataSource = maillots;
                        GridViewMaillots.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Erreur : " + ex.Message;
            }
        }

        protected void GridViewMaillots_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewMaillots.EditIndex = e.NewEditIndex;
            ChargerMaillots();
        }

        protected void GridViewMaillots_RowCancellingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewMaillots.EditIndex = -1;
            ChargerMaillots();
        }

        protected void GridViewMaillots_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridViewMaillots.Rows[e.RowIndex];
            int id = Convert.ToInt32(GridViewMaillots.DataKeys[e.RowIndex].Value);

            TextBox txtNom = (TextBox)row.FindControl("txtEditNom");
            TextBox txtPrix = (TextBox)row.FindControl("txtEditPrix");
            TextBox txtImageUrl = (TextBox)row.FindControl("txtEditImageUrl");

            if (txtNom == null || txtPrix == null || txtImageUrl == null)
            {
                lblMessage.Text = "Erreur : Impossible de récupérer les valeurs.";
                return;
            }

            string nom = txtNom.Text;
            string imageUrl = txtImageUrl.Text;

            if (!decimal.TryParse(txtPrix.Text.Replace(",", "."), NumberStyles.Any, CultureInfo.InvariantCulture, out decimal prix))
            {
                lblMessage.Text = "Veuillez entrer un prix valide.";
                return;
            }

            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnexionMaillots"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Maillot SET Nom=@Nom, Prix=@Prix, ImageUrl=@ImageUrl WHERE Id=@Id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.Parameters.AddWithValue("@Nom", nom);
                        cmd.Parameters.AddWithValue("@Prix", prix);
                        cmd.Parameters.AddWithValue("@ImageUrl", imageUrl);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                GridViewMaillots.EditIndex = -1;
                ChargerMaillots();
                lblMessage.Text = "Maillot mis à jour avec succès.";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Erreur : " + ex.Message;
            }
        }

        protected void GridViewMaillots_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridViewMaillots.DataKeys[e.RowIndex].Value);

            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnexionMaillots"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Maillot WHERE Id=@Id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                ChargerMaillots();
                lblMessage.Text = "Maillot supprimé avec succès.";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Erreur : " + ex.Message;
            }
        }
    }
}