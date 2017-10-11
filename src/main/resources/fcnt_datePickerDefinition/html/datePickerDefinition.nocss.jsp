<!-- Date picker-->
<div ng-class="{'ff-has-error': form[input.name].$invalid&&form[input.name].$dirty}"
     ng-show="resolveLogic()">
    <label>
        {{input.label}}
        <span ng-if="isRequired()"
              ng-show="asteriskResolver()">
            <sup>&nbsp;*</sup>
        </span>
    </label>
    <%--Live mode--%>
    <input ng-if="!readOnly"
           type="text"
           name="{{input.name}}"
           ng-model="input.value"
           ng-required="isRequired()"
           ff-validations
           ff-logic
           ff-date-picker-validator
           ff-date-picker-ui
           ff-focus-tracker="{{input.name}}">
    <%--Builder mode--%>
    <input ng-if="readOnly"
           type="hidden"
           name="{{input.name}}"
           ng-model="input.value"
           value="{{input.builderValue}}"
           ff-validations
           ff-logic>
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
        <span ng-repeat="errorMessage in errorMessages"
              ng-if="errorMessage.active">
            {{errorMessage.message}}
        </span>
    </p>
</div>