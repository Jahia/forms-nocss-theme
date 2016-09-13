<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<template:addResources type="javascript" resources="jquery-ui.min.js"/>
<template:addResources type="css" resources="jquery-ui.smoothness.css"/>
<template:addResources type="css" resources="jquery-ui.smoothness-jahia.css"/>
<script>
    (function(){
        var datePickerJqueryUI = function($log, i18n, ffCommonUseFactory) {
            var directive = {
                restrict: 'A',
                require : ['^ngModel'],
                link    : linkFunction
            };

            return directive;

            function linkFunction(scope, el, attr, ctrl) {
                $(el).datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: 'yy-mm-dd'
                });
            }
        };

        angular.module('formFactory').directive('ffDatePickerUi', ['$log', 'i18nService', 'ffCommonUseFactory', datePickerJqueryUI]);
    })();
</script>
<style>
    .ff-has-error {
        color: red;
        border: 1px solid red ;
    }
</style>