@Clockify
  Feature: clockify

    Background:
      Given header Content-Type = application/json
      And header Accept = */*
      And header x-api-key = NzU5N2UxMjAtMDhjZi00YTAwLWI4MTYtMjQ2NTUwMzk5MzZh

    @ListWorkspace
    Scenario:Listar espacios de trabajo
      Given base url https://api.clockify.me/api
      And endpoint /v1/workspaces
      And header x-api-key = NzU5N2UxMjAtMDhjZi00YTAwLWI4MTYtMjQ2NTUwMzk5MzZh
      When execute method GET
      Then the status code should be 200
      * define idWorkspace = $.[0].id

    @ListClients
    Scenario:Encontrar cliente en workspace
      Given call ClockifyCasosError.feature@ListWorkspace
      And base url https://api.clockify.me/api
      And endpoint /v1/workspaces/{{idWorkspace}}/clients
      When execute method GET
      Then the status code should be 200

    @AddClientWorkspace
      Scenario:Agregar Cliente a Workspace
        Given call ClockifyCasosError.feature@ListWorkspace
        And base url https://api.clockify.me/api
        And endpoint /v1/workspaces/{{idWorkspace}}/clients
        And body addClient.json
        When execute method POST
        Then the status code should be 400
        * define idClient = $.id


    @DeleteClient
    Scenario:Eliminar cliente de Workspace
      Given call ClockifyCasosError.feature@AddClientWorkspace
      And base url https://api.clockify.me/api
      And endpoint /v1/workspaces/{{idWorkspace}}/clients/{{idClient}}
      When execute method DELETE
      Then the status code should be 200


