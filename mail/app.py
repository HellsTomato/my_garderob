import smtplib
from email.mime.text import MIMEText
from email.header import Header
import random
import string

# Список для хранения подтвержденных почт
verified_emails = []

def generate_code():
    """Генерирует случайный код для проверки"""
    return ''.join(random.choices(string.ascii_uppercase + string.digits, k=6))

def send_verification_email(recipient_email):
    """Отправляет письмо с кодом проверки на указанный email"""
    login = 'A13524679Garderob8@yandex.ru'
    password = 'wcovnqhohoiordsi'
    verification_code = generate_code()

    msg = MIMEText(f'Ваш код проверки: {verification_code}', 'plain', 'utf-8')
    msg['Subject'] = Header('Код проверки', 'utf-8')
    msg['From'] = login
    msg['To'] = recipient_email

    s = smtplib.SMTP('smtp.yandex.ru', 587, timeout=10)

    try:
        s.starttls()
        s.login(login, password)
        s.sendmail(msg['From'], recipient_email, msg.as_string())
        return verification_code
    except Exception as ex:
        print(ex)
    finally:
        s.quit()

def verify_email(recipient_email):
    """Отправляет код проверки и ждет ответа от пользователя"""
    if recipient_email in verified_emails:
        print(f"Почта {recipient_email} уже подтверждена.")
        return True

    verification_code = send_verification_email(recipient_email)
    user_input = input(f"Введите код проверки, отправленный на {recipient_email}: ")
    if user_input == verification_code:
        print("Почта подтверждена!")
        verified_emails.append(recipient_email)
        return True
    else:
        print("Неверный код проверки.")
        return False

def main():
    while True:
        recipient_email = input("Введите email для проверки (или 'q' для выхода): ")
        if recipient_email.lower() == 'q':
            break

        if verify_email(recipient_email):
            # Отправить подтверждение на сервер
            print("Почта успешно подтверждена и отправлена на сервер.")
        else:
            print("Не удалось подтвердить почту.")

    print("Список подтвержденных почт:", verified_emails)

if __name__ == '__main__':
    main()
