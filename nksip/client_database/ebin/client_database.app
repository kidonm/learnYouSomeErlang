{application,client_database,
             [{description,"generic client database Marek Kidon Bachelor thesis"},
              {vsn,"0.0.0"},
              {modules, 
					[
						client_database_supervisor, 
						client_database_clientpool_supervisor,
						client_database_server,
						client_database
					]
			  },
              {registered,[]},
              {applications,[kernel,stdlib]},
              {env,[]}]}.
