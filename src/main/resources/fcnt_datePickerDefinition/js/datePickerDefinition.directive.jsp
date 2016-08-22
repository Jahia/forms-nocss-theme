<%@
 page
 contentType="text/javascript" %>
<%@ taglib prefix="formfactory" uri="http://www.jahia.org/formfactory/functions" %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>

(function() {
    var datePickerInput = function($log, ffTemplateResolver) {
        var directive = {
            restrict: 'E',
            require: ['^ffController'],
            controller: datePickerInputController,
            bindToController: true,
            controllerAs: 'dpic',
            templateUrl: function(el, attrs) {
                return ffTemplateResolver.resolveTemplatePath('${formfactory:addFormFactoryModulePath('/form-factory-definitions/date-picker', renderContext)}', attrs.viewType);
            },
            link: linkFunction
        };

        return directive;

        function linkFunction(scope, el, attr, ctrl) {
            var formController = ctrl[0];
            scope.datePicker = {};
            scope.datePicker.datePickerOptions = {};
            //Convert to boolean in case it is a string
            scope.input.useCurrentDate = (scope.input.useCurrentDate === true || scope.input.useCurrentDate == 'true');
            scope.datePicker.isDisabled = !formController.isLiveMode() || (formController.isLiveMode() && scope.input.useCurrentDate);
            //If undefined initialize to empty string so that the date picker initializes correctly.

            var m = moment();
            if (scope.input.useCurrentDate && formController.isLiveMode()) {
                scope.input.value = m.toDate();
            } else if (_.isUndefined(scope.input.value)){
                scope.input.value = null;
            }
            delete m;
            //Set max date value to the end of selected year.
            //When saving just the year, date picker will save the date as january 01, set this to december 31.
            if (formController.isLiveMode()) {
                //do this after initialization of input value so that we don't set a possibly invalid date.
                scope.input.maxDate = moment(scope.input.maxDate).month(11).date(31).toISOString();
            }
            //Date picker options must be set directly after we initialize the min and max date
            if (!scope.input.useCurrentDate) {
                scope.datePicker.datePickerOptions.minDate = scope.input.minDate;
                scope.datePicker.datePickerOptions.maxDate = scope.input.maxDate
            }
        }
    };

    var datePickerInputController = function($scope) {
        var dpic = this;
        //This is controller is used to setup the min and max date for the date picker
        //when it is initialized so that it propagates to the designView.
        if($scope.readOnly) {
            if (!($scope.input.minDate instanceof Date)) {
                //create valid date, as this is the value originating from wizard file.
                $scope.input.minDate = !_.isEmpty($scope.input.minDate) ? moment($scope.input.minDate, 'YYYY').toISOString() : moment(moment().year() - 20, 'YYYY').toISOString();
            }
            if (!($scope.input.maxDate instanceof Date)) {
                //create valid date, as this is the value originating from wizard file.
                $scope.input.maxDate = !_.isEmpty($scope.input.maxDate) ? moment($scope.input.maxDate, 'YYYY').toISOString() : moment(moment().year() + 10, 'YYYY').toISOString();
            }
        }

        //Do this only in live.
        //Sets the input as dirty once the date has been modified by the user (after first initialization)
        if (!$scope.readOnly) {
            var controllerWatch = $scope.$watch(function () {
                return !_.isUndefined($scope.form[$scope.input.name]);
            }, function(isDefined) {
                if (isDefined) {
                    controllerWatch();
                    //Watch the inputs value and determine when the value has been modified.
                    //Watch is removed after first modification.
                    var setDirtyWatch = $scope.$watch(function() {
                        return $scope.input.value;
                    }, function(newValue, oldValue) {
                        oldValue = oldValue instanceof Date ? oldValue.toISOString() : oldValue;
                        newValue = newValue instanceof Date ? newValue.toISOString() : newValue;
                        if (!_.isUndefined(oldValue) && (oldValue != newValue)) {
                            setDirtyWatch();
                            $scope.form[$scope.input.name].$setDirty();
                        }
                    });
                }
            });
        }
    };

    datePickerInputController.$inject = ['$scope'];
    angular
            .module('formFactory')
            .directive('ffDatePickerInput', ['$log', 'ffTemplateResolver', datePickerInput]);

    //Date picker validator, that will ensure the selected value meets the requirements
    //set within the design view.
    var datePickerValidator = function($log, i18n, ffCommonUseFactory) {
        var directive = {
            restrict: 'A',
            require: ['^ngModel'],
            link: linkFunction
        };

        return directive;

        function linkFunction(scope, el, attr, ctrl) {
            var model = ctrl[0];
            var minDate = moment(scope.input.minDate, 'Y-M-D');
            var maxDate = moment(scope.input.maxDate, 'Y-M-D');
            //Error messages to be displayed based on the invalidity case.
            //Structured this way in case extra information (such as the min or maximum date)
            //is to be appended to the internationalized message.
            scope.$parent.errorMessages = {
                'error-minYear': {
                    active: false,
                    message: i18n.message('angular.ffDatePickerValidator.error.minYear')
                },
                'error-maxYear': {
                    active: false,
                    message: i18n.message('angular.ffDatePickerValidator.error.maxYear')
                },
                'error-invalidDate': {
                    active: false,
                    message: i18n.message('angular.ffDatePickerValidator.error.invalidDate')
                }
            };

            //Create and attach validator to the model
            model.$validators['invalidDate_' + scope.input.name] = function(modelValue, viewValue) {
                var valid = true;

                scope.errorMessages['error-invalidDate'].active = false;
                scope.errorMessages['error-minYear'].active = false;
                scope.errorMessages['error-maxYear'].active = false;
                if (viewValue === null) {
                    return true;
                }
                if (!ffCommonUseFactory.parseDate(viewValue)) {
                    scope.errorMessages['error-invalidDate'].active = true;
                    return false;
                }

                if (viewValue instanceof Date) {
                    viewValue = moment(viewValue.toISOString()).format('YYYY-MM-DD');
                } else {
                    var template = '0000';
                    var sections = viewValue.split('-').length === 3 ?  viewValue.split('-') :  viewValue.split('/');
                    sections[0] = parseInt(sections[0]);
                    if (sections[0].toString().length < 4) {
                        sections[0] = template.substr(0, 4 - sections[0].toString().length) + sections[0].toString();
                        viewValue = sections.join('-');
                    }
                }
                var selectedDate = moment(viewValue, 'YYYY-MM-DD');
                //Validate against a date that is valid but does not meet the minimum date requirement
                //Set/unset the error message based on the validation
                if (!_.isUndefined(viewValue) && selectedDate.isBefore(minDate.toISOString(), 'year')) {
                    valid = false;
                    scope.errorMessages['error-minYear'].active = true;
                }
                //Validate against a date that is valid but does not meet the maximum date requirement
                //Set/unset the error message based on the validation
                if (!_.isUndefined(viewValue) && selectedDate.isAfter(maxDate.toISOString(), 'year')) {
                    valid = false;
                    scope.errorMessages['error-maxYear'].active = true;
                }

                return valid;
            }
        }
    };

    angular
            .module('formFactory')
            .directive('ffDatePickerValidator', ['$log', 'i18nService', 'ffCommonUseFactory', datePickerValidator]);

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

        angular
                .module('formFactory')
                .directive('ffDatePickerUi', ['$log', 'i18nService', 'ffCommonUseFactory', datePickerJqueryUI]);
})();