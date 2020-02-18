au! BufRead,BufNewFile * if getline(1) == "#!/usr/bin/env dash" | setfiletype sh | endif
