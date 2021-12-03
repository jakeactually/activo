// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import 'bootstrap';

document.addEventListener('DOMContentLoaded', async () => {
    const res = await fetch('/users/6', { headers: { 'Content-Type': 'application/json' } });
    const json = await res.json();

    console.log(json);

    document.querySelector('#save-contact').addEventListener('click', () => {
        const vcf = `BEGIN:VCARD
VERSION:3.0
PRODID:-//Apple Inc.//macOS 11.5.2//EN
N:Doe;John;;;
FN:John Doe
ORG:Sharpened Productions;
EMAIL;type=INTERNET;type=HOME;type=pref:johndoe@email.com
EMAIL;type=INTERNET;type=WORK:johndoe@workemail.com
TEL;type=CELL;type=VOICE;type=pref:123-456-7890
ADR;type=HOME;type=pref:;;12345 First Avenue;Hometown;NY;12345;United States
ADR;type=WORK:;;67890 Second Avenue;Businesstown;NY;67890;United States
NOTE:The man I met at the company networking event. He mentioned that he had some potential leads.
item1.URL;type=pref:https://fileinfo.com/
item1.X-ABLabel:_$!!$_
BDAY:2000-01-01
END:VCARD`.trimLeft();

        const url = `data:text/vcard;base64,${window.btoa(vcf)}`;

        window.open(url);
    });
});
