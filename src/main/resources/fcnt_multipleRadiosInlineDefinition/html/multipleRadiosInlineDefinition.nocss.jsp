<!-- Multiple Radios (inline) -->
<div ng-class="{'ff-has-error': form[input.name].$invalid&&form[input.name].$dirty}"
     ng-show="resolveLogic()">
    <label class="col-sm-2 control-label">
        {{input.label}}
        <span ng-if="isRequired()"
              ng-show="form.$dirty">
            <sup>&nbsp;*</sup>
        </span>
    </label>

        <label ng-repeat="(radiok, radiov) in input.radios">
            <input type="radio"
                   name="{{input.name}}"
                   ng-model="input.value"
                   ng-model-options="{'allowInvalid':true}"
                   value="{{radiov.key}}"
                   ng-required="isRequired()"
                   ng-disabled="readOnly"
                   ng-change="makeDirty()"
                   ff-validations
                   ff-logic
                   ff-focus-tracker="{{input.name}}_{{radiov.key}}">
            {{radiov.value}}
        </label>
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
