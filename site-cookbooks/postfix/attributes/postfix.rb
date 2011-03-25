set_unless.postfix.default_relayhost          = ''
set_unless.postfix.default_relayhost_username = ''
set_unless.postfix.default_relayhost_password = ''
set_unless.postfix.root_mail_to               = ''

# In late February 2011, outgoing messages started piling up in the deferred
# queue, with messages in the logs like "conversation with
# smtp.strato.de[81.169.145.133] timed out while sending message body" and
# "Timeout, closing transmission channel (in reply to end of DATA command)". By
# tweaking these parameters, we're hoping to avoid those issues.
#
# From http://serverfault.com/questions/55949, I'm considering starting with
# bumping smtp_data_xfer_timeout to 600s.
set_unless.postfix.smtp_data_done_timeout = '600s' # postfix default: 600s
set_unless.postfix.smtp_data_init_timeout = '120s' # postfix default: 120s
set_unless.postfix.smtp_data_xfer_timeout = '180s' # postfix default: 180s

set.postfix.virtual_mailbox_base = '/var/mail/virtual'
