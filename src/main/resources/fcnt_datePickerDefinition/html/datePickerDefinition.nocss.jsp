<!-- Date picker-->
<div ng-class="{'ff-has-error': form[input.name].$invalid&&form[input.name].$dirty}"
     ng-show="resolveLogic()">
    <%--Live mode--%>
    <input ng-if="!readOnly"
           type="hidden"
           name="{{input.name}}"
           ng-model="input.value"
           value="{{input.value}}"
           ng-required="isRequired()"
           ff-validations
           ff-logic
           ff-date-picker-validator>
    <%--Builder mode--%>
    <input ng-if="readOnly"
           type="hidden"
           name="{{input.name}}"
           ng-model="input.value"
           value="{{input.builderValue}}"
           ff-validations
           ff-logic>
    <label>
        {{input.label}}
        <span ng-if="isRequired()"
              ng-show="form.$dirty">
            <sup>&nbsp;*</sup>
        </span>
    </label>
    <ff-date-picker read-only="{{datePicker.isDisabled}}"
                    date-picker-size="input.datepickersize"
                    is-disabled="{{datePicker.isDisabled}}"
                    min-date-placeholder="input.placeholder"
                    date-picker-options="datePicker.datePickerOptions"
                    min-value="input.value"
                    parser-separator>
    </ff-date-picker>
    <p>
        <span ng-show="input.helptext != undefined">
            {{input.helptext}}
        </span>
        <span ng-repeat="(validationName, validation) in input.validations"
              ng-show="form[input.name].$error[(validationName | normalize)]&&form[input.name].$dirty">
            {{validation.message}}
        </span>
        <span ng-repeat="errorMessage in errorMessages"
              ng-if="errorMessage.active">
            {{errorMessage.message}}
        </span>
    </p>
</div>