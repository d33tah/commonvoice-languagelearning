targets=$(foreach l,$(shell cd cv-corpus-6.1-2020-12-11/; ls),static/$(l) cache/$(l))

all: $(targets) static/indexes


#v-corpus-6.1-2020-12-11/.d:
#	mkdir -p cv-corpus-6.1-2020-12-11 
#	touch $@

#cv-corpus-6.1-2020-12-11/fi: cv-corpus-6.1-2020-12-11/.d
#	wget --no-check-certificate http://cl.indiana.edu/~ftyers/cv/cv-corpus-6.1-2020-12-11.tar.gz -O- | tar zxf -

static/indexes: $(targets)
	mkdir -p static
	./lib/collect.py ./cache/ ./static/

cache/%: ./cv-corpus-6.1-2020-12-11/%
	mkdir -p cache
	./lib/index.py ./cv-corpus-6.1-2020-12-11/$*

static/%: ./cache/%
	mkdir -p static
	./lib/deploy.py cv-corpus-6.1-2020-12-11/$* $< static/

clean:
	rm -rf cache/* static/*