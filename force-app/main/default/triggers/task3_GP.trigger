trigger task3_GP on Contact (before insert, before update) {
task3_GP_Class.great_problem(trigger.new);
}