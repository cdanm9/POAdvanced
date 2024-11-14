sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/sap/pocreation/test/integration/FirstJourney',
		'com/sap/pocreation/test/integration/pages/POHeadersList',
		'com/sap/pocreation/test/integration/pages/POHeadersObjectPage',
		'com/sap/pocreation/test/integration/pages/POItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POHeadersList, POHeadersObjectPage, POItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/sap/pocreation') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOHeadersList: POHeadersList,
					onThePOHeadersObjectPage: POHeadersObjectPage,
					onThePOItemsObjectPage: POItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);