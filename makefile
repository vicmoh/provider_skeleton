EXPORT_FILE=provider_skeleton

# ---------------------------------------------------------------------------- #
#                          Below are all the commands                          #
# ---------------------------------------------------------------------------- #

# Export and test the program.
all: export sure clean

# Git add, commit, and push.
git: all
	git add -A
	git commit -m '$(m)'
	git push

# Create an export file.
export:
	cd lib; cd flutter_package_exporter; make FILE='$(EXPORT_FILE)'

# Run test harsness.
sure: 
	cd test; dart --enable-asserts test.dart;

# Clean the python caches.
clean:
	cd lib/flutter_package_exporter; make clean;

# Install dependencies.
install: clean 
	cd lib; git clone https://github.com/vicmoh/flutter_package_exporter || cd flutter_package_exporter; git pull;

new: all
	git branch $(version); git checkout $(version); git push --set-upstream origin $(version); git checkout master;
