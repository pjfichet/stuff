ETCDIR=
	iwd/main.conf \
	nftables.conf \
	smartd.conf \
	systemd/network/20-wired.network \
	systemd/network/25-wireless.network \
	systemd/network/30-bluetooth.network \
	systemd/system/getty@.service.d/noclear.conf \
	updatedb.conf



install: $(ETCDIR:%=/etc/%)

uninstall:
	rm -f $(ETCDIR:%=/etc/%)

/etc/%: %
	@echo "Installing $@"
	@test -d $$(dirname $@) || mkdir -p $$(dirname $@)
	cp $< $@

/usr/share/smartmontools/smartd_warning.d/%: %
	@echo "Installing $@"
	@test -d $$(dirname $@) || mkdir -p $$(dirname $@)
	cp $< $@

.PHONY: install uninstall

