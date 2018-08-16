var offset = moment.parseZone(Date.now()).utcOffset()/60

Cookies.set("browser.tzoffset", offset, { expires: 30, path: '/' })

