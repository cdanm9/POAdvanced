sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/sap/pocreation/test/integration/pages/POHeadersList",
	"com/sap/pocreation/test/integration/pages/POHeadersObjectPage",
	"com/sap/pocreation/test/integration/pages/POItemsObjectPage"
], function (JourneyRunner, POHeadersList, POHeadersObjectPage, POItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/sap/pocreation') + '/test/flp.html#app-preview',
        pages: {
			onThePOHeadersList: POHeadersList,
			onThePOHeadersObjectPage: POHeadersObjectPage,
			onThePOItemsObjectPage: POItemsObjectPage
        },
        async: true
    });

    return runner;
});

