require("bundler/setup")
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
  Bundler.require(:default)
  also_reload("lib/**/*.rb")

  require("./lib/task")
  require("./lib/list")

  get("/") do
    @lists = List.all()
    @tasks = Task.all()
    erb(:index)
  end

  post("/lists")do
    name = params.fetch("name")
    list = List.new({:name => name, :id => nil})
    list.save()
    @lists = List.all()
    @tasks = Task.all()
    erb(:index)
  end

  get("/lists/:id") do
      @list = List.find(params.fetch("id").to_i())
      erb(:list)
    end



  post("/tasks") do
    description = params.fetch("description")
    list_id = params.fetch("list_id").to_i()
    @list = List.find(list_id)
    @task = Task.new({:description => description, :done => false, :list_id => list_id})
    if @task.save()
      erb(:success)
    else
    erb(:errors)
    end
  end

  get('/tasks/:id/edit') do
      @task = Task.find(params.fetch("id").to_i())
      erb(:task_edit)
    end

    patch("/tasks/:id") do
      description = params.fetch("description")
      @task = Task.find(params.fetch("id").to_i())
      @task.update({:description => description})
      @tasks = Task.all()
      @lists = List.all()
      erb(:index)
    end

  get("/lists/:id/edit")do
    @list = List.find(params.fetch("id").to_i())
    erb(:list_edit)
  end

  patch("/lists/:id")do
    name = params.fetch("name")
    @list = List.find(params.fetch("id").to_i())
    @list.update({:name => name})
    erb(:list)
  end

  delete("/lists/:id") do
      @list = List.find(params.fetch("id").to_i())
      @list.delete()
      @task = Task.find(params.fetch("id").to_i())
      @task.delete()
      @lists = List.all()
      @tasks = Task.all()
      erb(:index)
    end
