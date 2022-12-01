*** Settings ***
Documentation      E2E Test of MemoMood
Library            SeleniumLibrary
Library            String
Library            Dialogs

# to test both local dev & production versions, put site specific
# values like URL in a separate file using same syntax as here.
#Resource           memomood-production.txt

*** Variables ***
${BROWSER}         Chrome
${SITE_URL}        https://memomood.herokuapp.com/
${SITE_TITLE}      MemoMood
${username}        robot
${password}        IAmaMachine
# must be in the past
${datetime}        113020221300
# "favorite" moods to show on Record page, separate by 2 spaces
@{FAV_MOODS}       Aware  Confident  Energetic  Content  Serene  Thankful  Critical  Depressed  Bored   Apathetic  Angry  Irritated  Anxious  Discouraged

*** Test Cases ***

Visit Homepage
    Open Browser         ${SITE_URL}   ${BROWSER}
    Location Should Be   ${SITE_URL}
    Title Should Be      ${SITE_TITLE}
    # Optionally slow down Selenium by specify speed
    #Set Selenium Speed   1 seconds

Login
    Page Should Contain Link  Profile
    Click Link                Profile
    Page Should Contain       Profile
    Page Should Contain Link  Sign In
    Click Link                Sign In
    Page Should Contain       Login
    Input Text                name:login     ${username}
    Input Password            name:password  ${password}
    Click Button              Sign In

Profile Has Social Account
    # Does app remember my linked social accounts?
    Click Link                Profile
    Click Button              Settings
    Log To Console   I already connected a Google account. Where is it?
    Page Should Not Contain   You currently have no social network accounts
    Sleep                     1 seconds

Specify Favorite Moods
    # You have to specify them one time
    Click Link                Home
    Click Link                Record
    Add Favorite Moods @{FAV_MOODS}
    # Verify the first & last moods are shown
    Page Should Contain Checkbox  ${FAV_MOODS][0]
    Page Should Contain Checkbox  ${FAV_MOODS][-1]
    
Add Event Record
    Click Link                Home
    Page Should Contain Link  Record
    Click Link                Record
    Input Text                name:record-time  ${datetime}
    Log To Console            Add place and friends. The app always forgets.
    # Confusing design! Looks like a button but it is a hyperlink (a).
    Click Link                Add place
    Input Text                name:new-place    Kasetsart University
    Click Button              Add
    Pause Execution           Grammar Error\n"Who is you with?"
    Click Link                Add friends
    Input Text                name:new-friend   Arduino
    Click Button              Add
    Pause Execution           Page forgot the date/time I entered!\nPress OK to enter it again.\nThis sucks.
    Input Text                name:record-time  ${datetime}
    Select Checkbox           Arduino       # value:arduino
    Select Checkbox           Raspberry Pi  # value:raspberry{BLANK}pi
    Select Checkbox           Selenium      # value:selenium
    Log To Console            Choose the weather
    Select Radio Button       weather-input     cloudy
    Input Text                name:text-input  ISP Project Presentations. But I already input this. Did you forget?
    Select Moods              Aware  Critical  Irritated  Discouraged
    Sleep                     1 seconds
    Click Button              Save

Shutdown
    Pause Execution           Done Tests.\nClick OK to Exit.

*** Keywords ***

Add Favorite Moods ${favmoods}
    # Specify moods to show on Record page
    # You have to add the moods one time so they are available
    Click Link                Add Your Favorite Mood
    FOR                       ${mood}  IN  @{favmoods}
        ${id}=  Set Variable  ${mood}-option
        Select Checkbox       ${id}
    END
    Click Button              Add

Select Moods ${moods}
    FOR                       ${mood}  IN  @{moods}
        Select Checkbox       ${mood}
    END
