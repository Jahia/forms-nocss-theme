<!-- Textarea -->
<div ng-class="{'ff-has-error': form[input.name].$invalid&&form[input.name].$dirty}"
     ng-show="resolveLogic()">
    <label>
        {{input.label}}<span ng-if="isRequired()" ng-show="asteriskResolver()"><sup>&nbsp;*</sup></span>
    </label>

        <textarea rows="{{input.rows}}"
                  ng-model-options="{allowInvalid:true}"
                  ng-model="input.value"
                  placeholder="{{input.placeholder}}"
                  name="{{input.name}}"
                  ng-required="isRequired()"
                  ng-readonly="readOnly"
                  ff-validations
                  ff-logic
                  ff-focus-tracker="{{input.name}}">
            {{input.value}}
        </textarea>
    <p>
        <span class="help-block"
              ng-show="input.helptext != undefined">
            {{input.helptext}}
        </span>
        <span class="help-block"
              ng-repeat="(validationName, validation) in input.validations"
              ng-show="form[input.name].$error[(validationName | normalize)]&&form[input.name].$dirty">
                {{validation.message}}
        </span>
    </p>
</div>
