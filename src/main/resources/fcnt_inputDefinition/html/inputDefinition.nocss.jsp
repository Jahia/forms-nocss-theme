<!-- Text input-->
<div ng-class="{'ff-has-error': form[input.name].$invalid&&form[input.name].$dirty}"
     ng-show="resolveLogic()">
    <label >
        {{input.label}}
        <span ng-if="isRequired()"
              ng-show="form.$dirty">
            <sup>&nbsp;*</sup>
        </span>
    </label>

    <input type="text"
               ng-model-options="{allowInvalid:true}"
               placeholder="{{input.placeholder}}"
               name="{{input.name}}"
               ng-model="input.value"
               ng-required="isRequired()"
               ng-readonly="readOnly()"
               ff-validations
               ff-logic/>
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