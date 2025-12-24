<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateNtier.aspx.cs" Inherits="WebSite.Raven.CreateNtier" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        table { width: 400px; padding: 15px; border: 1px solid; display: flex; justify-content: center; align-content: center; }
        td { line-height: 2rem; }
        tr td:first-child { width: 200px; padding-right: 25px; text-align: right; }
        input[type="submit"] { width: 100%;height: 35px; }
    </style>
</head>
<body>
    <form name="form1" runat="server" method="post">
        <table>
            <tr>
                <td>Folder</td>
                <td><input type="text" name="fileName" /></td>
            </tr>
            <tr>
                <td>Class</td>
                <td><input type="text" name="className" /></td>
            </tr>
            <tr>
                <td>Tablename</td>
                <td><input type="text" name="table_name_without_schema" /></td>
            </tr>
            <tr>
                <td>Table with Schema</td>
                <td><input type="text" name="table_name_with_schema" /></td>
            </tr>
            <tr>
                <td>Has Twin</td>
                <td><input type="checkbox" name="has_twin" /></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td><asp:Button ID="btnSave" runat="server" Text="Create" OnClick="btnSave_Click" /></td>
            </tr>
        </table>
    </form>
</body>
</html>