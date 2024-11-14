sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.sap.pocreation',
            componentId: 'POItemsObjectPage',
            contextPath: '/POHeaders/to_POItems'
        },
        CustomPageDefinitions
    );
});