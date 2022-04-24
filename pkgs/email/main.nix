pkgs:

{
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.notmuch = {
    enable = true;
    hooks = {
      preNew = "mbsync --all";
    };
  };
  programs.neomutt = {
    enable = true;
    editor = "nvim";
    sidebar = {
      enable = true;
      shortPath = true;
    };
    sort = "date";
    vimKeys = true;
    extraConfig = ''
      set spoolfile = "+Inbox"
      set record = "+Sent"
      set trash = "+Trash"

      mailboxes =Inbox =Sent =Trash
# Default index colors:
      color index yellow default '.*'
      color index_author red default '.*'
      color index_number blue default
      color index_subject cyan default '.*'

# For new mail:
      color index brightyellow black "~N"
      color index_author brightred black "~N"
      color index_subject brightcyan black "~N"

# Header colors:
      color header blue default ".*"
      color header brightmagenta default "^(From)"
      color header brightcyan default "^(Subject)"
      color header brightwhite default "^(CC|BCC)"

      mono bold bold
      mono underline underline
      mono indicator reverse
      mono error bold
      color normal default default
      color indicator brightblack white
      color sidebar_highlight red default
      color sidebar_divider brightblack black
      color sidebar_flagged red black
      color sidebar_new green black
      color normal brightyellow default
      color error red default
      color tilde black default
      color message cyan default
      color markers red white
      color attachment white default
      color search brightmagenta default
      color status brightyellow black
      color hdrdefault brightgreen default
      color quoted green default
      color quoted1 blue default
      color quoted2 cyan default
      color quoted3 yellow default
      color quoted4 red default
      color quoted5 brightred default
      color signature brightgreen default
      color bold black default
      color underline black default
      color normal default default

      color body brightred default "[\-\.+_a-zA-Z0-9]+@[\-\.a-zA-Z0-9]+" # Email addresses
      color body brightblue default "(https?|ftp)://[\-\.,/%~_:?&=\#a-zA-Z0-9]+" # URL
      color body green default "\`[^\`]*\`" # Green text between ` and `
      color body brightblue default "^# \.*" # Headings as bold blue
      color body brightcyan default "^## \.*" # Subheadings as bold cyan
      color body brightgreen default "^### \.*" # Subsubheadings as bold green
      color body yellow default "^(\t| )*(-|\\*) \.*" # List items as yellow
      color body brightcyan default "[;:][-o][)/(|]" # emoticons
      color body brightcyan default "[;:][)(|]" # emoticons
      color body brightcyan default "[ ][*][^*]*[*][ ]?" # more emoticon?
      color body brightcyan default "[ ]?[*][^*]*[*][ ]" # more emoticon?
      color body red default "(BAD signature)"
      color body cyan default "(Good signature)"
      color body brightblack default "^gpg: Good signature .*"
      color body brightyellow default "^gpg: "
      color body brightyellow red "^gpg: BAD signature from.*"
      mono body bold "^gpg: Good signature"
      mono body bold "^gpg: BAD signature from.*"
      color body red default "([a-z][a-z0-9+-]*://(((([a-z0-9_.!~*'();:&=+$,-]|%[0-9a-f][0-9a-f])*@)?((([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?|[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)(:[0-9]+)?)|([a-z0-9_.!~*'()$,;:@&=+-]|%[0-9a-f][0-9a-f])+)(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?(#([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?|(www|ftp)\\.(([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?(:[0-9]+)?(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?(#([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?)[^].,:;!)? \t\r\n<>\"]"
      '';
  };

  accounts.email = {
    accounts.posteo = {

      # User info
      address = "mateusdccavalcanti@gmail.com";
      realName = "Mateus Cavalcanti";
      userName = "mateusdccavalcanti@gmail.com";
      passwordCommand = "mail-password";
      primary = true;

      # Imap
      signature = {
        text = ''
        Student, developer, linux enthusiast
        GitHub: github.com/mateus-cavalcanti
        '';
        showSignature = "append";
      };
      imap = {
        host = "imap.gmail.com";
        port = 993;
      };

      # Apps
      mbsync = {
        enable = true;
        create = "maildir";
      };

      notmuch.enable = true;

      neomutt.enable = true;

      # Smtp
      msmtp.enable = true;
      smtp = {
        host = "smtp.gmail.com";
        port = 465;
      };
    };
  };
}
