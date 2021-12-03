module UsersHelper
    def self.user_to_vcf(user)
        """BEGIN:VCARD
VERSION:3.0
PRODID:-//Apple Inc.//macOS 11.5.2//EN
N:#{user.last_name};#{user.first_name};;;
FN:#{user.first_name} #{user.last_name}
ORG:#{user.company};
EMAIL;type=INTERNET;type=HOME;type=pref:#{user.email}
EMAIL;type=INTERNET;type=WORK:#{user.email}
TEL;type=CELL;type=VOICE;type=pref:#{user.phone}
ADR;type=HOME;type=pref:;;#{user.address}
ADR;type=WORK:;;#{user.address}
NOTE:
item1.URL;type=pref:#{user.website}
item1.X-ABLabel:_$!!$_
BDAY:2000-01-01
END:VCARD"""
    end
end
