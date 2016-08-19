<!-- Multiple Checkboxes -->
<div class="form-group"
     ng-class="{'has-error': form[input.name].$invalid&&form[input.name].$dirty}"
     ng-show="resolveLogic()">

    <input name="{{input.name}}"
           type="hidden"
           ng-model="input.value"
           ng-model-options="{'allowInvalid':true}"
           number-of-rows="{{input.rows.length}}"
           ff-logic
           ff-validations/>
    <div class="row">
        <div class="col-sm-12">
            <p class="text-center">
                <label class="control-label">
                    {{input.label}}
                    <span ng-if="isRequired()"
                          ng-show="form.$dirty">
                        <sup>&nbsp;<i class="fa fa-asterisk fa-sm"></i></sup>
                    </span>
                </label>
            </p>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-offset-2 col-sm-10">
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="{{columnWidth}} text-center" ng-repeat="(colk, colv) in input.columns">
                    <span>{{colv.value}}</span>
                </div>
            </div>
            <div class="row" ng-repeat="(rowk, rowv) in input.rows">
                <div class="col-sm-2"><span>{{rowv.value}}</span></div>
                <div class="{{columnWidth}} text-center" ng-repeat="(colk, colv) in input.columns">
                    <input type="checkbox"
                           name="{{::(input.name+'.'+rowv.key)}}"
                           checklist-model="input.value[rowv.key]"
                           checklist-value="colv.key"
                           checklist-change="makeDirty(); ffValidate()">
                </div>
            </div>
            <div class="row">
                <div class="col-sm-10 col-sm-offset-2">
                    <span class="help-block"
                          ng-show="input.helptext != undefined">
                        {{input.helptext}}
                    </span>
                    <span class="help-block"
                          ng-repeat="(validationName, validation) in input.validations"
                          ng-show="form[input.name].$error[(validationName | normalize)]&&form[input.name].$dirty">
                            {{validation.message}}
                    </span>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="well well-sm" ng-show="readOnly">
                <div class="row">
                    <div class="col-sm-8 col-sm-offset-2">
                        <span class="text-info" message-key="ff.matrix.builder.default.value"></span>
                    </div>
                    <div class="col-sm-2">
                        <button class="btn btn-default btn-small" ng-click="reset()"
                                message-key="angular.ffController.button.reset"></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix"/>
</div>
