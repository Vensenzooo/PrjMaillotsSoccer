<%@ Page Title="Ajouter un maillot" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AjouterMaillot.aspx.cs" Inherits="PrjMaillotsSoccer.AjouterMaillot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .form-container {
            max-width: 850px;
            margin: 0 auto;
            background: linear-gradient(145deg, #ffffff, #f9fafb);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        }
        
        .form-title {
            color: #2c3e50;
            font-weight: 700;
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 1rem;
            font-size: 2rem;
            text-align: center;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            display: block;
            color: #6c757d;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        
        .form-control {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 0.2rem rgba(37, 99, 235, 0.25);
            outline: none;
        }
        
        .form-control-textarea {
            min-height: 100px;
            resize: vertical;
        }
        
        .form-check {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .form-check-input {
            margin-right: 10px;
            width: 20px;
            height: 20px;
        }
        
        .form-check-label {
            font-size: 1rem;
            color: #2c3e50;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 2rem;
            justify-content: center;
        }
        
        .btn-action {
            padding: 0.9rem 1.8rem;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            font-size: 0.95rem;
            cursor: pointer;
        }
        
        .btn-primary {
            background: linear-gradient(145deg, #2563eb, #1e40af);
            border: none;
            color: white;
        }
        
        .btn-outline-secondary {
            border: 2px solid #6c757d;
            color: #6c757d;
            background: transparent;
        }
        
        .btn-action:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        
        .btn-primary:hover {
            background: linear-gradient(145deg, #1e40af, #1e3a8a);
        }
        
        .alert {
            padding: 1rem;
            border-radius: 10px;
            margin-top: 1.5rem;
            font-weight: 500;
        }
        
        .alert-success {
            background-color: #d1fae5;
            color: #047857;
            border-left: 4px solid #10b981;
        }
        
        .form-section {
            margin-bottom: 2rem;
        }
        
        .grid-container {
            margin-top: 3rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            padding: 1rem;
        }
        
        .grid-title {
            color: #2c3e50;
            font-weight: 700;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            text-align: center;
        }
        
        .gridview {
            width: 100%;
            border-collapse: collapse;
        }
        
        .gridview th {
            background-color: #f8f9fa;
            color: #2c3e50;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            padding: 1rem;
            text-align: left;
            border-bottom: 2px solid #e9ecef;
        }
        
        .gridview td {
            padding: 1rem;
            border-bottom: 1px solid #e9ecef;
            vertical-align: middle;
        }
        
        .gridview tr:hover {
            background-color: #f8f9fa;
        }
        
        .gridview .btn {
            padding: 0.5rem 1rem;
            border-radius: 5px;
            font-size: 0.85rem;
            font-weight: 500;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .gridview .btn-edit {
            background-color: #2563eb;
            color: white;
            border: none;
        }
        
        .gridview .btn-delete {
            background-color: #ef4444;
            color: white;
            border: none;
        }
        
        .gridview .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
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
    </style>

    <div class="container py-5">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Default.aspx">Accueil</a></li>
                <li class="breadcrumb-item active" aria-current="page">Ajouter un maillot</li>
            </ol>
        </nav>

        <div class="form-container">
            <h2 class="form-title">Ajouter un maillot</h2>

            <div class="form-section">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <asp:Label ID="lblNom" runat="server" Text="Nom du maillot" CssClass="form-label"></asp:Label>
                            <asp:TextBox ID="txtNom" runat="server" CssClass="form-control" placeholder="Entrez le nom du maillot"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <asp:Label ID="lblPrix" runat="server" Text="Prix du maillot" CssClass="form-label"></asp:Label>
                            <asp:TextBox ID="txtPrix" runat="server" CssClass="form-control" placeholder="Entrez le prix"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lblDescription" runat="server" Text="Description" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control form-control-textarea" TextMode="MultiLine" Rows="4" placeholder="Entrez une description détaillée du maillot"></asp:TextBox>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <asp:Label ID="lblCouleur" runat="server" Text="Couleur" CssClass="form-label"></asp:Label>
                            <asp:TextBox ID="txtCouleur" runat="server" CssClass="form-control" placeholder="Couleur principale"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <asp:Label ID="lblEquipe" runat="server" Text="quipe" CssClass="form-label"></asp:Label>
                            <asp:TextBox ID="txtEquipe" runat="server" CssClass="form-control" placeholder="Nom de l'équipe"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <asp:Label ID="lblTaille" runat="server" Text="Taille" CssClass="form-label"></asp:Label>
                            <asp:DropDownList ID="ddlTaille" runat="server" CssClass="form-control">
                                <asp:ListItem Text="XS" Value="XS" />
                                <asp:ListItem Text="S" Value="S" />
                                <asp:ListItem Text="M" Value="M" />
                                <asp:ListItem Text="L" Value="L" />
                                <asp:ListItem Text="XL" Value="XL" />
                                <asp:ListItem Text="XXL" Value="XXL" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <asp:Label ID="lblImageUrl" runat="server" Text="URL de l'image" CssClass="form-label"></asp:Label>
                            <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control" placeholder="URL de l'image du maillot"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="form-check">
                    <asp:CheckBox ID="chkDisponibilite" runat="server" CssClass="form-check-input" Checked="true" />
                    <asp:Label ID="lblDisponibilite" runat="server" Text="Disponible en stock" CssClass="form-check-label" AssociatedControlID="chkDisponibilite"></asp:Label>
                </div>
            </div>

            <div class="button-group">
                <asp:Button ID="btnAjouter" runat="server" Text="Ajouter" CssClass="btn-action btn-primary" OnClick="btnAjouter_Click" />
                <asp:Button ID="btnRetour" runat="server" Text="Retour" CssClass="btn-action btn-outline-secondary" OnClick="btnRetour_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-success" Visible="false"></asp:Label>
        </div>

        <asp:Panel ID="pnlMaillots" runat="server" Visible="false" CssClass="grid-container">
            <h3 class="grid-title">Liste des maillots</h3>
            <asp:GridView ID="GridViewMaillots" runat="server" CssClass="gridview" AutoGenerateColumns="false" DataKeyNames="id" 
                OnRowEditing="GridViewMaillots_RowEditing"
                OnRowCancelingEdit="GridViewMaillots_RowCancellingEdit"
                OnRowUpdating="GridViewMaillots_RowUpdating"
                OnRowDeleting="GridViewMaillots_RowDeleting">
                <Columns>
                    <asp:TemplateField HeaderText="Nom">
                        <ItemTemplate>
                            <%# Eval("nom") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditNom" runat="server" Text='<%# Bind("nom") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Prix">
                        <ItemTemplate>
                            <%# Eval("prix", "{0:N2} €") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditPrix" runat="server" Text='<%# Bind("prix") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <asp:Image ID="imgMaillot" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Width="100px" Height="100px" CssClass="img-thumbnail" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditImageUrl" runat="server" Text='<%# Bind("ImageUrl") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" HeaderText="Actions" ButtonType="Button" 
                        EditText="<i class='fas fa-edit'></i> Modifier" 
                        DeleteText="<i class='fas fa-trash'></i> Supprimer" 
                        CancelText="<i class='fas fa-times'></i> Annuler" 
                        UpdateText="<i class='fas fa-save'></i> Enregistrer" 
                        ControlStyle-CssClass="btn" 
                        EditImageUrl="~/Content/Images/edit.png" 
                        DeleteImageUrl="~/Content/Images/delete.png" 
                        CancelImageUrl="~/Content/Images/cancel.png" 
                        UpdateImageUrl="~/Content/Images/save.png" />
                </Columns>
            </asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>
