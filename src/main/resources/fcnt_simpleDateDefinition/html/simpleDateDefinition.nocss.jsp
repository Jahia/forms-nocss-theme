<!-- Simple date-->
<div ng-class="{'ff-has-error': (form[input.name].$invalid&&form[input.name].$dirty)}"
     ng-show="resolveLogic()">
    <input type="hidden"
           name="{{input.name}}"
           ng-model="input.value"
           ng-required="isRequired()"
           ff-validations
           ng-model-options="{ allowInvalid: true, updateOn: 'default', debounce: {'default': 0} }"
           ff-logic>
    <label>
        {{input.label}}<span ng-if="isRequired()" ng-show="form.$dirty"><sup>&nbsp;*</sup></span>
    </label>
    <div>
        <select ng-model="date.selectedYear"
                ng-model-options="{ allowInvalid: true, updateOn: 'default', debounce: {'default': 0} }"
                ng-change="updateDateModel('year')"
                ng-options="year.id as year.id for year in date.years | orderBy: year.id:true"
                ng-disabled="readOnly">
        </select>
        <select ng-model="date.selectedMonth"
                ng-model-options="{ allowInvalid: true, updateOn: 'default', debounce: {'default': 0} }"
                ng-change="updateDateModel('month')"
                ng-options="month.id as month.id for month in date.months"
                ng-disabled="readOnly">
        </select>
        <select ng-model="date.selectedDay"
                ng-model-options="{ allowInvalid: true, updateOn: 'default', debounce: {'default': 0} }"
                ng-change="updateDateModel('day')"
                ng-options="day.id as day.id disable when !day.displayable for day in date.days"
                ng-disabled="readOnly">
        </select>
    </div>
    <p>
        <span ng-show="input.helptext != undefined">
            {{input.helptext}}
        </span>
        <span ng-repeat="(validationName, validation) in input.validations"
              ng-show="form[input.name].$error[(validationName | normalize)]&&form[input.name].$dirty">
            {{validation.message}}
        </span>
        <span ng-repeat="(errorMessageName, errorMessage) in errorMessages">
            <span ng-if="errorMessage" message-key="{{errorMessageName}}"></span>
        </span>
    </p>
</div>