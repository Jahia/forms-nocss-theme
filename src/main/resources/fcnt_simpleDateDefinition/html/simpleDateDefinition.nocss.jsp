<!-- Simple date-->
<div ng-class="{'ff-has-error': (form[input.name].$invalid&&form[input.name].$dirty)}"
     ng-show="resolveLogic()">
    <input type="hidden"
           name="{{input.name}}"
           ng-model="input.value"
           ng-required="isRequired()"
           ff-validations
           ng-model-options="{ allowInvalid: true, updateOn: 'default', debounce: {'default': 0} }"
           ff-logic
           ff-valid-year>
    <label>
        {{input.label}}<span ng-if="isRequired()" ng-show="form.$dirty"><sup>&nbsp;*</sup></span>
    </label>
    <div>
        <div role="group">
            <input type="text"
                   placeholder="{{input.placeholder[0]}}"
                   ng-model="date.selectedYear"
                   ng-model-options="{ allowInvalid: true, updateOn: 'default', debounce: {'default': 0} }"
                   ng-change="updateDateModel('year')"
                   ng-readonly="readOnly || input.useCurrentDate"
                   min="{{date.minYear}}"
                   max="{{date.maxYear}}"
                   parse-valid-year/>
            <button type="button"
                    ng-disabled="readOnly || input.useCurrentDate">
                select year
            </button>
            <ul role="menu" style="display: none;">
                <li ng-repeat="year in date.years | orderBy : year : true">
                    <a href=""
                       ng-click="$event.preventDefault(); date.selectedYear=year.id; updateDateModel('year')">{{year.id}}</a>
                </li>
            </ul>
        </div>
        <div role="group">
            <input name="selectMonth"
                   type="text"
                   placeholder="{{input.placeholder[1]}}"
                   ng-model="date.selectedMonth"
                   ng-readonly="true">
            <button type="button"
                    ng-disabled="readOnly || input.useCurrentDate">
                select month
            </button>
            <ul role="menu" style="display: none;">
                <li ng-repeat="month in date.months">
                    <a href=""
                       ng-click="$event.preventDefault(); date.selectedMonth=month.id; updateDateModel('month')">{{month.id}}</a>
                </li>
            </ul>
        </div>
        <div role="group">
            <input name="selectDay"
                   type="text"
                   placeholder="{{input.placeholder[2]}}"
                   ng-model="date.selectedDay"
                   ng-readonly="true">

            <button type="button" ng-disabled="readOnly || input.useCurrentDate">
                select day
            </button>
            <ul role="menu" style="display: none;">
                <li ng-repeat="day in date.days" ng-show="day.displayable">
                    <a href=""
                       ng-click="$event.preventDefault(); date.selectedDay=day.id; updateDateModel('day')">{{day.id}}</a>
                </li>
            </ul>
        </div>
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