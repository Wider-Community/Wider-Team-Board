## Overview
this will be a guide to configure your own `slack bot` using python and add it to your workspace.

-------
## 1. Create a slack app
- Go to [slack.api applications](https://api.slack.com/apps)
- Click create New App
 ![create new app](assets/slack1.png)
 - Choose **from scratch**.
 - Enter your **App Name** and pick a **Workspace**.

## 2. Configure Scopes 
**Bot token scopes**: this scope give the bot permissions on your **Workspace** like 
- reading 
- writing
- managing
![](slack2.png)
*For now I will use only app_mentions:read*
