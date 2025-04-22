using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace PrjMaillotsSoccer
{
    public partial class Default : System.Web.UI.Page
    {
        private const int PageSize = 9;
        protected int CurrentPage
        {
            get { return ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 1; }
            set { ViewState["CurrentPage"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerMaillots();
            }
        }

        private void ChargerMaillots()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnexionMaillots"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Maillot WHERE 1=1";
                List<string> conditions = new List<string>();
                List<SqlParameter> parameters = new List<SqlParameter>();

                // Filtre par équipe
                if (chkCanada.Checked)
                {
                    conditions.Add("Equipe = @Canada");
                    parameters.Add(new SqlParameter("@Canada", "Canada"));
                }
                if (chkUSA.Checked)
                {
                    conditions.Add("Equipe = @USA");
                    parameters.Add(new SqlParameter("@USA", "USA"));
                }
                if (chkMexique.Checked)
                {
                    conditions.Add("Equipe = @Mexique");
                    parameters.Add(new SqlParameter("@Mexique", "Mexique"));
                }

                // Ajouter les conditions à la requête
                if (conditions.Count > 0)
                {
                    query += " AND (" + string.Join(" OR ", conditions) + ")";
                }

                // Pagination
                int offset = (CurrentPage - 1) * PageSize;
                query = $@"
                    SELECT *
                    FROM (
                        SELECT *, ROW_NUMBER() OVER (ORDER BY Ordre) AS RowNum
                        FROM Maillot
                        WHERE 1=1 {(conditions.Count > 0 ? " AND (" + string.Join(" OR ", conditions) + ")" : "")}
                    ) AS PagedQuery
                    WHERE RowNum BETWEEN @Offset + 1 AND @Offset + @PageSize";

                parameters.Add(new SqlParameter("@Offset", offset));
                parameters.Add(new SqlParameter("@PageSize", PageSize));

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddRange(parameters.ToArray());

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                rptMaillots.DataSource = dt;
                rptMaillots.DataBind();

                // Charger la pagination
                ChargerPagination();
            }
        }

        private void ChargerPagination()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnexionMaillots"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string countQuery = "SELECT COUNT(*) FROM Maillot WHERE 1=1";
                List<string> conditions = new List<string>();
                List<SqlParameter> parameters = new List<SqlParameter>();

                if (chkCanada.Checked)
                {
                    conditions.Add("Equipe = @Canada");
                    parameters.Add(new SqlParameter("@Canada", "Canada"));
                }
                if (chkUSA.Checked)
                {
                    conditions.Add("Equipe = @USA");
                    parameters.Add(new SqlParameter("@USA", "USA"));
                }
                if (chkMexique.Checked)
                {
                    conditions.Add("Equipe = @Mexique");
                    parameters.Add(new SqlParameter("@Mexique", "Mexique"));
                }

                if (conditions.Count > 0)
                {
                    countQuery += " AND (" + string.Join(" OR ", conditions) + ")";
                }

                SqlCommand cmd = new SqlCommand(countQuery, conn);
                cmd.Parameters.AddRange(parameters.ToArray());

                conn.Open();
                int totalRecords = (int)cmd.ExecuteScalar();
                conn.Close();

                int totalPages = (int)Math.Ceiling(totalRecords / (double)PageSize);
                var pages = new List<object>();

                for (int i = 1; i <= totalPages; i++)
                {
                    pages.Add(new { PageNumber = i });
                }

                rptPagination.DataSource = pages;
                rptPagination.DataBind();

                // Mettre à jour l'état des boutons de navigation
                btnPrev.Enabled = CurrentPage > 1;
                btnNext.Enabled = CurrentPage < totalPages;
            }
        }

        protected void rptMaillots_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "VoirDetails")
            {
                string id = e.CommandArgument.ToString();
                Response.Redirect($"DetailMaillot.aspx?id={id}");
            }
            else if (e.CommandName == "Monter" || e.CommandName == "Descendre")
            {
                string id = e.CommandArgument.ToString();
                ChangerOrdre(id, e.CommandName == "Monter");
                ChargerMaillots();
            }
        }

        private void ChangerOrdre(string id, bool monter)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnexionMaillots"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // Récupérer l'ordre actuel
                        string queryOrdre = "SELECT Ordre FROM Maillot WHERE Id = @Id";
                        SqlCommand cmdOrdre = new SqlCommand(queryOrdre, conn, transaction);
                        cmdOrdre.Parameters.AddWithValue("@Id", id);
                        int ordreActuel = (int)cmdOrdre.ExecuteScalar();

                        // Calculer le nouvel ordre
                        int nouvelOrdre = monter ? ordreActuel - 1 : ordreActuel + 1;

                        // Mettre à jour l'ordre
                        string queryUpdate = "UPDATE Maillot SET Ordre = @NouvelOrdre WHERE Id = @Id";
                        SqlCommand cmdUpdate = new SqlCommand(queryUpdate, conn, transaction);
                        cmdUpdate.Parameters.AddWithValue("@NouvelOrdre", nouvelOrdre);
                        cmdUpdate.Parameters.AddWithValue("@Id", id);
                        cmdUpdate.ExecuteNonQuery();

                        transaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        throw ex;
                    }
                }
            }
        }

        protected void chkCanada_CheckedChanged(object sender, EventArgs e)
        {
            CurrentPage = 1;
            ChargerMaillots();
        }

        protected void chkUSA_CheckedChanged(object sender, EventArgs e)
        {
            CurrentPage = 1;
            ChargerMaillots();
        }

        protected void chkMexique_CheckedChanged(object sender, EventArgs e)
        {
            CurrentPage = 1;
            ChargerMaillots();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            chkCanada.Checked = false;
            chkUSA.Checked = false;
            chkMexique.Checked = false;
            CurrentPage = 1;
            ChargerMaillots();
        }

        protected void lnkPage_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;
            CurrentPage = int.Parse(lnk.CommandArgument);
            ChargerMaillots();
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 1)
            {
                CurrentPage--;
                ChargerMaillots();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            CurrentPage++;
            ChargerMaillots();
        }

        // Méthode pour afficher le drapeau correspondant à l'équipe
        protected string GetTeamFlag(string equipe)
        {
            string flagHtml = "";

            if (equipe.Contains("Canada"))
            {
                flagHtml = "<img src='https://flagcdn.com/w20/ca.png' alt='Canada' style='margin-right: 8px;' />";
            }
            else if (equipe.Contains("USA") || equipe.Contains("États-Unis"))
            {
                flagHtml = "<img src='https://flagcdn.com/w20/us.png' alt='USA' style='margin-right: 8px;' />";
            }
            else if (equipe.Contains("Mexique"))
            {
                flagHtml = "<img src='https://flagcdn.com/w20/mx.png' alt='Mexique' style='margin-right: 8px;' />";
            }
            else if (equipe.Contains("Brésil"))
            {
                flagHtml = "<img src='https://flagcdn.com/w20/br.png' alt='Brésil' style='margin-right: 8px;' />";
            }
            else if (equipe.Contains("Argentine"))
            {
                flagHtml = "<img src='https://flagcdn.com/w20/ar.png' alt='Argentine' style='margin-right: 8px;' />";
            }
            else if (equipe.Contains("France"))
            {
                flagHtml = "<img src='https://flagcdn.com/w20/fr.png' alt='France' style='margin-right: 8px;' />";
            }
            else if (equipe.Contains("Allemagne"))
            {
                flagHtml = "<img src='https://flagcdn.com/w20/de.png' alt='Allemagne' style='margin-right: 8px;' />";
            }
            else if (equipe.Contains("Espagne"))
            {
                flagHtml = "<img src='https://flagcdn.com/w20/es.png' alt='Espagne' style='margin-right: 8px;' />";
            }
            else
            {
                // Par défaut, icône de ballon de football
                flagHtml = "<i class='fas fa-futbol' style='margin-right: 8px; color: #6c757d;'></i>";
            }

            return flagHtml;
        }
    }
}