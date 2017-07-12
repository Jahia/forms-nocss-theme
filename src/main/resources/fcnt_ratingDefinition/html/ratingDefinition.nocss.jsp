<div ng-class="{'ff-has-error': form[input.name].$invalid&&form[input.name].$dirty}"
     ng-show="resolveLogic()">
    <label>
        {{input.label}}<span ng-if="isRequired()" ng-show="asteriskResolver()"><sup>&nbsp;*</sup></span>
    </label>

    <input type="hidden"
           name="{{input.name}}"
           ng-model="input.value"
           ng-required="isRequired()"
           ff-validations
           ff-logic>
        <span ng-mouseleave="reset()"
              ng-keydown="onKeydown($event)"
              tabindex="0"
              role="slider"
              aria-valuemin="0"
              aria-valuemax="{{range.length}}"
              aria-valuenow="{{value}}">
          <span ng-repeat-start="r in range track by $index"></span>
            <i ng-repeat-end
               ng-mouseenter="enter($index + 1)"
               ng-click="rate($index + 1)"
               class="fa {{r.iconSize}}"
               ng-class="$index < value && (r.stateOn || 'fa-star') || (r.stateOff || 'fa-star-o')"
               ff-focus-tracker="{{input.name}}_{{$index}}">
            </i>
           </span>
    </span>
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