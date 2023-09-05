MEL=$(HOME)/var/mail/cert
TMP=tmp.crt

# posteo.net
CRT=DigiCertHighAssuranceEVRootCA.crt
URL=pop.posteo.de
PRT=995

# smtp.posteo.net
CRT=DigiCertHighAssuranceEVRootCA.crt
URL=smtps.posteo.de
PRT=465

# pop.posteo.net
CRT=DigiCertHighAssuranceEVRootCA.crt
URL=pops.posteo.de
PRT=995

# ovh.com
URL=ssl0.ovh.net
PRT=995
CRT=AddTrustExternalCARoot.crt

# ovh.com
URL=ssl0.ovh.net
PRT=995
CRT=USERTrustRoot.crt

# laposte.net
URL=pop.laposte.net
PRT=995
CRT=Izenpecom.crt
CRT=entrust_g2_ca.cer

# free.fr
URL=pop.free.fr
PRT=995
CRT=DigiCertGlobalRootCA.crt

URL=smtp.free.fr
PRT=465
CRT=DigiCertGlobalRootCA.crt

URL=mail.mailo.com
PRT=465
CRT=mailo.crt

help:
	@echo "make show: show stuff containing the certificate name."
	@echo "make test: test the certificate."
	@echo "make install: install the certificate."

fetch:
	openssl s_client -connect $(URL):$(PRT) --showcerts -prexit 2>/dev/null | openssl x509 > $(CRT)

show: 
	openssl s_client -showcerts -connect $(URL):$(PRT) </dev/null > $(TMP)

test: $(CRT)
	openssl s_client -CAfile $< -connect $(URL):$(PRT)

install: $(CRT)
	cp $(CRT) $(MEL)/$(CRT)
