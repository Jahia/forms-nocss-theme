<!-- Multiple Radios -->
<div ng-class="{'ff-has-error': form[input.name].$invalid&&form[input.name].$dirty}"
     ng-show="resolveLogic()">
    <label>
        {{input.label}}
        <span ng-if="isRequired()"
              ng-show="asteriskResolver()">
            <sup>&nbsp;*</sup>
        </span>
    </label>

    <div ng-repeat="(radiok, radiov) in input.radios | filter: 'true' : null : visible">
        <label>
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
    </p>
</div>
