<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModifierMaillot.aspx.cs" Inherits="PrjMaillotsSoccer.ModifierMaillot" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Modifier un maillot</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Modifier un maillot</h2>

            <asp:Label ID="lblNom" runat="server" Text="Nom du maillot :"></asp:Label>
            <asp:TextBox ID="txtNom" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:Label ID="lblDescription" runat="server" Text="Description :"></asp:Label>
            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>

            <asp:Label ID="lblPrix" runat="server" Text="Prix du maillot :"></asp:Label>
            <asp:TextBox ID="txtPrix" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:Label ID="lblCouleur" runat="server" Text="Couleur :"></asp:Label>
            <asp:TextBox ID="txtCouleur" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:Label ID="lblImageUrl" runat="server" Text="URL de l'image :"></asp:Label>
            <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:Label ID="lblEquipe" runat="server" Text="Équipe :"></asp:Label>
            <asp:TextBox ID="txtEquipe" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:Label ID="lblTaille" runat="server" Text="Taille :"></asp:Label>
            <asp:DropDownList ID="ddlTaille" runat="server" CssClass="form-control">
                <asp:ListItem Text="XS" Value="XS" />
                <asp:ListItem Text="S" Value="S" />
                <asp:ListItem Text="M" Value="M" />
                <asp:ListItem Text="L" Value="L" />
                <asp:ListItem Text="XL" Value="XL" />
                <asp:ListItem Text="XXL" Value="XXL" />
            </asp:DropDownList>

            <asp:Label ID="lblDisponibilite" runat="server" Text="Disponibilité :"></asp:Label>
            <asp:CheckBox ID="chkDisponibilite" runat="server" Text="Disponible" Checked="true" />

            <div class="button-group">
                <asp:Button ID="btnEnregistrer" runat="server" Text="Enregistrer" CssClass="btn-action" OnClick="btnEnregistrer_Click" />
                <asp:Button ID="btnAnnuler" runat="server" Text="Annuler" CssClass="btn-action" OnClick="btnAnnuler_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="text-success"></asp:Label>
        </div>
    </form>
</body>
</html> 