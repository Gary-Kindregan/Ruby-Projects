require 'json'

File.write("tasks.json", "{\"tasks\" : []}") unless File.exist?("tasks.json")
$file_content = JSON.parse(File.read("tasks.json"))
$tasks = $file_content["tasks"]
$listFilters = ["todo", "in-progress", "done"]


def printTask(task)
    puts "\n---------- TASK ID #{task["id"]} ----------"
    printf("%-12s %s\n%-12s %s\n%-12s %s\n%-12s %s\n", 
        "DESCRIPTION:", task["description"], 
        "STATUS:", task["status"], 
        "CREATED AT:", task["createdAt"], 
        "UPDATED AT:", task["updatedAt"]
    )
end

def listTasks(tasks)
    tasks.each { |task| printTask(task) }
end

case ARGV[0]
    when "add"
        if ARGV[1] == nil
            puts "No task descripition entered"
        else        
            $tasks.push({
                "id" => $tasks.length + 1,
                "description" => ARGV[1], 
                "status" => "todo", 
                "createdAt" => Time.now, 
                "updatedAt" => Time.now 
            })
        end
    when "delete"
        if ARGV[1] == nil || ARGV[1].to_i == 0
            puts "Invalid task id entered"
        else
            $tasks.delete_at(ARGV[1].to_i - 1)
        end
    when "mark-in-progress"
        if ARGV[1] == nil || ARGV[1].to_i == 0
            puts "Invalid task id entered"
        else
            task = $tasks.detect { |task| task["id"] == ARGV[1].to_i}
            task["status"] = "in-progress"
        end
    when "mark-done"
        if ARGV[1] == nil || ARGV[1].to_i == 0
            puts "Invalid task id entered"
        else
            task = $tasks.detect { |task| task["id"] == ARGV[1].to_i}
            task["status"] = "done"
        end
    when "list"
        if $tasks.length == 0
            puts "No Tasks"
        elsif ARGV[1] != nil && !$listFilters.include?(ARGV[1])
            puts "Invalid task list filter"
        elsif $listFilters.include?(ARGV[1])
            listTasks($tasks.select { |task| task["status"] == ARGV[1] })
        else
            listTasks($tasks)
        end
    else
        puts "Invalid Command!"
end

$file_content["tasks"] = $tasks.each_with_index { |task, index| task["id"] = index + 1 }
File.write("tasks.json", JSON.pretty_generate($file_content))