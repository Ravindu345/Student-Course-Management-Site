package utils;

import java.util.ArrayList;
import java.util.List;

import model.NewStudent;

public class RegistrationQueue {
    private static CustomStudentQueue queue = new CustomStudentQueue();

    static {
        // Initialize queue from existing pending students
        List<NewStudent> existingStudents = UserFileHandler.getNewStudents();
        for (NewStudent student : existingStudents) {
            if ("pending".equals(student.getStatus())) {
                queue.enqueue(student);
            }
        }
    }

    // Add a new student to the queue
    public static void enqueue(NewStudent student) {
        if (!contains(student.getEmail())) {
            queue.enqueue(student);
        }
    }

    // Remove and return the first student from the queue
    public static NewStudent dequeue() {
        return queue.dequeue();
    }

    // Remove a specific student from the queue (used when approving or deleting)
    public static void removeStudent(String email) {
        queue.removeStudent(email);
    }

    // Check if queue is empty
    public static boolean isEmpty() {
        return queue.isEmpty();
    }

    // Get the current size of the queue
    public static int size() {
        return queue.size();
    }

    // Get all students in the queue without removing them
    public static List<NewStudent> getQueue() {
        NewStudent[] students = queue.getQueue();
        List<NewStudent> studentList = new ArrayList<>();
        for (NewStudent student : students) {
            studentList.add(student);
        }
        return studentList;
    }

    // Clear the queue
    public static void clear() {
        queue.clear();
    }

    // Check if a student is already in the queue
    public static boolean contains(String email) {
        return queue.contains(email);
    }

    // Refresh the queue from the file system
    public static void refreshQueue() {
        queue.clear();
        List<NewStudent> existingStudents = UserFileHandler.getNewStudents();
        for (NewStudent student : existingStudents) {
            if ("pending".equals(student.getStatus())) {
                queue.enqueue(student);
            }
        }
    }
} 