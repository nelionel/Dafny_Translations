method numerical_letter_grade(grades: seq<real>) returns (letter_grades: seq<string>)
  ensures |letter_grades| == |grades|
  ensures forall i :: 0 <= i < |grades| ==> 
    letter_grades[i] == grade_to_letter(grades[i])
{
  letter_grades := [];
  
  var i := 0;
  while i < |grades|
    invariant 0 <= i <= |grades|
    invariant |letter_grades| == i
    invariant forall j :: 0 <= j < i ==> 
      letter_grades[j] == grade_to_letter(grades[j])
    decreases |grades| - i
  {
    var gpa := grades[i];
    var letter_grade: string;
    
    if gpa == 4.0 {
      letter_grade := "A+";
    } else if gpa > 3.7 {
      letter_grade := "A";
    } else if gpa > 3.3 {
      letter_grade := "A-";
    } else if gpa > 3.0 {
      letter_grade := "B+";
    } else if gpa > 2.7 {
      letter_grade := "B";
    } else if gpa > 2.3 {
      letter_grade := "B-";
    } else if gpa > 2.0 {
      letter_grade := "C+";
    } else if gpa > 1.7 {
      letter_grade := "C";
    } else if gpa > 1.3 {
      letter_grade := "C-";
    } else if gpa > 1.0 {
      letter_grade := "D+";
    } else if gpa > 0.7 {
      letter_grade := "D";
    } else if gpa > 0.0 {
      letter_grade := "D-";
    } else {
      letter_grade := "E";
    }
    
    letter_grades := letter_grades + [letter_grade];
    i := i + 1;
  }
}

function grade_to_letter(gpa: real): string
{
  if gpa == 4.0 then "A+"
  else if gpa > 3.7 then "A"
  else if gpa > 3.3 then "A-"
  else if gpa > 3.0 then "B+"
  else if gpa > 2.7 then "B"
  else if gpa > 2.3 then "B-"
  else if gpa > 2.0 then "C+"
  else if gpa > 1.7 then "C"
  else if gpa > 1.3 then "C-"
  else if gpa > 1.0 then "D+"
  else if gpa > 0.7 then "D"
  else if gpa > 0.0 then "D-"
  else "E"
}