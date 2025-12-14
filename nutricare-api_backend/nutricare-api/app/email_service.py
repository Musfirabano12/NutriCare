import aiosmtplib
from email.message import EmailMessage
from app.config import settings  # Import the settings
import os

class EmailService:
    """
    EmailService handles sending emails for:
    - Account verification (signup)
    - Password reset
    """

    async def send_reset_password_email(self, to_email: str, reset_token: str, user_name: str) -> bool:
        """
        Sends a password reset email with a secure reset link.
        """
        try:
            # Determine frontend URL based on environment
            frontend_url = os.getenv("FRONTEND_URL", settings.FRONTEND_URL)
            reset_link = f"{frontend_url}/reset-password?token={reset_token}"

            subject = "Reset Your Password"
            body = f"""
Hi {user_name},

You requested to reset your password. Click the link below to reset it:

{reset_link}

If you didn't request this, you can ignore this email.

Thanks,
Your App Team
"""
            return await self._send_email(to_email, subject, body)
        except Exception as e:
            print(f"Error sending reset password email to {to_email}: {e}")
            return False

    async def send_welcome_email(self, to_email: str, user_name: str) -> bool:
        """
        Sends a welcome email after signup or account creation.
        """
        try:
            subject = "Welcome to Our App!"
            body = f"""
Hi {user_name},

Welcome to Our App! We're excited to have you on board.

You can now log in and start using your account.

Thanks,
Your App Team
"""
            return await self._send_email(to_email, subject, body)
        except Exception as e:
            print(f"Error sending welcome email to {to_email}: {e}")
            return False

    async def _send_email(self, to_email: str, subject: str, body: str) -> bool:
        """
        Internal method to send email using SMTP.
        """
        try:
            message = EmailMessage()
            message["From"] = settings.SMTP_FROM_EMAIL
            message["To"] = to_email
            message["Subject"] = subject
            message.set_content(body)

            await aiosmtplib.send(
                message,
                hostname=settings.SMTP_HOST,
                port=settings.SMTP_PORT,
                username=settings.SMTP_USER,
                password=settings.SMTP_PASSWORD,
                start_tls=True
            )
            return True
        except Exception as e:
            print(f"Failed to send email to {to_email}: {e}")
            return False

# Singleton instance
email_service = EmailService()
