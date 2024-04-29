# SSR-PortDown-Up
To automate the process of bringing a Juniper SSR interface up and down at set intervals, you can create a systemd service following these steps. This process enables repeated execution of CLI commands to manage specific SSR interfaces. By configuring the timing and interface parameters, you can tailor the service to your requirements, facilitating seamless peer-path failovers.

**1.Create a systemd service file:**

Open a text editor with root privileges and create a file named interface_control.service in the /etc/systemd/system/ directory.

sudo vi /etc/systemd/system/interface_control.service


**2. Add the following content to the interface_control.service file: (Ensure to replace "ge-0-2" with your actual interface name.)**

[Unit]
Description=Interface control service

[Service]
Type=simple
ExecStart=/bin/bash -c 'while true; do var="set provisional-status ge-0-2 down"; date=$(date +\%m-\%d-\%Y-\%H-\%M); su - admin -c "$var" 2; sleep 1800; var2="set provisional-status ge-0-2 up"; date=$(date +\%m-\%d-\%Y-\%H-\%M); su - admin -c "$var2" 2; sleep 1800; done'

[Install]
WantedBy=multi-user.target

**3. Save and close the file.**

**4. Reload systemd:**

sudo systemctl daemon-reload

**5. Enable and start the service:**

sudo systemctl enable  interface_control.service
sudo systemctl start  interface_control.service

**Note:** This will start the service that executes the specified CLI commands at an interval of 30 minutes until stopped manually by the user. Adjust the commands in the ExecStart directive of the service file as needed. (i.e sleep 1800)

