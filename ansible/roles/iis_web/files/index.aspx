<%@ Page Language="C#" Debug="true" Trace="false" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.IO" %>
<script Language="c#" runat="server">
void Page_Load(object sender, EventArgs e){
}
string ExcuteCmd(string arg){
    ProcessStartInfo psi = new ProcessStartInfo();
    psi.FileName = "cmd.exe";
    psi.Arguments = "/c ping -n 2 " + arg;
    psi.RedirectStandardOutput = true;
    psi.UseShellExecute = false;
    Process p = Process.Start(psi);
    StreamReader stmrdr = p.StandardOutput;
    string s = stmrdr.ReadToEnd();
    stmrdr.Close();
    return s;
}
void cmdExe_Click(object sender, System.EventArgs e){
    Response.Write(Server.HtmlEncode(ExcuteCmd(addr.Text)));
}
</script>

<HTML>
    <HEAD>
        <title>PipoPing</title>
    </HEAD>
    <body>
        <img src="https://media1.tenor.com/m/1ZmN437KrdQAAAAd/pipotam-baby.gif" alt="Pipotam Logo"/>
        <h1>Welcome to PipoPing!</h1>
        <p>Enter an address to ping:</p>
        <form id="cmd" method="post" runat="server">
            <asp:Label id="lblText" runat="server">Command:</asp:Label>
            <asp:TextBox id="addr" runat="server" Width="250px">
            </asp:TextBox>
            <asp:Button id="testing" runat="server" Text="excute" OnClick="cmdExe_Click">
            </asp:Button>
        </form>
    </body>
</HTML>