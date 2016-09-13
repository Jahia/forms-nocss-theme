<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="flowRequestContext" type="org.springframework.webflow.execution.RequestContext"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>

<div ng-class="{'ff-has-error': form[input.name].$invalid&&form.$dirty}"
     ng-show="resolveLogic()" ff-validations ff-logic>
    <fieldset>
        <legend class="col-sm-2 control-label">
            {{input.label}}
        </legend>
        <input name="{{input.name}}" type="hidden" ng-model="input.value" ng-model-options="{allowInvalid:true}"/>
        <div>
            <input name="{{input.name}}.address1"
                   ng-model="input.value.address1"
                   type="text"
                   placeholder="{{input.address1Placeholder}}"
                   ng-readonly="readOnly"
                   class="form-control"/>
        </div>
        <div>
            <input ng-model="input.value.address2"
                   type="text"
                   placeholder="{{input.address2Placeholder}}"
                   ng-readonly="readOnly"
                   class="form-control"/>
        </div>
        <div>
            <input ng-model="input.value.city"
                   type="text"
                   placeholder="{{input.cityPlaceholder}}"
                   class="form-control"
                   ng-readonly="readOnly"/>
            <input ng-model="input.value.state"
                   type="text"
                   placeholder="{{input.statePlaceholder}}"
                   ng-readonly="readOnly"
                   class="form-control"/>
        </div>
        <div>
            <input ng-model="input.value.zipcode"
                   type="text"
                   placeholder="{{input.zipcodePlaceholder}}"
                   ng-readonly="readOnly"
                   class="form-control"/>
            <select name="{{input.name}}.country"
                    ng-model="input.value.country"
                    class="form-control"
                    ng-disabled="readOnly"
                    ng-options="country as country.country.name for country in countries | orderBy: country.name">
            </select>
        </div>
        <p>
        <span ng-show="input.helptext !== undefined">
                {{input.helptext}}
        </span>
            </p>
        <p>
        <span ng-repeat="(validationName, validation) in input.validations"
              ng-show="form[input.name].$error[(validationName | normalize)]&&form.$dirty">
            <span ng-show="!isFieldValid('address1')">{{validation.messageaddress}}<br/></span>
            <span ng-show="!isFieldValid('zipcode')">{{validation.messagezipcode}}<br/></span>
            <span ng-show="!isFieldValid('city')">{{validation.messagecity}}<br/></span>
            <span ng-show="!isFieldValid('country')">{{validation.messagecountry}}</span>
    </span>
        </p>
    </fieldset>

</div>