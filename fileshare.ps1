$connectTestResult = Test-NetConnection -ComputerName gitlabstoragetest.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"gitlabstoragetest.file.core.windows.net`" /user:`"Azure\gitlabstoragetest`" /pass:`"h0rN8ScqtXVERxRDdr9REwBYcvKc5umoV8E5jIhzE5ViLtXIN5YlMnAsk5/eURMeW/SQ1jwzijbMBDIl/M67ww==`""
    # Mount the drive
    New-PSDrive -Name Z -PSProvider FileSystem -Root "\\gitlabstoragetest.file.core.windows.net\gitlabshare" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}
