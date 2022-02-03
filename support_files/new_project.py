import os
import re

home_dir = "X:\projects"

dirs = [
	"01_assets",
	"02_2D",
	"03_3D",
	"04_render",
	"05_comp",
	"06_out"
	]

proj_name = input("Project Name: ")
proj_name = proj_name.strip()
proj_name = re.sub(r"\W", "_", proj_name)

# import datetime

# date = datetime.datetime.now()
# date = date.strftime("%Y_%m_%d")

# proj_name = date + "_" + proj_name

proj_dir = os.path.join(home_dir, proj_name)
if not os.path.exists(proj_dir):
	os.mkdir(proj_dir)

for dir in dirs:
	new_dir = os.path.join(proj_dir, dir)
	if not os.path.exists(new_dir):
		os.mkdir(new_dir)

os.startfile(proj_dir)