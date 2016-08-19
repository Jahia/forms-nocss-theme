<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- File upload -->
<div ng-class="{'ff-has-error': form[input.name].$invalid&&form[input.name].$dirty}"
     ng-show="resolveLogic()">
    <label>
        {{input.label}}
        <span ng-if="isRequired()"
              ng-show="form.$dirty">
            <sup>&nbsp;*</sup>
        </span>
    </label>
    <div ng-if="!readOnly">
        <input type="file"
               placeholder="{{input.placeholder}}"
               name="{{input.name}}"
               ng-model="input.value"
               ng-required="isRequired()"
               ff-validations
               ff-logic ff-file-input>
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
    <div ng-if="readOnly">
        <button ng-disabled="true">
            <fmt:message key="fcnt_fileUploadDefinition.selectFile"/>
        </button>
            <span ng-show="input.helptext != undefined">
                {{input.helptext}}
            </span>
    </div>
</div>
