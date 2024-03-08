# README

#### Setup

```bash
bin/setup
```
```bash
rails server
```
### Solution One
Since the task asks *"to consume data from API. You should store it and provide output as a list of employees"*, I've taken the approach of retrieving this data and store it in a table. Calls to a local database are way faster than calls to external APIs.

This is my preffered approach, but I have questions for which the answers may render it unacceptable: Do we need real-time or is a cached version okay? How often do we need that data and how often is is updated?

To check this solution go to root path and check the processing times from the terminal:
```bash
localhost:3000
```

### Solution Two
If we need fresh data everytime and hence an API call to the ```/employee/list``` endpoint on every request- a thing that can be done is to store the response from the API for the ```access key``` in an instance variable and use its value for the GET request to the ```/employee/list```. It will render the results slightly faster then without it, but slower then if we have database.


To check the Solution Two restart the server and go to:
```bash
localhost:3000/employees_alt
```
