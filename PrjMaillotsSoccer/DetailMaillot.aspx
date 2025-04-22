<%@ Page Title="Details du Maillot" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetailMaillot.aspx.cs" Inherits="PrjMaillotsSoccer.DetailMaillot" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Etes-vous sur de vouloir supprimer ce maillot ?");
        }
    </script>

    <style>
        .product-image {
            transition: transform 0.3s ease;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.12);
            margin-bottom: 20px;
            height: 450px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(145deg, #ffffff, #f5f7fa);
        }
        .product-image:hover {
            transform: scale(1.02);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }
        .product-image img {
            max-height: 400px;
            object-fit: contain;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            background: linear-gradient(145deg, #ffffff, #f9fafb);
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.12);
        }
        .product-title {
            color: #2c3e50;
            font-weight: 700;
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 1rem;
            font-size: 2.2rem;
        }
        .info-section {
            background: linear-gradient(145deg, #f8f9fa, #ffffff);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }
        .info-section:hover {
         transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        }
        .info-label {
            color: #6c757d;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.7rem;
            font-weight: 600;
        }
        .info-value {
            color: #2c3e50;
            font-size: 1.2rem;
            font-weight: 500;
        }
        .price-tag {
            font-size: 2rem;
            font-weight: 700;
            color: #2563eb;
            display: flex;
            align-items: center;
        }
        .price-tag::before {
            content: "";
            display: inline-block;
            width: 8px;
            height: 8px;
            background-color: #2563eb;
            border-radius: 50%;
            margin-right: 10px;
        }
        .availability-badge {
            padding: 0.6rem 1.2rem;
            border-radius: 50px;
            font-weight: 600;
            letter-spacing: 0.5px;
            font-size: 1rem;
        }
        .btn-action {
            padding: 0.9rem 1.8rem;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            font-size: 0.95rem;
        }
        .btn-primary {
            background: linear-gradient(145deg, #2563eb, #1e40af);
            border: none;
        }
        .btn-outline-secondary {
            border: 2px solid #6c757d;
            color: #6c757d;
        }
        .btn-danger {
            background: linear-gradient(145deg, #ef4444, #dc2626);
            border: none;
            color: #fff;
        }
        .btn-action:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .btn-primary:hover {
            background: linear-gradient(145deg, #1e40af, #1e3a8a);
        }
        .btn-danger:hover {
            background: linear-gradient(145deg, #dc2626, #b91c1c);
        }
        .breadcrumb {
            background: transparent;
            padding: 1rem 0;
            margin-bottom: 2rem;
        }
        .breadcrumb-item a {
            color: #2563eb;
            text-decoration: none;
            transition: color 0.3s ease;
            font-weight: 500;
        }
        .breadcrumb-item a:hover {
            color: #1e40af;
        }
        .breadcrumb-item.active {
            color: #6c757d;
            font-weight: 500;
        }
        .badge.bg-success {
            background: linear-gradient(145deg, #10b981, #059669) !important;
        }
        .badge.bg-danger {
            background: linear-gradient(145deg, #ef4444, #dc2626) !important;
        }
        .product-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
    </style>

    <div class="container py-5">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Default.aspx">Accueil</a></li>
                <li class="breadcrumb-item active" aria-current="page">Details du maillot</li>
            </ol>
        </nav>

        <div class="row g-4">
            <div class="col-lg-6">
                <div class="product-image">
                    <asp:Image ID="imgMaillot" runat="server" CssClass="img-fluid" />
                </div>
            </div>
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-body p-4 p-lg-5">
                        <h1 class="product-title">
                            <asp:Label ID="lblNom" runat="server" />
                        </h1>
                        
                        <div class="info-section mb-4">
                            <div class="info-label">Description</div>
                            <div class="info-value">
                                <asp:Label ID="lblDescription" runat="server" />
                            </div>
                        </div>

                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="info-section">
                                    <div class="info-label">Prix</div>
                                    <div class="price-tag">
                                        <asp:Label ID="lblPrix" runat="server" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-section">
                                    <div class="info-label">Disponibilite</div>
                                    <asp:Label ID="lblDisponibilite" runat="server" CssClass="availability-badge" />
                                </div>
                            </div>
                        </div>

                        <div class="row g-4 mt-1">
                            <div class="col-md-6">
                                <div class="info-section">
                                    <div class="info-label">Equipe</div>
                                    <div class="info-value">
                                        <asp:Label ID="lblEquipe" runat="server" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-section">
                                    <div class="info-label">Taille</div>
                                    <div class="info-value">
                                        <asp:Label ID="lblTaille" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="info-section mt-4">
                            <div class="info-label">Couleur</div>
                            <div class="info-value">
                                <asp:Label ID="lblCouleur" runat="server" />
                            </div>
                        </div>

                        <div class="product-actions">
                            <asp:Button ID="btnModifier" runat="server" Text="Modifier" 
                                CssClass="btn btn-primary btn-action" OnClick="btnModifier_Click" />
                            <asp:Button ID="btnSupprimer" runat="server" Text="Supprimer" 
                                CssClass="btn btn-danger btn-action" OnClientClick="return confirmDelete();" OnClick="btnSupprimer_Click" />
                            <asp:Button ID="btnRetour" runat="server" Text="Retour" 
                                CssClass="btn btn-outline-secondary btn-action" OnClick="btnRetour_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>