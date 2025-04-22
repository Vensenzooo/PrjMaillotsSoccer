<%@ Page Title="Accueil" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PrjMaillotsSoccer.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        
        .page-header {
            padding: 2rem 0;
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #1e3a8a;
            margin-bottom: 1rem;
        }
        
        .page-subtitle {
            font-size: 1.2rem;
            color: #6c757d;
            max-width: 700px;
            margin: 0 auto;
        }
        
        
        .filter-container {
            background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
            border-radius: 15px;
            padding: 25px 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            border: 1px solid rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
        }
        
        .filter-container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, #2563eb, #1e40af);
        }
        
        .filter-header {
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 15px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .filter-header h4 {
            color: #1e3a8a;
            font-weight: 700;
            margin: 0;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
        }
        
        .filter-header h4 i {
            margin-right: 10px;
            color: #2563eb;
        }
        
        .filter-options {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .filter-option {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 18px;
            border-radius: 50px;
            background: #fff;
            border: 1px solid #e9ecef;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
        }
        
        .filter-option:hover {
            border-color: #2563eb;
            background-color: #f0f4ff;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(37, 99, 235, 0.1);
        }
        
        .filter-option input[type="checkbox"] {
            margin: 0;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            cursor: pointer;
        }
        
        .filter-option label {
            font-weight: 500;
            color: #4b5563;
            margin: 0;
            cursor: pointer;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
        }
        
        .filter-option label img {
            width: 24px;
            height: 16px;
            margin-right: 8px;
        }
        
        .btn-reset {
            background: #f3f4f6;
            color: #4b5563;
            border: none;
            padding: 10px 20px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-reset:hover {
            background: #e5e7eb;
            color: #1f2937;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        
        .products-table {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            overflow: hidden;
            border: 1px solid rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }
        
        .products-table table {
            margin: 0;
        }
        
        .products-table th {
            background: #f8f9fa;
            border-bottom: 2px solid #e9ecef;
            padding: 15px;
            font-weight: 600;
            color: #1e3a8a;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }
        
        .products-table td {
            padding: 18px 15px;
            vertical-align: middle;
            border-bottom: 1px solid #f3f4f6;
        }
        
        .products-table tr:hover {
            background-color: #f9fafb;
        }
        
        .product-image {
            width: 100px;
            height: 100px;
            object-fit: contain;
            border-radius: 10px;
            transition: transform 0.3s ease;
            border: 1px solid #f3f4f6;
            background: #fff;
            padding: 5px;
        }
        
        .product-image:hover {
            transform: scale(1.05);
        }
        
        .product-name {
            font-weight: 600;
            color: #1e3a8a;
            font-size: 1.05rem;
        }
        
        .product-description {
            color: #6b7280;
            font-size: 0.9rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .product-team {
            color: #4b5563;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .product-price {
            font-weight: 700;
            color: #2563eb;
            font-size: 1.2rem;
        }
        
        
        .action-buttons {
            display: flex;
            gap: 12px;
            align-items: center;
        }
        
        .order-buttons {
            display: flex;
            gap: 8px;
        }
        
        .btn-order {
            border-radius: 50%;
            width: 38px;
            height: 38px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            font-size: 0.85rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .btn-up {
            background: linear-gradient(145deg, #10b981, #059669);
            border: none;
            color: white;
        }
        
        .btn-up:hover {
            background: linear-gradient(145deg, #059669, #047857);
            color: white;
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 8px 15px rgba(5, 150, 105, 0.3);
        }
        
        .btn-down {
            background: linear-gradient(145deg, #f59e0b, #d97706);
            border: none;
            color: white;
        }
        
        .btn-down:hover {
            background: linear-gradient(145deg, #d97706, #b45309);
            color: white;
            transform: translateY(3px) scale(1.05);
            box-shadow: 0 8px 15px rgba(217, 119, 6, 0.3);
        }
        
        .btn-details {
            padding: 8px 16px;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            background: linear-gradient(145deg, #2563eb, #1e40af);
            border: none;
            color: white;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
        }
        
        .btn-details:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(37, 99, 235, 0.3);
            background: linear-gradient(145deg, #1e40af, #1e3a8a);
        }
        
        
        .pagination {
            margin-top: 2rem;
            margin-bottom: 3rem;
        }
        
        .pagination .page-link {
            color: #2563eb;
            padding: 10px 18px;
            border-radius: 10px;
            margin: 0 5px;
            font-weight: 500;
            border: 1px solid #e5e7eb;
            transition: all 0.3s ease;
        }
        
        .pagination .page-link:hover {
            background-color: #f3f4f6;
            color: #1e40af;
            border-color: #d1d5db;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        
        .pagination .active .page-link {
            background: linear-gradient(145deg, #2563eb, #1e40af);
            border-color: #2563eb;
            color: white;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
        }
        
        .pagination .active .page-link:hover {
            transform: none;
        }
        
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .animate-fade-in {
            animation: fadeIn 0.5s ease-out forwards;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4 animate-fade-in">
        <% if (Session["SuccessMessage"] != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i> <%= Session["SuccessMessage"] %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% Session["SuccessMessage"] = null; } %>
        
        <div class="page-header">
            <h1 class="page-title">Collection de Maillots Soccer 2026</h1>
            <p class="page-subtitle">Découvrez notre sélection de maillots officiels pour la Coupe du Monde 2026 organisée au Canada, aux États-Unis et au Mexique.</p>
        </div>
    
        
        <div class="filter-container">
            <div class="filter-header">
                <h4><i class="fas fa-filter"></i> Filtrer par équipe</h4>
                <button type="button" class="btn-reset" onclick="javascript:__doPostBack('<%= btnReset.UniqueID %>', '')">
                    <i class="fas fa-undo-alt"></i> Réinitialiser
                </button>
                <asp:Button ID="btnReset" runat="server" Text="Réinitialiser les filtres" 
                    CssClass="btn-reset d-none" OnClick="btnReset_Click" />
            </div>
            <div class="filter-options">
                <div class="filter-option">
                    <asp:CheckBox ID="chkCanada" runat="server" AutoPostBack="true" OnCheckedChanged="chkCanada_CheckedChanged" />
                    <label for="<%= chkCanada.ClientID %>">
                        <img src="https://flagcdn.com/w20/ca.png" alt="Canada" /> Canada
                    </label>
                </div>
                <div class="filter-option">
                    <asp:CheckBox ID="chkUSA" runat="server" AutoPostBack="true" OnCheckedChanged="chkUSA_CheckedChanged" />
                    <label for="<%= chkUSA.ClientID %>">
                        <img src="https://flagcdn.com/w20/us.png" alt="USA" /> États-Unis
                    </label>
                </div>
                <div class="filter-option">
                    <asp:CheckBox ID="chkMexique" runat="server" AutoPostBack="true" OnCheckedChanged="chkMexique_CheckedChanged" />
                    <label for="<%= chkMexique.ClientID %>">
                        <img src="https://flagcdn.com/w20/mx.png" alt="Mexique" /> Mexique
                    </label>
                </div>
            </div>
        </div>

        
        <div class="products-table">
            <asp:Repeater ID="rptMaillots" runat="server" OnItemCommand="rptMaillots_ItemCommand">
                <HeaderTemplate>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Image</th>
                                <th>Maillot</th>
                                <th>Équipe</th>
                                <th>Prix</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <img src='<%# Eval("ImageUrl") %>' class="product-image" alt='<%# Eval("Nom") %>' />
                        </td>
                        <td>
                            <div class="product-name"><%# Eval("Nom") %></div>
                            <div class="product-description"><%# Eval("Description") %></div>
                        </td>
                        <td>
                            <div class="product-team">
                                <%# GetTeamFlag(Eval("Equipe").ToString()) %>
                                <%# Eval("Equipe") %>
                            </div>
                        </td>
                        <td><div class="product-price"><%# Eval("Prix", "{0:C}") %></div></td>
                        <td>
                            <div class="action-buttons">
                                <asp:LinkButton ID="lnkDetails" runat="server" CssClass="btn btn-details"
                                    CommandName="VoirDetails" CommandArgument='<%# Eval("Id") %>'>
                                    <i class="fas fa-eye me-1"></i> Détails
                                </asp:LinkButton>
                                <div class="order-buttons">
                                    <asp:LinkButton ID="btnMonter" runat="server" CssClass="btn btn-order btn-up"
                                        CommandName="Monter" CommandArgument='<%# Eval("Id") %>'
                                        Visible='<%# Eval("Ordre") != DBNull.Value && (int)Eval("Ordre") > 1 %>'
                                        ToolTip="Monter ce maillot">
                                        <i class="fas fa-chevron-up"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDescendre" runat="server" CssClass="btn btn-order btn-down"
                                        CommandName="Descendre" CommandArgument='<%# Eval("Id") %>'
                                        ToolTip="Descendre ce maillot">
                                        <i class="fas fa-chevron-down"></i>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>

       
        <div class="row">
            <div class="col-12">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item">
                            <asp:LinkButton ID="btnPrev" runat="server" CssClass="page-link" OnClick="btnPrev_Click">
                                <i class="fas fa-chevron-left"></i>
                            </asp:LinkButton>
                        </li>
                        <asp:Repeater ID="rptPagination" runat="server">
                            <ItemTemplate>
                                <li class='page-item <%# Convert.ToInt32(Eval("PageNumber")) == CurrentPage ? "active" : "" %>'>
                                    <asp:LinkButton ID="lnkPage" runat="server" CssClass="page-link"
                                        CommandArgument='<%# Eval("PageNumber") %>'
                                        OnClick="lnkPage_Click">
                                        <%# Eval("PageNumber") %>
                                    </asp:LinkButton>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                        <li class="page-item">
                            <asp:LinkButton ID="btnNext" runat="server" CssClass="page-link" OnClick="btnNext_Click">
                                <i class="fas fa-chevron-right"></i>
                            </asp:LinkButton>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</asp:Content>
