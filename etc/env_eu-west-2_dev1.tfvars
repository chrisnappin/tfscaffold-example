# Define variable values to be fed into components in the components directory that will each form a part of the environment...

environment = "dev1"
cidr_block  = "10.0.0.0/16"

# subnet network blocks for each AZ
# each is a /24 block within the overall /16 range above
frontend_network_blocks = [1, 2, 3]
backend_network_blocks  = [4, 5, 6]
