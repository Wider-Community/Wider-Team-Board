## Overview
this will be a guide to show you how to script your `slack bot` using **python** language.

----
1. install slack bolt
```bash
pip install slack-bolt
```
2. Configure your bot
```python
from slack_bolt import App
from slack_bolt.adapter.socket_mode import SocketModeHandler
app = App(token="SLACK_BOT_TOKEN")

@app.event("app_mention")

def handle_mention(event,say):

    user = event["user"] # Who mentioned the bot

    text = event["text"] # What the user said to the bot
    
    say(f"Hello <@{user}>") # Bot replay to the user

  

# A call back function just to avoid some errors.
@app.event("message")
def handle_message_events(body, logger):
    logger.info(body)
    

slack_handler = SocketModeHandler(

    app=app,

    app_token="APP_LEVEL_TOKEN"

)
```
3. Start Your Bot Bolt
```python
slack_handler.start()
```

**Now when ever the user mentioned the bot it will replay back with hello @user**
