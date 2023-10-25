@Prueba
Feature: Proyectos del workspace

  Background:
    Given header Content-Type = application/json
    And header Accept = */*


  @ListWorkspace
  Scenario:Listar espacios de trabajo
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    And header x-api-key = NzU5N2UxMjAtMDhjZi00YTAwLWI4MTYtMjQ2NTUwMzk5MzZh
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $.[0].id

  @GetAllProjectsWorkspace
   Scenario: Listar Proyectos de workspace
    And call tp6.feature@ListWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = NzU5N2UxMjAtMDhjZi00YTAwLWI4MTYtMjQ2NTUwMzk5MzZh
    And execute method GET
    And the status code should be 200
    * define idProject = $.[0].id


  @FindProjectByID
  Scenario Outline: Consultar un proyecto por su identificador <forma>
    And call tp6.feature@GetAllProjectsWorkspace
    And base url https://api.clockify.me/api
    And endpoint <endpoint>
    And header x-api-key = NzU5N2UxMjAtMDhjZi00YTAwLWI4MTYtMjQ2NTUwMzk5MzZh
    When execute method GET
    Then the status code should be <status>

    Examples:
      | forma         | status | endpoint                                              |
      | exitosamente  | 200    | /v1/workspaces/{{idWorkspace}}/projects/{{idProject}} |
      | no encontrado | 404    | /v1/workspaces/{{idWorkspace}}/projecs/{{idProject}}  |


  @UpdateProjectMemberships
    Scenario Outline: Actualizar membresías de proyecto <motivo>
      And call tp6.feature@GetAllProjectsWorkspace
      And base url https://api.clockify.me/api
      And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/memberships
      And header x-api-key = <key>
      And body <bodies>
      And execute method PATCH
      And the status code should be <status>

      Examples:
        | motivo               | key                                              | status | bodies                             |
        | Autorizado           | NzU5N2UxMjAtMDhjZi00YTAwLWI4MTYtMjQ2NTUwMzk5MzZh | 200    | UpdateProjectMemberships.json      |
        | No Autorizado        | null                                             | 401    | UpdateProjectMemberships.json      |
        | Solicitud incorrecta | NzU5N2UxMjAtMDhjZi00YTAwLWI4MTYtMjQ2NTUwMzk5MzZh | 400    | UpdateProjectMembershipsError.json |
