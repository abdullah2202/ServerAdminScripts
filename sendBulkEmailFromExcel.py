import smtplib, ssl
import pandas as pd
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from time import sleep
import sys

email_username = 'admin.user@domain.com'
email_password = 'password'

sig = """\
    <p>
    Kind regards,<br/>
    Admin User<br/>
    Organisation<br/>
    <br/>
    </p>
"""

smpt_address = "smtp.gmail.com"
smpt_port = 465

message = MIMEMultipart("alternative")
message["Subject"] = "Your Website Login"
message["From"] = email_username
message["To"] = to_address

excel_data = pd.read_excel("X:/Path/To/Data/My_Excel_Woorkbook.xlsx")
data = pd.DataFrame(excel_data, columns=['first_name','email_address', 'username','password'])
total_rows = len(data)

def print_progress(i):
    j = i / total_rows
    sys.stdout.write('\r')
    sys.stdout.write("[%-20s] %d%%" % ('='*int(20*j), 100*j))
    sys.stdout.flush()
    sleep(0.25)

def send_email(email, name, username, password):
    text = """\
    Hi {name},
    Your login is:
    Username: {username}
    Password: {password}
    """.format(name=name, username=username, password=password)

    html = """\
    <html>
    <body>
        <p>Hi {name}, <br/><br/>
        Your login is:<br/>
        Username: <b>{username}</b><br/>
        Password: <b>{password}</b><br/><br/>
        </p>
        {sig}
    </body>
    </html>
    """.format(name=name, username=username, password=password, sig=sig)

    part1 = MIMEText(text,"plain")
    part2 = MIMEText(html,"html")
    message.attach(part1)
    message.attach(part2)
    to_send = ssl.create_default_context()

    with smtplib.SMTP_SSL(smpt_address, smpt_port, context=to_send) as e:
        e.login(email_username, email_password)
        e.sendmail(email_username,email,message.as_string())

count = 0
for index in data.index:
    email = data['email'][index]
    name = data['first_name'][index]
    username = data['username'][index]
    password = data['password'][index]
    count += 1
    print_progress(count)
    if pd.isna(email) == False:
      send_email(email, name, username, password)
            
        
