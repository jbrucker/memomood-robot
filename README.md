## Robot Test for Memomood

Prerequisites: You need

- Python 3.8 or newer
- Selenium

### Installation

1. Install Robot Framework and Selenium Library
   ```
   pip install robotframework robotframework-seleniumlibrary
   ```
2. Copy this robot script by cloning repostory:
   ```
   git clone https://github.com/jbrucker/memomood-robot.git
   ```
   **or** just download the `.robot` file:
   ```
   curl -o memomood.robot https://raw.githubusercontent.com/jbrucker/memomood-robot/master/memomood.robot
   ```

### Run

```
  robot memomood.robot
```

### Known Problems

- Selecting checkboxes.  The memomood checkboxes for moods and friends don't have unique names.
