<div ng-show="resolveLogic()">
    <label>
        {{input.label}}
    </label>

    <span class="switch"
              ng-click="readOnly ? input.value : input.value =! input.value"
              ng-class="{'{{input.color}}' : input.value, 'disabled' : readOnly}">
            <small></small>
            <input style="display:none;"
                   type="checkbox"
                   name="{{input.name}}"
                   ng-model="input.value"
                   ff-validations
                   ff-logic>
            <span class="switch-text" ng-show="input.displayText">
                <span class="on">{{input.textOn}}</span>
                <span class="off">{{input.textOff}}</span>
            </span>
        </span>
        <p>
        <span ng-show="input.helptext != undefined">
            {{input.helptext}}
        </span>
        </p>
</div>