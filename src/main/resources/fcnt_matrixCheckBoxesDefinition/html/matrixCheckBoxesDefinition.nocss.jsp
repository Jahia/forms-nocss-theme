<!-- Multiple Checkboxes -->
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
            <td ng-repeat="(colk, colv) in input.columns" align="center">
                <input type="checkbox"
                       name="{{::(input.name+'.'+rowv.key)}}"
                       checklist-model="input.value[rowv.key]"
                       checklist-value="colv.key"
                       checklist-change="makeDirty(); ffValidate()">
            </td>
        </tr>
        </tbody>
    </table>
    <p>
        <span ng-show="input.helptext != undefined">{{input.helptext}}</span>
        <span ng-repeat="(validationName, validation) in input.validations"
              ng-show="form[input.name].$error[(validationName | normalize)]&&form[input.name].$dirty">
                {{validation.message}}
        </span>
    </p>
</div>
