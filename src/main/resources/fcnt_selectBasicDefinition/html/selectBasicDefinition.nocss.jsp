<!-- Select basic-->
<div ng-class="{'ff-has-error': form[input.name].$invalid&&form[input.name].$dirty}"
     ng-show="resolveLogic()">
    <label>
        {{input.label}}<span ng-if="isRequired()" ng-show="asteriskResolver()"><sup>&nbsp;*</sup></span>
    </label>

    <select type="select-basic"
            ng-model-options="{allowInvalid:true}"
            name="{{input.name}}"
            ng-model="input.value"
            ng-required="isRequired()"
            ng-disabled="readOnly"
            ff-validations
            ff-logic
            ff-focus-tracker="{{input.name}}">
        <option ng-if="input.value == '' || input.value === null" value="">{{input.placeholder}}</option>
        <option ng-repeat="option in input.options | filter: 'true' : null : visible" value="{{option.key}}">{{option.value}}</option>
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
