<%@ include file="/include.jsp" %>

<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>

<%--
  ~ Copyright (C) 2010 JFrog Ltd.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  --%>

<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="controllerUrl" scope="request" type="java.lang.String"/>
<jsp:useBean id="disabledMessage" scope="request" type="java.lang.String"/>

<c:set var="foundExistingConfig"
       value="${not empty propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.urlId'] ? true : false}"/>

<c:set var="foundActivateGradleIntegrationSelected"
       value="${(not empty propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.activateGradleIntegration'])
       && (propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.activateGradleIntegration'] == true) ? true : false}"/>

<c:set var="foundDeployArtifactsSelected"
       value="${(not empty propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.deployArtifacts'])
       && (propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.deployArtifacts'] == true) ? true : false}"/>

<c:set var="foundPublishBuildInfoSelected"
       value="${(not empty propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.publishBuildInfo'])
       && (propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.publishBuildInfo'] == true) ? true : false}"/>

<script type="text/javascript">
<%@ include file="../common/artifactoryCommon.js" %>
BS.local = {
    onServerChange : function(foundExistingConfig) {
        var urlIdSelect = $('org.jfrog.artifactory.selectedDeployableServer.urlId');
        var publishRepoSelect = $('org.jfrog.artifactory.selectedDeployableServer.targetRepo');
        var resolvingRepoSelect = $('org.jfrog.artifactory.selectedDeployableServer.resolvingRepo');

        var selectedUrlId = urlIdSelect.options[urlIdSelect.selectedIndex].value;
        if (!selectedUrlId) {
            publishRepoSelect.innerHTML = '';
            resolvingRepoSelect.innerHTML = '';
            $('org.jfrog.artifactory.selectedDeployableServer.overrideDefaultDeployerCredentials').checked = false;
            $('org.jfrog.artifactory.selectedDeployableServer.deployerUsername').value = '';
            $('secure:org.jfrog.artifactory.selectedDeployableServer.deployerPassword').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.activateGradleIntegration').checked = false;
            $('org.jfrog.artifactory.selectedDeployableServer.deployArtifacts').checked = false;
            $('org.jfrog.artifactory.selectedDeployableServer.deployIncludePatterns').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.deployExcludePatterns').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.useM2CompatiblePatterns').checked = true;
            $('org.jfrog.artifactory.selectedDeployableServer.ivyPattern').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.artifactPattern').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.publishBuildInfo').checked = true;
            $('org.jfrog.artifactory.selectedDeployableServer.publishMavenDescriptors').checked = true;
            $('org.jfrog.artifactory.selectedDeployableServer.publishIvyDescriptors').checked = true;
            $('org.jfrog.artifactory.selectedDeployableServer.runLicenseChecks').checked = false;
            $('org.jfrog.artifactory.selectedDeployableServer.licenseViolationRecipients').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.limitChecksToScopes').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.includePublishedArtifacts').checked = false;
            $('org.jfrog.artifactory.selectedDeployableServer.disableAutoLicenseDiscovery').checked = false;
            $('org.jfrog.artifactory.selectedDeployableServer.publishedArtifacts').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.publishedDependencies').disabled = true;
            $('org.jfrog.artifactory.selectedDeployableServer.publishedDependencies').value = '${disabledMessage}';
            $('org.jfrog.artifactory.selectedDeployableServer.enableReleaseManagement').checked = false;
            $('org.jfrog.artifactory.selectedDeployableServer.vcsTagsBaseUrlOrName').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.gitReleaseBranchNamePrefix').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.alternativeMavenGoals').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.alternativeMavenOptions').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.releaseProperties').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.nextIntegrationProperties').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.alternativeGradleTasks').value = '';
            $('org.jfrog.artifactory.selectedDeployableServer.alternativeGradleOptions').value = '';

            BS.Util.hide($('targetRepo.container'));
            BS.Util.hide($('resolvingRepo.container'));
            BS.Util.hide($('version.warning.container'));
            BS.Util.hide($('offline.warning.container'));
            BS.Util.hide($('overrideDefaultDeployerCredentials.container'));
            BS.Util.hide($('deployerUsername.container'));
            BS.Util.hide($('deployerPassword.container'));
            BS.Util.hide($('activateGradleIntegration.container'));
            BS.Util.hide($('deployArtifacts.container'));
            BS.Util.hide($('deployIncludePatterns.container'));
            BS.Util.hide($('deployExcludePatterns.container'));
            BS.Util.hide($('useM2CompatiblePatterns.container'));
            BS.Util.hide($('ivyPattern.container'));
            BS.Util.hide($('artifactPattern.container'));
            BS.Util.hide($('publishBuildInfo.container'));
            BS.Util.hide($('publishMavenDescriptors.container'));
            BS.Util.hide($('publishIvyDescriptors.container'));
            BS.Util.hide($('runLicenseChecks.container'));
            BS.Util.hide($('licenseViolationRecipients.container'));
            BS.Util.hide($('publishedArtifacts.container'));
            BS.Util.hide($('publishedDependencies.container'));
            BS.Util.hide($('enableReleaseManagement.container'));
            BS.Util.hide($('vcsTagsBaseUrlOrName.container'));
            BS.Util.hide($('gitReleaseBranchNamePrefix.container'));
            BS.Util.hide($('alternativeMavenGoals.container'));
            BS.Util.hide($('alternativeMavenOptions.container'));
            BS.Util.hide($('defaultModuleVersionConfiguration.container'));
            BS.Util.hide($('releaseProperties.container'));
            BS.Util.hide($('nextIntegrationProperties.container'));
            BS.Util.hide($('alternativeGradleTasks.container'));
            BS.Util.hide($('alternativeGradleOptions.container'));
        } else {

            if (!foundExistingConfig) {
                $('org.jfrog.artifactory.selectedDeployableServer.activateGradleIntegration').checked = false;
                $('org.jfrog.artifactory.selectedDeployableServer.deployArtifacts').checked = true;
                $('org.jfrog.artifactory.selectedDeployableServer.overrideDefaultDeployerCredentials').checked = false;
                $('org.jfrog.artifactory.selectedDeployableServer.publishMavenDescriptors').checked = true;
                $('org.jfrog.artifactory.selectedDeployableServer.publishIvyDescriptors').checked = true;
            }
            BS.local.loadTargetRepos(selectedUrlId);
            BS.artifactory.checkArtifactoryHasAddons(selectedUrlId);
            BS.artifactory.checkCompatibleVersion(selectedUrlId);
            BS.Util.show($('targetRepo.container'));
            if (BS.local.isActivateGradleIntegrationSelected()) {
                BS.Util.show($('resolvingRepo.container'));
                BS.Util.show($('publishBuildInfo.container'));
                if (BS.artifactory.isDeployArtifactsSelected()) {
                    BS.Util.show($('publishMavenDescriptors.container'));
                    BS.Util.show($('publishIvyDescriptors.container'));
                }
            }
            BS.Util.show($('overrideDefaultDeployerCredentials.container'));
            if (BS.artifactory.isOverrideDefaultDeployerCredentialsSelected()) {
                BS.Util.show($('deployerUsername.container'));
                BS.Util.show($('deployerPassword.container'));
            }

            if (BS.local.isActivateGradleIntegrationSelected()) {
                BS.Util.show($('deployArtifacts.container'));
                if (BS.artifactory.isDeployArtifactsSelected()) {
                    BS.Util.show($('deployIncludePatterns.container'));
                    BS.Util.show($('deployExcludePatterns.container'));
                }
            }

            BS.Util.show($('activateGradleIntegration.container'));

            if (BS.local.isActivateGradleIntegrationSelected() && BS.artifactory.isDeployArtifactsSelected()) {
                BS.Util.show($('useM2CompatiblePatterns.container'));
                BS.Util.show($('ivyPattern.container'));
                BS.Util.show($('artifactPattern.container'));
            }

            var publishBuildInfo = $('org.jfrog.artifactory.selectedDeployableServer.publishBuildInfo').checked;
            if (!BS.local.isActivateGradleIntegrationSelected() || publishBuildInfo) {
                BS.Util.show($('runLicenseChecks.container'));
                var shouldRunLicenseChecks = $('org.jfrog.artifactory.selectedDeployableServer.runLicenseChecks')
                        .checked;
                if (shouldRunLicenseChecks) {
                    BS.Util.show($('licenseViolationRecipients.container'));
                    BS.Util.show($('limitChecksToScopes.container'));
                    BS.Util.show($('includePublishedArtifacts.container'));
                    BS.Util.show($('disableAutoLicenseDiscovery.container'));
                }
            }

            if (!BS.local.isActivateGradleIntegrationSelected()) {
                BS.Util.show($('publishedArtifacts.container'));
                BS.Util.show($('publishedDependencies.container'));
            }

            if (publishBuildInfo) {
                BS.Util.show($('enableReleaseManagement.container'));
                var releaseManagementEnabled =
                        $('org.jfrog.artifactory.selectedDeployableServer.enableReleaseManagement').checked;
                if (releaseManagementEnabled) {
                    BS.Util.show($('vcsTagsBaseUrlOrName.container'));
                    BS.Util.show($('gitReleaseBranchNamePrefix.container'));
                    BS.Util.show($('releaseProperties.container'));
                    BS.Util.show($('nextIntegrationProperties.container'));
                    BS.Util.show($('alternativeGradleTasks.container'));
                    BS.Util.show($('alternativeGradleOptions.container'));
                }
            }
        }
        BS.MultilineProperties.updateVisible();
    }
    ,

    loadTargetRepos : function(selectedUrlId) {
        BS.ajaxRequest(base_uri + '${controllerUrl}', {
            parameters: 'selectedUrlId=' + selectedUrlId + '&onServerChange=true&loadTargetRepos=true',
            onComplete: function(response, options) {

                var publishRepoSelect = $('org.jfrog.artifactory.selectedDeployableServer.targetRepo');
                BS.artifactory.populateRepoSelect(response, options, publishRepoSelect,
                        '${propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.targetRepo']}',
                        false);
            }
        });
        BS.ajaxRequest(base_uri + '${controllerUrl}', {
            parameters: 'selectedUrlId=' + selectedUrlId + '&onServerChange=true&loadResolvingRepos=true',
            onComplete: function(response, options) {

                var resolvingRepoSelect = $('org.jfrog.artifactory.selectedDeployableServer.resolvingRepo');
                BS.artifactory.populateRepoSelect(response, options, resolvingRepoSelect,
                        '${propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.resolvingRepo']}',
                        true);
            }
        });
    }
    ,

    isActivateGradleIntegrationSelected: function() {
        return $('org.jfrog.artifactory.selectedDeployableServer.activateGradleIntegration').checked;
    }
    ,

    isPublishBuildInfoSelected: function() {
        return $('org.jfrog.artifactory.selectedDeployableServer.publishBuildInfo').checked;
    }
    ,

    toggleOnGradleSelection: function() {
        if (BS.local.isActivateGradleIntegrationSelected()) {
            BS.Util.show('deployArtifacts.container');
            $('org.jfrog.artifactory.selectedDeployableServer.deployArtifacts').checked = true;
            BS.Util.show('useM2CompatiblePatterns.container');
            $('org.jfrog.artifactory.selectedDeployableServer.useM2CompatiblePatterns').checked = true;
            BS.Util.show($('ivyPattern.container'));
            BS.Util.show($('artifactPattern.container'));
            BS.Util.hide($('publishedArtifacts.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishedArtifacts').value = '';
            BS.Util.hide($('publishedDependencies.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishedDependencies').value = '';
            BS.Util.show($('resolvingRepo.container'));
            BS.Util.show($('publishBuildInfo.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishBuildInfo').checked = true;
            BS.Util.show($('publishMavenDescriptors.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishMavenDescriptors').checked = true;
            BS.Util.show($('publishIvyDescriptors.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishIvyDescriptors').checked = true;
        } else {
            BS.Util.hide('deployArtifacts.container');
            $('org.jfrog.artifactory.selectedDeployableServer.deployArtifacts').checked = false;
            BS.Util.hide('useM2CompatiblePatterns.container');
            $('org.jfrog.artifactory.selectedDeployableServer.useM2CompatiblePatterns').checked = false;
            BS.Util.hide($('ivyPattern.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.ivyPattern').value = '';
            BS.Util.hide($('artifactPattern.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.artifactPattern').value = '';
            BS.Util.show($('publishedArtifacts.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishedArtifacts').value = '';
            BS.Util.show($('publishedDependencies.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishedDependencies').value = '';
            BS.Util.hide($('resolvingRepo.container'));
            BS.Util.hide($('publishBuildInfo.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishBuildInfo').checked = false;
            BS.Util.hide($('publishMavenDescriptors.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishMavenDescriptors').checked = false;
            BS.Util.hide($('publishIvyDescriptors.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishIvyDescriptors').checked = false;
        }
        BS.local.toggleDeployArtifactsSelection();
        BS.local.togglePublishBuildInfoSelection();
        BS.MultilineProperties.updateVisible();
    },
    togglePublishBuildInfoSelection: function() {
        if (BS.local.isPublishBuildInfoSelected()) {
            BS.Util.show($('runLicenseChecks.container'));
            BS.Util.show($('enableReleaseManagement.container'));
        } else {
            BS.Util.hide($('runLicenseChecks.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.runLicenseChecks').checked = false;
            BS.Util.hide($('licenseViolationRecipients.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.licenseViolationRecipients').value = '';
            BS.Util.hide($('limitChecksToScopes.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.limitChecksToScopes').value = '';
            BS.Util.hide($('includePublishedArtifacts.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.includePublishedArtifacts').checked = false;
            BS.Util.hide($('disableAutoLicenseDiscovery.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.disableAutoLicenseDiscovery').checked = false;
            BS.Util.hide($('enableReleaseManagement.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.enableReleaseManagement').checked = false;
            BS.Util.hide($('vcsTagsBaseUrlOrName.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.vcsTagsBaseUrlOrName').value = '';
            BS.Util.hide($('gitReleaseBranchNamePrefix.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.gitReleaseBranchNamePrefix').value = '';
            BS.Util.hide($('releaseProperties.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.releaseProperties').value = '';
            BS.Util.hide($('nextIntegrationProperties.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.nextIntegrationProperties').value = '';
            BS.Util.hide($('alternativeGradleTasks.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.alternativeGradleTasks').value = '';
            BS.Util.hide($('alternativeGradleOptions.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.alternativeGradleOptions').value = '';
        }
        BS.MultilineProperties.updateVisible();
    },

    toggleDeployArtifactsSelection: function() {
        if (BS.artifactory.isDeployArtifactsSelected()) {
            BS.Util.show('useM2CompatiblePatterns.container');
            $('org.jfrog.artifactory.selectedDeployableServer.useM2CompatiblePatterns').checked = true;
            BS.Util.show($('ivyPattern.container'));
            BS.Util.show($('artifactPattern.container'));
            BS.Util.show($('publishMavenDescriptors.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishMavenDescriptors').checked = true;
            BS.Util.show($('publishIvyDescriptors.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishIvyDescriptors').checked = true;
        } else {
            BS.Util.hide('useM2CompatiblePatterns.container');
            $('org.jfrog.artifactory.selectedDeployableServer.useM2CompatiblePatterns').checked = false;
            BS.Util.hide($('ivyPattern.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.ivyPattern').value = '';
            BS.Util.hide($('artifactPattern.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.artifactPattern').value = '';
            BS.Util.hide($('publishMavenDescriptors.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishMavenDescriptors').checked = false;
            BS.Util.hide($('publishIvyDescriptors.container'));
            $('org.jfrog.artifactory.selectedDeployableServer.publishIvyDescriptors').checked = false;
        }

        BS.artifactory.toggleDeployArtifactsSelection();
        BS.MultilineProperties.updateVisible();
    }
}
</script>

<!--[if IE 7]>
<style type="text/css">
kbd {
display:inline-block;
}
</style>
<![endif]-->

<l:settingsGroup title="Deploy Artifacts To Artifactory">
    <jsp:include page="../common/serversEdit.jsp">
        <jsp:param name="shouldDisplay" value="${foundExistingConfig}"/>
    </jsp:include>

    <jsp:include page="../common/warningsEdit.jsp"/>

    <tr class="noBorder" id="resolvingRepo.container"
        style="${foundActivateGradleIntegrationSelected && foundExistingConfig ? '' : 'display: none;'}">
        <th>
            <label for="org.jfrog.artifactory.selectedDeployableServer.resolvingRepo">
                Resolving repository:
            </label>
        </th>
        <td>
            <props:selectProperty id="org.jfrog.artifactory.selectedDeployableServer.resolvingRepo"
                                  name="org.jfrog.artifactory.selectedDeployableServer.resolvingRepo">
            </props:selectProperty>
            <span class="smallNote">
                Select a resolving repository.
            </span>
            <span id="error_org.jfrog.artifactory.selectedDeployableServer.resolvingRepo" class="error"/>
        </td>
    </tr>

    <tr class="noBorder" id="targetRepo.container"
        style="${foundExistingConfig ? '' : 'display: none;'}">
        <th>
            <label for="org.jfrog.artifactory.selectedDeployableServer.targetRepo">
                Publishing repository:
            </label>
        </th>
        <td>
            <props:selectProperty id="org.jfrog.artifactory.selectedDeployableServer.targetRepo"
                                  name="org.jfrog.artifactory.selectedDeployableServer.targetRepo">
            </props:selectProperty>
            <c:if test="${foundExistingConfig}">
                <script type="text/javascript">
                    var existingUrlId = '${propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.urlId']}';
                    BS.local.loadTargetRepos(existingUrlId);
                    BS.artifactory.checkArtifactoryHasAddons(existingUrlId);
                    BS.artifactory.checkCompatibleVersion(existingUrlId);
                </script>
            </c:if>
            <span class="smallNote">
                Select a target deployment repository.
            </span>
            <span id="error_org.jfrog.artifactory.selectedDeployableServer.targetRepo" class="error"/>
        </td>
    </tr>

    <jsp:include page="../common/credentialsEdit.jsp">
        <jsp:param name="shouldDisplay" value="${foundExistingConfig}"/>
    </jsp:include>

    <tr class="noBorder" id="activateGradleIntegration.container"
        style="${foundExistingConfig ? '' : 'display: none;'}">
        <th>
            <label for="org.jfrog.artifactory.selectedDeployableServer.activateGradleIntegration">
                Publish Gradle Artifacts:
            </label>
        </th>
        <td>
            <props:checkboxProperty name="org.jfrog.artifactory.selectedDeployableServer.activateGradleIntegration"
                                    onclick="BS.local.toggleOnGradleSelection()"/>
            <span class="smallNote">
Use the Artifactory-Gradle integration to collect build info data and deploy artifacts and descriptors produced by Gradle.
            </span>
        </td>
    </tr>

    <tr class="noBorder" id="projectUsesArtifactoryGradlePlugin.container"
        style="${foundActivateGradleIntegrationSelected && foundExistingConfig ? '' : 'display: none;'}">
        <th>
            <label for="org.jfrog.artifactory.selectedDeployableServer.projectUsesArtifactoryGradlePlugin">
                Project uses the Artifactory Gradle Plugin:
            </label>
        </th>
        <td>
            <props:checkboxProperty
                    name="org.jfrog.artifactory.selectedDeployableServer.projectUsesArtifactoryGradlePlugin"/>
            <span class="smallNote">
The TeamCity plugin automatically applies the Artifactory plugin (and, consequently, the 'artifactoryPublish' task)
    to all projects.<br/> Check this flag to have TeamCity skip this step if your project is already using the Artifactory
    plugin or the 'artifactoryPublish' task directly. All elements in this job configuration will override matching
    project-level configuration elements.<br/>
    If your project applies the Artifactory plugin using a custom init script, make sure to include your init script as
    part of the list of Gradle switches.
            </span>
        </td>
    </tr>

    <jsp:include page="../common/deployArtifactsEdit.jsp">
        <jsp:param name="shouldDisplay" value="${foundActivateGradleIntegrationSelected && foundExistingConfig}"/>
        <jsp:param name="toggleAction" value="BS.local.toggleDeployArtifactsSelection()"/>
        <jsp:param name="deployArtifactsLabel" value="Publish artifacts"/>
        <jsp:param name="deployArtifactsHelp" value="Uncheck if you do not wish to publish artifacts from the plugin."/>
    </jsp:include>

    <jsp:include page="../common/useM2CompatiblePatternsEdit.jsp">
        <jsp:param name="shouldDisplay" value="${foundActivateGradleIntegrationSelected && foundExistingConfig}"/>
    </jsp:include>

    <tr class="noBorder" id="publishBuildInfo.container"
        style="${foundActivateGradleIntegrationSelected && foundExistingConfig ? '' : 'display: none;'}">
        <th>
            <label for="org.jfrog.artifactory.selectedDeployableServer.publishBuildInfo">
                Publish build info:
            </label>
        </th>
        <td>
            <props:checkboxProperty name="org.jfrog.artifactory.selectedDeployableServer.publishBuildInfo"
                                    onclick="BS.local.togglePublishBuildInfoSelection()"/>
            <span class="smallNote">
                Uncheck if you do not wish to deploy build information from the plugin.
            </span>
        </td>
    </tr>

    <tr class="noBorder" id="publishMavenDescriptors.container"
        style="${foundActivateGradleIntegrationSelected && foundExistingConfig && foundDeployArtifactsSelected ? '' : 'display: none;'}">
        <th>
            <label for="org.jfrog.artifactory.selectedDeployableServer.publishMavenDescriptors">
                Publish Maven descriptors:
            </label>
        </th>
        <td>
            <props:checkboxProperty name="org.jfrog.artifactory.selectedDeployableServer.publishMavenDescriptors"/>
            <span class="smallNote">
                Uncheck if you do not wish to deploy Maven descriptors from the plugin.<br/>
                Note: Maven descriptors are always deployed according to the Maven pattern layout convention.
            </span>
        </td>
    </tr>

    <tr class="noBorder" id="publishIvyDescriptors.container"
        style="${foundActivateGradleIntegrationSelected && foundExistingConfig && foundDeployArtifactsSelected ? '' : 'display: none;'}">
        <th>
            <label for="org.jfrog.artifactory.selectedDeployableServer.publishIvyDescriptors">
                Publish Ivy descriptors:
            </label>
        </th>
        <td>
            <props:checkboxProperty name="org.jfrog.artifactory.selectedDeployableServer.publishIvyDescriptors"/>
            <span class="smallNote">
                Uncheck if you do not wish to deploy Ivy descriptors from the plugin.
            </span>
        </td>
    </tr>

    <jsp:include page="../common/licensesEdit.jsp">
        <jsp:param name="shouldDisplay"
                   value="${foundExistingConfig && (!foundActivateGradleIntegrationSelected || foundPublishBuildInfoSelected)}"/>
    </jsp:include>

    <jsp:include page="../common/genericItemsEdit.jsp">
        <jsp:param name="shouldDisplay" value="${!foundActivateGradleIntegrationSelected && foundExistingConfig}"/>
    </jsp:include>

    <jsp:include page="../common/releaseManagementEdit.jsp">
        <jsp:param name="shouldDisplay" value="${foundExistingConfig && foundPublishBuildInfoSelected}"/>
        <jsp:param name="builderName" value='gradle'/>
    </jsp:include>
</l:settingsGroup>