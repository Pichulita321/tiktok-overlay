using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;

public class CSharpTrigger
{
    public bool Execute()
    {
        string user = "Donador_TikTok";
        int amount = 30;
        string userAvatar = "";
        long timestamp = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds();

        // 🎯 ÚNICAMENTE LOS 4 TROLEOS SELECCIONADOS POR EL USUARIO:
        // 1. Troleo_Raton_Borracho (10s)
        // 2. Troleo_Parpadeo (10s)
        // 3. Troleo_Invertido (10s)
        // 4. Troleo_Zoom (8s)
        string[] troleosExclusivos = new string[] {
            "Troleo_Raton_Borracho",
            "Troleo_Parpadeo",
            "Troleo_Invertido",
            "Troleo_Zoom"
        };
        Random rand = new Random();
        string trollSelected = troleosExclusivos[rand.Next(troleosExclusivos.Length)];

        // 📡 1. TRANSMITIR SEÑAL UDP JSON AL PUERTO 8085 EN TODA LA RED LOCAL
        try
        {
            string jsonPayload = string.Format("{{\"request\":\"DoAction\",\"action\":{{\"name\":\"{0}\"}}}}", trollSelected);
            byte[] bytesPayload = Encoding.UTF8.GetBytes(jsonPayload);

            using (UdpClient udpClient = new UdpClient())
            {
                udpClient.EnableBroadcast = true;

                // Broadcast a red local 255.255.255.255:8085
                IPEndPoint epBroadcast = new IPEndPoint(IPAddress.Broadcast, 8085);
                udpClient.Send(bytesPayload, bytesPayload.Length, epBroadcast);

                // Loopback local 127.0.0.1:8085
                IPEndPoint epLoopback = new IPEndPoint(IPAddress.Loopback, 8085);
                udpClient.Send(bytesPayload, bytesPayload.Length, epLoopback);

                // Subredes comunes
                string[] subnets = new string[] { "192.168.1.255", "192.168.0.255", "192.168.100.255", "10.0.0.255" };
                foreach (string sub in subnets)
                {
                    try
                    {
                        IPEndPoint epSub = new IPEndPoint(IPAddress.Parse(sub), 8085);
                        udpClient.Send(bytesPayload, bytesPayload.Length, epSub);
                    }
                    catch { }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error al enviar UDP: " + ex.Message);
        }

        // 📝 2. ESCRIBIR Y ACUMULAR EN orden_tiktok.js PARA LA PANTALLA OBS HTML
        string filePath = @"C:\Users\Gian\Desktop\TiktokHTML\TiktokHTML\orden_tiktok.js";
        string commandLine = string.Format(
            "lanzarAlertaTikTok(\"{0}\", {1}, \"{2}\", \"{3}\", \"{4}\");\n",
            user.Replace("\"", "\\\""),
            amount,
            userAvatar,
            timestamp,
            trollSelected.Replace("\"", "\\\"")
        );

        try
        {
            File.AppendAllText(filePath, commandLine);
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error al escribir orden_tiktok.js: " + ex.Message);
        }

        return true;
    }
}
