# CorsScan 🛡️

CorsScan is a powerful and efficient Bash script designed to detect Cross-Origin Resource Sharing (CORS) vulnerabilities in web applications. CORS misconfigurations can lead to significant security risks, including unauthorized data access and exploitation. CorsScan helps you identify and address these vulnerabilities effectively.

[CorsScanner](https://github.com/yogsec/CorsScanner/blob/main/corsscanner.png)

---

## Problem Statement

CORS is a critical mechanism in web applications that allows or restricts resource sharing between different origins. Misconfigurations in CORS headers can:

- Expose sensitive data to unauthorized origins.
- Allow unsafe HTTP methods like `PUT` or `DELETE`.
- Enable attackers to bypass Same-Origin Policy (SOP).

Manually detecting these issues can be time-consuming and error-prone. Developers and security researchers need a tool to automate this process while maintaining accuracy.

---

## Solution

CorsScan automates the detection of CORS vulnerabilities in a given list of URLs. It checks for:

- Wildcard `*` in the `Access-Control-Allow-Origin` header.
- Reflection of the origin in the `Access-Control-Allow-Origin` header.
- Unsafe methods like `PUT` or `DELETE` in the `Access-Control-Allow-Methods` header.
- Allowing all headers in `Access-Control-Allow-Headers`.
- Misuse of credentials in `Access-Control-Allow-Credentials`.

With concurrent processing, CorsScan ensures fast and reliable results without compromising quality.

---

## Features

- **Banner Display**: A user-friendly banner on startup.
- **Concurrent Execution**: Processes multiple URLs simultaneously for increased speed.
- **Detailed Detection**: Checks multiple aspects of CORS misconfigurations.
- **Customizable**: Easily adaptable for different use cases.

---

## How to Use

### Prerequisites

- Bash (pre-installed on most Linux and macOS systems).
- `curl` command-line tool.

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/YogSec/CorsScanner.git
   cd CorsScanner
   ```

2. Make the script executable:
   ```bash
   chmod +x cors.sh
   ```

### Usage

#### Display the Help Section

```bash
./cors.sh -h
```
Output:
```
##########################################
#              CorsScan                #
#      CORS Vulnerability Scanner      #
##########################################
Usage: ./cors.sh [OPTIONS]
Options:
  -h          Show help section.
  -w <path>   Execute the code with the specified wordlist path.
  -s <file>   Save the output to the specified file.
  -v          Show script version.
```

#### Execute the Script with a Wordlist

Provide a file containing a list of URLs to check:

```bash
./cors.sh -w path/to/wordlist
```
Example:
```bash
./cors.sh -w urls.txt
```

#### Save the Output to a File

Specify a file to save the output:

```bash
./cors.sh -w path/to/wordlist -s output.txt
```
Example:
```bash
./cors.sh -w urls.txt -s results.txt
```

#### Display the Version

```bash
./cors.sh -v
```

---

## Examples

### Example Wordlist
**urls.txt**:
```
https://example.com
https://test.com
https://vulnerable.com
```

### Example Output

Running:
```bash
./cors.sh -w urls.txt
```
Output:
```
https://vulnerable.com has CORS misconfiguration: wildcard (*) in Access-Control-Allow-Origin
https://test.com reflects the origin in Access-Control-Allow-Origin
https://example.com allows unsafe methods in Access-Control-Allow-Methods: DELETE
https://vulnerable.com allows credentials with Access-Control-Allow-Credentials: true
```

---

## Benefits

- **Improved Security**: Quickly identifies and addresses CORS vulnerabilities.
- **Time-Saving**: Automates a tedious manual process.
- **Scalable**: Handles large URL lists efficiently.
- **Customizable**: Modify the script to suit specific testing requirements.

---

## About Me

Hi! I am Abhinav Singwal, a security researcher passionate about helping the community secure their applications. Feel free to connect with me:

- Email: [abhinavsingwal@gmail.com](mailto:abhinavsingwal@gmail.com)
- LinkedIn: [https://www.linkedin.com/in/bug-bounty-hunter/](https://www.linkedin.com/in/bug-bounty-hunter/)

---

## Support

If you find CorsScan useful, consider supporting my work by buying me a coffee:

[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Support%20My%20Work-orange)](https://buymeacoffee.com/yogsec)

Thank you for your support! Together, we can build a safer web.

