package utils;

import model.NewStudent;

public class CustomStudentQueue {
    private static final int MAX_CAPACITY = 100;
    private NewStudent[] queue;
    private int front;
    private int rear;
    private int size;

    public CustomStudentQueue() {
        queue = new NewStudent[MAX_CAPACITY];
        front = 0;
        rear = -1;
        size = 0;
    }

    // Add a new student to the queue
    public boolean enqueue(NewStudent student) {
        if (isFull()) {
            return false;
        }
        rear = (rear + 1) % MAX_CAPACITY;
        queue[rear] = student;
        size++;
        return true;
    }

    // Remove and return the first student from the queue
    public NewStudent dequeue() {
        if (isEmpty()) {
            return null;
        }
        NewStudent student = queue[front];
        front = (front + 1) % MAX_CAPACITY;
        size--;
        return student;
    }

    // Check if queue is empty
    public boolean isEmpty() {
        return size == 0;
    }

    // Check if queue is full
    public boolean isFull() {
        return size == MAX_CAPACITY;
    }

    // Get the current size of the queue
    public int size() {
        return size;
    }

    // Get all students in the queue without removing them
    public NewStudent[] getQueue() {
        NewStudent[] result = new NewStudent[size];
        for (int i = 0; i < size; i++) {
            result[i] = queue[(front + i) % MAX_CAPACITY];
        }
        return result;
    }

    // Clear the queue
    public void clear() {
        front = 0;
        rear = -1;
        size = 0;
    }

    // Check if a student is already in the queue
    public boolean contains(String email) {
        for (int i = 0; i < size; i++) {
            if (queue[(front + i) % MAX_CAPACITY].getEmail().equals(email)) {
                return true;
            }
        }
        return false;
    }

    // Remove a specific student from the queue
    public boolean removeStudent(String email) {
        if (isEmpty()) {
            return false;
        }

        int originalSize = size;
        NewStudent[] temp = new NewStudent[MAX_CAPACITY];
        int tempIndex = 0;

        // Copy all students except the one to be removed
        while (!isEmpty()) {
            NewStudent student = dequeue();
            if (!student.getEmail().equals(email)) {
                temp[tempIndex++] = student;
            }
        }

        // Restore the queue with the filtered students
        for (int i = 0; i < tempIndex; i++) {
            queue[i] = temp[i];
        }

        front = 0;
        rear = tempIndex - 1;
        size = tempIndex;

        return originalSize != size;
    }
} 