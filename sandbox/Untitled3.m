grades = [];
level = 1;
semester = 'Fall';
subject = 'Math';
student = 'John_Doe';
fieldnames = {semester subject student}
newGrades_Doe = [85, 89, 76, 93, 85, 91, 68, 84, 95, 73];

grades = setfield(grades, {level}, ...
                  fieldnames{:}, {10, 21:30}, ... 
                  newGrades_Doe);

% View the new contents.
grades(level).(semester).(subject).(student)(10, 21:30)