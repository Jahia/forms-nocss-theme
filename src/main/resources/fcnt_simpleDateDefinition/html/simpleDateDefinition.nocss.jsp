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
        {{input.label}}<span ng-if="isRequired()" ng-show="asteriskResolver()"><sup>&nbsp;*</sup></span>
    </label>
    <div>
        <select ng-model="date.selectedYear"
                ng-model-options="{ allowInvalid: true, updateOn: 'default', debounce: {'default': 0} }"
                ng-change="updateDateModel('year')"
                ng-options="year.id as year.id for year in date.years | orderBy: year.id:true"
                ng-disabled="readOnly"
                ff-focus-tracker="{{input.name}}_year">
        </select>
        <select ng-model="date.selectedMonth"
                ng-model-options="{ allowInvalid: true, updateOn: 'default', debounce: {'default': 0} }"
                ng-change="updateDateModel('month')"
                ng-options="month.id as month.id for month in date.months"
                ng-disabled="readOnly"
                ff-focus-tracker="{{input.name}}_month">
        </select>
        <select ng-model="date.selectedDay"
                ng-model-options="{ allowInvalid: true, updateOn: 'default', debounce: {'default': 0} }"
                ng-change="updateDateModel('day')"
                ng-options="day.id as day.id disable when !day.displayable for day in date.days"
                ng-disabled="readOnly"
                ff-focus-tracker="{{input.name}}_day">
        </select>
    </div>
    <p>
        <span ng-show="input.helptext != undefined">
            {{input.helptext}}
        </span>
        <br/>
        <span ng-repeat="(validationName, validation) in input.validations"
              ng-show="showErrorMessage(validationName)">
            {{validation.message}}
        </span>
        <br/>
        <span ng-repeat="(errorMessageName, errorMessage) in errorMessages">
            <span ng-if="errorMessage" message-key="{{errorMessageName}}"></span>
        </span>
    </p>
</div>