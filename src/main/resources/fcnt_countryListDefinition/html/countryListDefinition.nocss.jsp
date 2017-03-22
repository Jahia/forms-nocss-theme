<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div ng-class="{'ff-has-error': form[input.name].$invalid&&form[input.name].$dirty}"
     ng-show="resolveLogic()">
    <label>
        {{input.label}}
        <span ng-if="isRequired()"
              ng-show="form.$dirty">
            <sup>&nbsp;*</sup>
        </span>
    </label>

    <select name="{{input.name}}"
            ng-model-options="{allowInvalid:true}"
            ng-model="input.value"
            ng-required="isRequired()"
            ng-options="country as country.country.name for country in countries track by country.country.key"
            ng-disabled="readOnly()"
            ff-validations
            ff-logic>
        <option value="">{{input.placeholder}}</option>
    </select>
    <p>
        <span ng-show="input.helptext != undefined">
            {{input.helptext}}
        </span>
        <span ng-repeat="(validationName, validation) in input.validations"
              ng-show="form[input.name].$error[(validationName | normalize)]&&form[input.name].$dirty">
            {{validation.message}}
        </span>
    </p>
</div>
