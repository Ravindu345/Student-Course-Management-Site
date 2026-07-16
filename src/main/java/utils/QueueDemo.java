package utils;

import model.NewStudent;

public class QueueDemo {
    public static void main(String[] args) {
        // Create a new queue instance
        CustomStudentQueue queue = new CustomStudentQueue();

        // Create some test students
        NewStudent student1 = new NewStudent("John Doe", "john@example.com", "password123");
        NewStudent student2 = new NewStudent("Jane Smith", "jane@example.com", "password456");
        NewStudent student3 = new NewStudent("Bob Johnson", "bob@example.com", "password789");

        // Test enqueue operation
        System.out.println("Testing enqueue operations:");
        System.out.println("Enqueue student1: " + queue.enqueue(student1));
        System.out.println("Enqueue student2: " + queue.enqueue(student2));
        System.out.println("Enqueue student3: " + queue.enqueue(student3));
        System.out.println("Queue size: " + queue.size());

        // Test contains operation
        System.out.println("\nTesting contains operation:");
        System.out.println("Contains john@example.com: " + queue.contains("john@example.com"));
        System.out.println("Contains unknown@example.com: " + queue.contains("unknown@example.com"));

        // Test getQueue operation
        System.out.println("\nTesting getQueue operation:");
        NewStudent[] allStudents = queue.getQueue();
        System.out.println("All students in queue:");
        for (NewStudent student : allStudents) {
            System.out.println("- " + student.getName() + " (" + student.getEmail() + ")");
        }

        // Test dequeue operation
        System.out.println("\nTesting dequeue operation:");
        NewStudent dequeuedStudent = queue.dequeue();
        System.out.println("Dequeued student: " + dequeuedStudent.getName());
        System.out.println("Queue size after dequeue: " + queue.size());

        // Test removeStudent operation
        System.out.println("\nTesting removeStudent operation:");
        System.out.println("Removing jane@example.com: " + queue.removeStudent("jane@example.com"));
        System.out.println("Queue size after removal: " + queue.size());

        // Test clear operation
        System.out.println("\nTesting clear operation:");
        queue.clear();
        System.out.println("Queue size after clear: " + queue.size());
        System.out.println("Is queue empty: " + queue.isEmpty());

        // Test queue capacity
        System.out.println("\nTesting queue capacity:");
        for (int i = 0; i < 101; i++) {
            NewStudent student = new NewStudent("Student " + i, "student" + i + "@example.com", "password" + i);
            boolean success = queue.enqueue(student);
            if (!success) {
                System.out.println("Queue is full at " + i + " students");
                break;
            }
        }
    }
} 