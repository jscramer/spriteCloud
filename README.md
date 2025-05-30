# spriteCloud
Automation assignment for spriteCloud


# Data test id
In the generic.resource file I placed some keywords that are adding the right data-testid. By default Playwright is using the data-testid attribute, but the site of saucedemo is using data0test instead. Unfortunately there is no way in Robot Framework to set the attribute's name on a global level as what can be done in Playwright within the config.

# Assumptions
- The server of ingres accepts operations on their data, but it does not actually save the changes (deletions/updates/creations etc.). This makes it impossible to verify the update by comparing the data before and after the update.