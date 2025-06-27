import smtplib
from email.message import EmailMessage

def send_alert(email_body):
    msg = EmailMessage()
    msg.set_content(email_body)
    msg['Subject'] = "🚨 Disk Usage Alert"
    msg['From'] = "your_email@gmail.com"
    msg['To'] = "recipient@example.com"

    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp:
        smtp.login("your_email@gmail.com", "your_app_password")
        smtp.send_message(msg)

