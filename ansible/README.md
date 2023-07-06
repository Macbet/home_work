## Ansible Infrastructure as Code (IaC) Repository - README

### Description

This repository serves as an Infrastructure as Code (IaC) solution using Ansible. It allows for the automated provisioning and management of infrastructure resources and configurations. Ansible, an open-source automation tool, is used to define and execute the desired state of infrastructure components.

### Prerequisites

- Ansible: Ensure that Ansible is installed on the system where you plan to execute the playbooks. You can install Ansible using your system's package manager or other appropriate methods.
- Target Systems: Make sure you have access to the target systems where you want to apply the infrastructure configurations. Ensure proper connectivity and authentication, such as SSH key-based authentication or username/password credentials.

### Repository Structure

The repository contains the following structure:

```
ansible
    ├── ansible.cfg
    ├── collections
    ├── inventory.yml
    ├── playbook.yml
    ├── req
    │   └── collections.yml
    ├── roles
    │   ├── nginx
    │   │   ├── files
    │   │   │   └── index.html
    │   │   ├── handlers
    │   │   │   └── main.yaml
    │   │   ├── tasks
    │   │   │   └── main.yaml
    │   │   └── templates
    │   │       └── nginx.conf.j2
    │   └── system
    │       ├── files
    │       │   └── nginx
    │       ├── handlers
    │       │   └── main.yml
    │       ├── tasks
    │       │   └── main.yaml
    │       └── templates
    │           ├── denylist.j2
    │           └── td-agent.j2
    └── vars
        └── main.yml
```

- `inventory.yml`: Inventory files specifying the target systems to be managed.
- `playbooks`: Holds the Ansible playbooks responsible for infrastructure provisioning, configuration, and other tasks.
- `roles`: Consists of reusable Ansible roles that encapsulate specific configurations and actions.
- `files`: Contains additional files, such as scripts and templates, required by the playbooks or roles.
- `vars`: Stores variable files used for customizing configurations and behavior.
- `README.md`: The current file, providing an overview of the repository and guidance.
### Before start
Install the required Ansible collections specified in the collections.yml file located in the req directory. Run the following command:

   ```bash
   ansible-galaxy install -r req/collections.yml
   ```

   This command installs the necessary collections to fulfill the requirements of the playbooks and roles.
### Getting Started

To start using this Ansible IaC repository, follow the steps below:

1. Clone or download the repository to your local machine.

2. Customize the inventory files (`inventory.yml`)  Define the target systems' connection details, such as IP addresses or hostnames, SSH credentials, and specific groups if necessary.

3. Customize the variable files (`*.yml`) located in the `vars` directory. Modify the variables to match your desired infrastructure configuration.

4. Navigate to the `playbooks` directory and select the appropriate playbook for your intended task. Modify the playbook if needed, specifying the desired roles and configurations.

5. Execute the playbook using the following command:

   ```bash
   ansible-playbook  playbooks/nginx_logs.yml
   ```

   Replace `playbooks/nginx_logs.yml` with the path to the desired playbook. Adjust the inventory file path if necessary.

### Contributing

Contributions to this repository are welcome. If you identify issues or have suggestions for improvements, please submit them via the issue tracker. Pull requests are also encouraged.

When contributing, ensure adherence to best practices, follow the repository's structure, and provide clear documentation for any changes or additions.

### Additional Resources

For more information about Ansible and how to use it effectively, refer to the official Ansible documentation:

- Ansible Documentation: [https://docs.ansible.com/](https://docs.ansible.com/)
- Ansible Galaxy: [https://galaxy.ansible.com/](https://galaxy.ansible.com/)

### License

This project is licensed under the [MIT License](LICENSE). Feel free to use, modify, and distribute it as per the terms of the license.


# Extra credit #2
I choose Logrotate!

## Why Logrotate?

Logrotate is a powerful log rotation tool that helps manage log files on Unix-like systems. It offers several advantages, making it a cool choice for log management. Here's why Logrotate is a beneficial solution:

1. **Efficient Log Space Management**: Logrotate allows you to control the size of log files, preventing them from consuming excessive disk space. By rotating logs based on size, time, or other criteria, Logrotate ensures logs remain manageable and disk space is efficiently utilized.

2. **Prevention of Log File Overload**: Logrotate prevents log files from growing indefinitely. It rotates log files based on predetermined thresholds, ensuring that logs are segmented into smaller, more manageable files. This prevents log files from becoming too large and impacting system performance.

3. **Retention of Historical Log Data**: Logrotate enables the retention of a defined number of historical log files. By specifying the number of rotated logs to keep, you can preserve a sufficient history of log data for analysis and troubleshooting purposes. This ensures that you have access to the required log data without cluttering your file system with excessive logs.

4. **Compression of Rotated Logs**: Logrotate supports compression of rotated log files, reducing the storage space required for log retention. Compressed logs occupy less disk space, allowing for long-term log storage while minimizing storage costs.

5. **Flexible Configuration Options**: Logrotate offers a wide range of configuration options, allowing you to customize log rotation behavior according to your specific requirements. You can define rotation intervals, log file locations, compression settings, retention policies, and more. This flexibility ensures that Logrotate can be adapted to various log management scenarios.

6. **Integration with System Processes**: Logrotate can integrate with system processes to facilitate seamless log rotation. For example, it can notify services or applications to reopen log files after rotation, ensuring uninterrupted log recording without the need for system restarts.

