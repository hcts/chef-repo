set_unless.postfix.default_relayhost          = ''
set_unless.postfix.default_relayhost_username = ''
set_unless.postfix.default_relayhost_password = ''
set_unless.postfix.root_mail_to               = ''

set_unless.postfix.smtp_data_done_timeout = '600s' # postfix default: 600s
set_unless.postfix.smtp_data_init_timeout = '120s' # postfix default: 120s
set_unless.postfix.smtp_data_xfer_timeout = '180s' # postfix default: 180s

set.postfix.virtual_mailbox_base = '/var/mail/virtual'
