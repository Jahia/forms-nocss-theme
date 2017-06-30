<!-- Multiple Radios -->
<div ng-class="{'ff-has-error': form[input.name].$invalid&&form[input.name].$dirty}"
     ng-show="resolveLogic()">

    <input name="{{input.name}}"
           type="hidden"
           ng-model="input.value"
           ng-model-options="{'allowInvalid':true}"
           number-of-rows="{{input.rows.length}}"
           ff-logic
           ff-validations/>
    <label class="control-label">
        {{input.label}}
                    <span ng-if="isRequired()"
                          ng-show="form.$dirty">
                        <sup>&nbsp;*</sup>
                    </span>
    </label>
    <table>
        <thead>
        <tr>
            <th>&nbsp;</th>
            <th ng-repeat="(colk, colv) in input.columns"><span>{{colv.value}}</span></th>
        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="(rowk, rowv) in input.rows">
            <td><span>{{rowv.value}}</span></td>
            <td ng-repeat="(colk, colv) in input.columns">
                <input type="radio"
                       name="{{::(input.name+'.'+rowv.key)}}"
                       ng-model="input.value[rowv.key]"
                       value="{{colv.key}}"
                       ng-change="makeDirty(); ffValidate()"
                       ng-disabled="readOnly"
                       ff-focus-tracker="{{input.name}}_{{rowv.key}}_{{colv.key}}"></td>
        </tr>
        </tbody>
    </table>

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
