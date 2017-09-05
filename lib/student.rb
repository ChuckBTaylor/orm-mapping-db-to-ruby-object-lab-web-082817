require 'pry'

class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database
    new_student = self.new
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    new_student


    # sql = <<-SQL
    #   SELECT * FROM students WHERE id = ?
    # SQL
    # #binding.pry
    # new_info = DB[:conn].execute(sql,row[0])
    # new_student = self.new
    # new_student.id = new_info[0]
    # new_student.name = new_info[1]
    # binding.pry
    # new_student.grade = new_info[2]
  end

  def self.all
    new_studs = DB[:conn].execute("SELECT * FROM students")
    #binding.pry
    new_studs.map do |info|
      stud = self.new
      stud.id = info[0]
      stud.name = info[1]
      stud.grade = info[2]
      stud
    end
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
  end

  def self.first_X_students_in_grade_10(x)
    sql = <<-SQL
      SELECT * FROM students WHERE grade = 10 LIMIT ?
    SQL
    y = DB[:conn].execute(sql, x)
    # binding.pry
  end

  def self.first_student_in_grade_10
    new_stud = DB[:conn].execute("SELECT * FROM students WHERE grade = 10 LIMIT 1").flatten
    self.new_from_db(new_stud)
  end

  def self.find_by_name(name)
    #binding.pry
    # find the student in the database given a name
    # return a new instance of the Student class
    stud = self.new
    stud.name = name
    stud
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.count_all_students_in_grade_9
    sql = <<-SQL
      SELECT * FROM students WHERE grade = 9
    SQL
    DB[:conn].execute(sql)
  end

  def self.students_below_12th_grade
    DB[:conn].execute("SELECT * FROM students WHERE grade < 12")
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def self.all_students_in_grade_X(x)
    sql = <<-SQL
      SELECT * FROM students WHERE grade = ?
    SQL
    DB[:conn].execute(sql,x)
  end
end
