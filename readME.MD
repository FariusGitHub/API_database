Please refer to https://medium.com/p/f1b5eaba9338/edit for the details.

Herewith the step to setup this project:

1. MySQL database
    For this purpose I took https://www.rotowire.com/hockey/stats.php?season=2022 data for 2022 NHL stat.
    It could be easier to setup MySQL locally than in EC2. In both case we should be able to upload around a 951 rows of data.
    
      Run
      Terraform init
      Terraform plan
      Terraform apply -auto-approve 
      
      to build EC2 with MySQL installed.
      You may want to add more data by running
      
      bash add_data.sh
      
2. Flask API
    Basically Flask API will use above database and facilitate the 3 endpoints as required.
    
    Run the API with
    
    Python3 flask_ec2.py
    
    See in AWS Console for the public IP given or use below cli command if you only have one EC2 running
    
    aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].[InstanceId,PublicIpAddress]" --output text
    
    If your public IP address is 100.27.24.139
    then the three endpoints should be accessible through

    http://100.27.24.139:5000/players
    
    http://100.27.24.139:5000/toronto
    
    http://100.27.24.139:5000/points

3. Bootstrap Frontend
    The bootstrap.html here is just an example to call the running Flask API. It was originally build for local.
    For EC2, please replace that localhost into given Public IP when EC2 was created such as 100.27.24.139

You may need to setup apache2 or nginx environment to enable html page to run as installed in /var/www/html.
