from twilio.rest import Client

account_sid = "AC1e23a4a5289b9eef5e23eb51f03b8792"
auth_token = ""
client = Client(account_sid, auth_token)

message = client.messages.create(
    body="Hello from ECOTRACK test",
    from_='',
    to='+919841602444'
)

print(message.sid)
