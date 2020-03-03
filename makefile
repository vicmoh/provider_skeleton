# Quick git commit push.
git:
	git add -A
	git commit -m "$(m)"
	git push

# Export package
package:
	cd lib; cd flutter_package_exporter; make FILE='provider_skeleton'

#---------------------------------------------------------------------
# Testing functions
#---------------------------------------------------------------------

test: extension_test

extension_test:
	cd test; dart extension_test.dart;

