/*Name: Alison Langer
Assignment: Threads Assignment
Class: Operating Systems
Date: 5/28/22*/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <assert.h>

//Global variables to keep track of which thread corresponds to which file
char names[3][18] = {"Data_Thread_A.txt", "Data_Thread_B.txt", "Data_Thread_C.txt"};
int count1 = 0;
int count2 = 0;

/*This is the function that the threads run:
    1. Opens Data.txt file and reads contents into a new file
    2. Calculates sum of file contents
    3. Calculates elapsed time*/
void *thread(){
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC_RAW, &start);     //Gets start time of thread execution

    FILE *file1;
    file1 = fopen("Data.txt", "r");     //Opens Data.txt in read mode 
    if (file1 == NULL) {   
        printf("Error! Could not open file\n"); 
        exit(-1);
    }

    FILE *file2;
    char* file_name = names[count1];
    count1 += 1;
    file2 = fopen(file_name, "w");        //Creates a new file in write mode
    if (file2 == NULL) {   
        printf("Error! Could not open file\n"); 
        exit(-1);
    }

    int sum = 0;
    char line[3];
    while(fgets(line, 3, file1)) {
        fputs(line, file2);     //Copies contents
        sum += strtol(line, NULL, 10);
    }
    float average = sum/1000000;        //Calculates average of the file's contents
    printf("The average of file %s is: %0.2f\n", names[count2], average); 

    fclose(file1);
    fclose(file2);

    clock_gettime(CLOCK_MONOTONIC_RAW, &end);       //Gets end time of thread execution
    u_int64_t mil = (end.tv_sec - start.tv_sec) * 1000000 + (end.tv_nsec - start.tv_nsec) / 1000;
    printf("Time for thread %s to complete was: %ld ms.\n", names[count2], mil/1000);

    printf("The id for this thread is: %ld\n\n", pthread_self());       //Prints thread id
    count2 += 1;
    return NULL;
}
/*This is the main function which does 5 things:
    1. Creates Data.txt file
    2. Outputs 1,000,000 random numbers to Data.txt
    3. Creates 3 threads 
    4. Joins all threads
    5. Calculates elapsed time*/
int main(){
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC_RAW, &start);     //Gets start time for main execution
    pthread_t tid[3];

    FILE *file;
    file = fopen ("Data.txt", "w");       //Creates file Data.txt in write mode
    if (file == NULL) {   
        printf("Error! Could not open file\n"); 
        exit(-1);
    } 

    srand(time(NULL));
    for(int i = 0; i < 1000000; i++) {
        int r = rand() % 100;       //Genereates a million random numbers from 0-100
        fprintf(file, "%d\n", r);   // Outputs random numbers to Data.txt file
    }
    fclose(file);

    for (int i = 0; i < 3; i++){            
        int rc = pthread_create(&tid[i], NULL, thread, NULL);       //Generates 3 threads
        assert(rc == 0);
    }
    for (int i = 0; i < 3; i++){
        int rc = pthread_join(tid[i], NULL);    //Joins all threads so main waits for execution to finish
        assert(rc == 0);
    }

    clock_gettime(CLOCK_MONOTONIC_RAW, &end);       //Gets end time for main execution
    u_int64_t mil = (end.tv_sec - start.tv_sec) * 1000000 + (end.tv_nsec - start.tv_nsec) / 1000;
    printf("Time to run main program was: %lu ms.\n", mil/1000);
    pthread_exit(NULL);
    return 0;
}


