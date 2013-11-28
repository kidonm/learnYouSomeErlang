{application,generic_database,
             [{description,"generic client database Marek Kidon Bachelor thesis"},
              {vsn,"0.0.0"},
              {modules, 
					[
						client_database_supervisor, 
						clientpool_supervisor,
						database_supervisor
					]
			  },
              {registered,[]},
              {applications,[kernel,stdlib]},
              {env,[]}]}.
