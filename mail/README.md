## Mail Dotfiles
---

Most of configurations in this dotfiles require user mail address.
I didn't put files which includes mail address here, but instead, I include the template of the configuration with `.tmpl` extension.

If you want to use this package, remove the `.tmpl` in the file name, e.g.  `.mbsyncrc.tmpl` into `.mbsyncrc`.
Then, set the correct value in the configuration, replacing the placeholder value.
The placeholder values will always started by `<` and closed by `>`.
For example, change `<mail address>` into `user@mail.com`.

This dotfiles require these binary installed:
- mutt (MUA)
- mbsync/isync (for offline IMAP)
- msmtp (for SMTP)
- abook (optional for address book)
