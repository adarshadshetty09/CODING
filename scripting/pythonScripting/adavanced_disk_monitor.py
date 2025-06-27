import subprocess
import schedule
import time
import argparse
import logging
import smtplib
from email.message import EmailMessage

# ---------- CONFIG ----------
ALERT_THRESHOLD = 80  # %
LOG_FILE = 'disk_usage.log'
EMAIL_FROM = "your_email@gmail.com"
EMAIL_TO = "recipient@example.com"
EMAIL_PASS = "your_gmail_app_password"
# ----------------------------

# Setup logging
logging.basicConfig(
    filename=LOG_FILE,
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

def send_email_alert(body):
    try:
        msg = EmailMessage()
        msg.set_content(body)
        msg['Subject'] = "🚨 Disk Usage Alert"
        msg['From'] = EMAIL_FROM
        msg['To'] = EMAIL_TO

        with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp:
            smtp.login(EMAIL_FROM, EMAIL_PASS)
            smtp.send_message(msg)

        logging.info("✅ Email alert sent.")
    except Exception as e:
        logging.error(f"❌ Failed to send email: {e}")

def check_disk_usage():
    try:
        result = subprocess.run(["df", "-h"], capture_output=True, text=True)
        output = result.stdout
        logging.info("\n" + output)

        for line in output.splitlines()[1:]:
            parts = line.split()
            if len(parts) < 5:
                continue
            percent_str = parts[4]
            if percent_str.endswith('%'):
                usage = int(percent_str.rstrip('%'))
                if usage > ALERT_THRESHOLD:
                    alert = f"⚠️ High Disk Usage on {parts[0]}: {usage}%\nFull line: {line}"
                    logging.warning(alert)
                    send_email_alert(alert)

    except Exception as e:
        logging.error(f"❌ Error running df -h: {e}")

def main():
    parser = argparse.ArgumentParser(description="Monitor disk usage.")
    parser.add_argument('--interval', type=int, default=1, help="Interval in minutes")
    args = parser.parse_args()

    logging.info("📟 Disk monitor started")
    schedule.every(args.interval).minutes.do(check_disk_usage)

    print(f"📅 Running disk checks every {args.interval} minute(s)... Press Ctrl+C to stop.")

    while True:
        schedule.run_pending()
        time.sleep(1)

if __name__ == "__main__":
    main()

