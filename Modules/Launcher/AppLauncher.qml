import QtQuick

import Quickshell
import Quickshell.Io

import qs.Services

Item {
    id: root

    property string searchQuery: ""
    property string viewMode: "list" // "list" or "grid"

    function updateFilteredModel() {
        filteredModel.clear();
        var apps = [];
        if (searchQuery === "") {
            apps = AppSearchService.searchApplications(searchQuery);
        } else {
            apps = AppSearchService.searchApplications(searchQuery);
        }
    }

    Component.onCompleted: {
        console.log("AppLauncher initialized");
        updateFilteredModel();
    }

    ListModel {
        id: filteredModel
    }
}
