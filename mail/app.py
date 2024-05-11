import smtplib
from email.mime.text import MIMEText
from email.header import Header
import random
import string
from flask import Flask, request, render_template

app = Flask(__name__)
VERIFICATION_CODES = {}

def generate_verification_code(email):
    """Генерирует случайный код для проверки"""
    chars = string.ascii_letters + string.digits
    code = ''.join(random.choices(chars, k=16))
    VERIFICATION_CODES[code] = email
    return code

def send_verification_email(recipient_email):
    """Отправляет письмо со ссылкой для проверки на указанный email"""
    login = 'A13524679Garderob8@yandex.ru'
    password = 'wcovnqhohoiordsi'
    verification_code = generate_verification_code(recipient_email)
    verification_link = f"http://localhost:5000/verify?code={verification_code}"

    msg = MIMEText(f'Для подтверждения почты нажмите на кнопку: <a href="{verification_link}">Подтвердить почту</a>', 'html', 'utf-8')
    msg['Subject'] = Header('Подтверждение почты', 'utf-8')
    msg['From'] = login
    msg['To'] = recipient_email

    s = smtplib.SMTP('smtp.yandex.ru', 587, timeout=10)

    try:
        s.starttls()
        s.login(login, password)
        s.sendmail(msg['From'], recipient_email, msg.as_string())
        return True
    except Exception as ex:
        print(ex)
        return False
    finally:
        s.quit()

@app.route('/verify')
def verify_email():
    code = request.args.get('code')
    if code in VERIFICATION_CODES:
        email = VERIFICATION_CODES.pop(code)
        print(f"Email {email} confirmed")
        # Отправить подтверждение на сервер
        return render_template('confirmation.html', confirmed=True)
    else:
        return render_template('confirmation.html', confirmed=False)

if __name__ == '__main__':
    recipient_email = input("Enter email for verification: ")
    if send_verification_email(recipient_email):
        print(f"Verification link sent to {recipient_email}.")
        app.run(host='localhost', port=5000, debug=True)
        print("Email confirmed and sent to the server.")
    else:
        print("Error confirming email.")
