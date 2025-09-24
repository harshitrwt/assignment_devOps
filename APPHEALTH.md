# APP Health Script

This Bash script performs **HTTP status check** on a given URL and determines if the web application is **UP** or **DOWN**, based on the response code.

It logs the results to the **terminal**

---

## How It Works

- Accepts a URL as an argument.
- Uses `curl` to make a request to the URL.
- If the HTTP status code is between `200` and `399`, the app is considered **UP**.
- If `curl` fails or the status code is `400+`, the app is considered **DOWN**.

---

## Usage

Make the script executable:

```bash
chmod +x apphealth.sh
```

Example
- In the given below image, I have tested the script 4 times for different URL's one is google, second is yahoo, third is my one of my app which is currently deployed so, I tried reaching out to it as well and finally the wisecow app from problem statement 1 which is for the moment was down so it responded accordingly.
  


<img width="1388" height="882" alt="Screenshot 2025-09-24 110620" src="https://github.com/user-attachments/assets/9a497f8d-f84a-4e04-bc78-6a15822a4bbd" />
