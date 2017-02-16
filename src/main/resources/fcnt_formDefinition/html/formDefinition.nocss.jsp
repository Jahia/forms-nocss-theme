<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<div ng-if="vm.getFormController().$submitted">
    <div ng-if="vm.displaySubmissionText && vm.currentForm.callbackName != null">
        <div>
            <ff-callback ng-if="vm.runCallbacks"
                         action-data="vm.actionData"
                         result-data="vm.resultData"
                         callback-directives="vm.currentForm.callbacks.callbacks"
                         all-completed-flag="vm.displaySubmissionText"
                         display-templates="vm.currentForm.callbacks.displayTemplates">
            </ff-callback>
        </div>
    </div>
    <div ng-if="vm.displaySubmissionText">
        <div>
            <strong ng-bind-html="vm.currentForm.afterSubmissionText"></strong>
        </div>
    </div>
</div>

<div>
    <form novalidate name="{{vm.formName}}"
          ng-model-options="{updateOn:'default blur', debounce: { default: 0, blur: 0 } }"
          ng-submit="vm.preventSubmit($event)"
          class="{{vm.cssClassName}}">
        <fieldset>
            <legend ng-if="vm.showFormTitle">{{vm.currentForm.displayableName}}</legend>
            <div ng-repeat="input in vm.inputs">
                <ff-input
                        input="input"
                        resolve-logic="vm.resolveLogic(input, vm.getFormController())"
                        resolve-placeholder="vm.resolvePlaceholder(input)"
                        resolve-inputsize="vm.resolveInputsize(input)"
                        resolve-name="vm.resolveName(input)"
                        resolve-label="vm.resolveLabel(input)">
                </ff-input>
            </div>
            <div ng-if="vm.getCaptchaKey() !== null && vm.currentForm.steps.length-1 === vm.currentStep && vm.currentForm.displayCaptcha">

                <div vc-recaptcha theme="'light'"
                     key="vm.getCaptchaKey()"
                     on-create="vm.notifyOfCaptchaLoad()">
                </div>
            </div>
            <div>
                <button type="button"
                        ng-click="vm.update(false)"
                        ng-disabled="vm.getFormController().$submitted"
                        ng-show="vm.currentStep>0&&!vm.isSubmitted()"
                        message-key="angular.ffController.button.previousStep">
                </button>
                <button type="button"
                        ng-click="vm.update(true)"
                        ng-disabled="vm.getFormController().$invalid
                                || vm.getFormController().$submitted
                                || vm.isPreviewMode
                                || (vm.getCaptchaKey() !== null && !vm.captchaLoaded)
                                || vm.currentStep<vm.currentForm.steps.length-1"
                        ng-show="vm.currentStep==vm.currentForm.steps.length-1&&!vm.isSubmitted()"
                        message-key="angular.ffController.button.submit">
                </button>
                <button type="button"
                        ng-click="vm.update(true)"
                        ng-disabled="vm.getFormController().$invalid || vm.getFormController().$submitted"
                        ng-show="vm.currentStep<vm.currentForm.steps.length-1&&!vm.isSubmitted()"
                        message-key="angular.ffController.button.nextStep">
                </button>
                <button type="button" ng-click="vm.reset()"
                        ng-disabled="vm.getFormController().$submitted || vm.currentForm.steps[vm.currentStep].resetDisabled"
                        ng-show="!vm.isSubmitted()"
                        message-key="angular.ffController.button.reset">
                </button>
            </div>
        </fieldset>
    </form>
</div>



