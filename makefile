git: sure
	git add -A
	git commit -m "$(m)"
	git push

package:
	cd lib; cd flutter_package_exporter; make FILE='provider_skeleton'

dependency:
	cd lib; git clone https://github.com/vicmoh/flutter_package_exporter/

clean:
	cd lib; rm -rf flutter_package_exporter

#---------------------------------------------------------------------
# Testing functions
#---------------------------------------------------------------------

sure: package
	cd test; dart --enable-asserts test.dart;
