; Based (loosly) on https://github.com/samfisherirl/github.ahk

#Include "%A_LineFile%\..\JXON.ahk"

class Gitter {
  __new(repo, release_name := unset) {
      temp := A_LineFile "\..\.temp\github_temp.json"
      url := "https://api.github.com/repos/" repo "/releases/latest"
      Download(url, temp)
      sleep(50)
      data := FileRead(temp)

      data := jxon_load(&data)
      filedelete(temp)

      asset_index := 1 ; Default to the first download
      if isSet(release_name) {
        For i, val in data["assets"] {
          if InStr(val["name"], release_name, False) {
            asset_index := i
            break
          }
        }
      }
      this.DLUrl := data["assets"][asset_index]["browser_download_url"]
      this.Asset := data["assets"][asset_index]["name"]
      this.Vers := StrSplit(data["html_url"], "/")[8]
      this.body := data["body"]
      this.repo := StrSplit(repo, "/")[2]
  }
  extract(dest, grabFile := unset) {
    tmp_dir := A_LineFile "\..\.temp\"
    SplitPath(this.DLUrl, &zipfilename := "")
    zipPath := tmp_dir . zipfilename
    if not (FileExist(zipPath)) {
      Download(this.DLUrl, zipPath)
      Sleep(250) ; Allow time to dowload
    }

    if ! DirExist(dest)
      DirCreate(dest)

    if IsSet(grabFile) {
      if ! DirExist(tmp_dir . "dl")
        DirCreate(tmp_dir . "dl")
      command := 'powershell -command "Expand-Archive -Path ' zipPath ' -DestinationPath ' tmp_dir . "dl" ' "'
      Run(command,,"Hide")

      Sleep(2000) ; Allow time to extract
      loop files tmp_dir . "dl\*", "FR" {
        if InStr(A_LoopFilePath, grabFile) {
          FileCopy(A_LoopFilePath, dest, True)
        }
      }
      DirDelete(tmp_dir . "dl", True)
    } else {
      command := 'powershell -command "Expand-Archive -Path ' zipPath ' -DestinationPath ' dest ' "'
      Run(command,,"Hide")
      Sleep(2000) ; Allow time to extract
    }
    FileDelete(zipPath)
  }
}
