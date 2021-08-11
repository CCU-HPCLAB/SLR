#include <stdio.h>
#include <sys/time.h>
#include <strings.h>
#include <unistd.h>
#include <sys/wait.h>
#include <string.h>
#include <iostream>
#include <ctime>
#include <stdlib.h>
#include <string.h>

#include <sys/types.h>
#include <dirent.h>
#include <vector>


using namespace std;
void GetFileNames(string path,vector<string>& filenames)
{
    DIR *pDir;
    struct dirent* ptr;
    if(!(pDir = opendir(path.c_str())))
        return;
    while((ptr = readdir(pDir))!=0) {
        if (strcmp(ptr->d_name, ".") != 0 && strcmp(ptr->d_name, "..") != 0)
            filenames.push_back(path + "/" + ptr->d_name);
    }
    closedir(pDir);
}




static void *malloc_wrap(size_t size)
{
    void *p = malloc(size);
    if (p) {
       // printf("Allocated %zu bytes from %p to %p\n", size, p, p + size);
    }
    else {
      //  printf("Failed to allocated %zu bytes\n", size);
    }
    return p;
}



int main(int argc, char *argv[])
{
    system("echo 1 | sudo tee /proc/sys/vm/overcommit_memory");
    system("echo 1 | sudo tee /proc/sys/vm/panic_on_oom");
    system("echo 0 | sudo tee /proc/sys/vm/overcommit_ratio");
    char *user_input=argv[1];
	char str1[256]="gnome-terminal -x bash -c 'stress-ng --vm 1 --vm-bytes ";
	char str2[256];
    char str3[256]="M' ";
    char File_Namber[60]="";
    char File_address[60]="/home/pi/sysy_limt/log/";
    char Shell_name[50]="./demo.sh ";
    char File_size[1];
    char shell[50]="gnome-terminal -x bash -c '";
    char shell2[50]=" /home/pi/sysy_limt";
    
    size_t step = 0x1000000;
    size_t size = step;
    size_t best = 0;
    size_t best2 = 0;
    float i=0.2;
    float status[30];
    int count=1;
    int file_namber=0;
    FILE * fp;
    
    
    vector<string> file_name;
    string path = "/home/pi/sysy_limt/log/";
 
    GetFileNames(path, file_name);
    
    sprintf(File_size,"%d",file_name.size());
    //system("./demo.sh '3'");
    printf("File_size %d",file_name.size());
    
    //===執行demo.sh跑出平均值
    //檢查log檔案中是否達到測試的次數，EX:要執行測試3次那log檔中要有3個檔案提供作平均數計算===
    if(*File_size>=*user_input)
    {
        printf("File_size===%s\n",File_size);
        strcat(Shell_name,File_size);
        strcat(Shell_name,"'");
        strcat(shell,Shell_name);
        strcat(shell,shell2);
        printf("Shell_name===%s\n",shell);
        for(int i=0;i<=5;i++)
        {
            sleep(5);
         system(shell);   
        }
        
    }
    //===execution stress-ng測試出極限值===
    else
    {
        while (step > 0)
        {
            void *p = malloc_wrap(size);
            if (p) {
                free(p);
                best = size;
            //printf("safe\n");
            }
            else {
                step /= 0x10;
             //printf("N0____safe\n");
            }
            size += step;
        
        
        }
        best=(best/1048576);
        status[0]=best;
        file_namber=file_name.size();
        printf("file_namber==%d\n\n\n",file_namber);
        file_namber=file_namber+1;
        sprintf(File_Namber,"%d",file_namber);
        strcat(File_address,File_Namber);
        
        
        
        if((fp = fopen(File_address,"wb"))==NULL){
          printf("cant open the file");
          exit(0);
        }
        if (status[count] != EOF)
        {        
            fprintf(fp,"%f \n",status[0]);
            fclose(fp);
        }

        while(1)
        {
            
            //printf("Allocated %zu MB\n", best);
            best2=best*i;
            
            sprintf(str2,"%d",best2);
            strcat(str2,str3);
            sprintf(str1,"%s"," ");
            sprintf(str1,"%s","gnome-terminal -x bash -c 'stress-ng --vm 1 --vm-bytes ");
            strcat(str1,str2);
            //printf("i==%f\n",i);
            //printf("str1==%s\n",str1);
            if(i>=0.4)
            {
                if(i>0.99)
                {
                    status[count]=best2;
                    
                    break;
                }
                i=i+0.01;
                status[count]=best2;
                
            }
            else if(i>=0.3)
            {
                i=i+0.05;
                status[count]=best2;
                
            }
            else
            {
                i=i+0.1;
                status[count]=best2;
                
            }
            
            
            system(str1);        
            
      
        
            sleep(10);
            

            fp = fopen(File_address,"a+");
            fprintf(fp,"%f \n",status[count]);
            fclose(fp);
            count++;       
            best2=0;
            system("pkill -9 stress-ng "); 
        
            
        }
       
    }
    /*
    
    while (step > 0)
    {
        void *p = malloc_wrap(size);
        if (p) {
            free(p);
            best = size;
	    //printf("safe\n");
        }
        else {
            step /= 0x10;
	     //printf("N0____safe\n");
        }
        size += step;
	
	
    }
    best=(best/1048576);
    status[0]=best;
    file_namber=file_name.size();
    printf("file_namber==%d\n\n\n",file_namber);
    file_namber=file_namber+1;
    sprintf(File_Namber,"%d",file_namber);
    strcat(File_address,File_Namber);
    
    
    
    if((fp = fopen(File_address,"wb"))==NULL){
      printf("cant open the file");
      exit(0);
    }
    fprintf(fp,"%f \n",status[0]);
    fclose(fp);
    while(1)
    {
        
        //printf("Allocated %zu MB\n", best);
        best2=best*i;
        
        sprintf(str2,"%d",best2);
        strcat(str2,str3);
        sprintf(str1,"%s"," ");
        sprintf(str1,"%s","gnome-terminal -x bash -c 'stress-ng --vm 1 --vm-bytes ");
        strcat(str1,str2);
        //printf("i==%f\n",i);
        //printf("str1==%s\n",str1);
        if(i>=0.4)
        {
            if(i>0.99)
            {
                status[count]=best2;
                break;
            }
            i=i+0.01;
            status[count]=best2;
        }
        else if(i>=0.3)
        {
            i=i+0.05;
            status[count]=best2;
        }
        else
        {
            i=i+0.1;
            status[count]=best2;

        }
        
        
        system(str1);        
        
        sleep(10);
        

        fp = fopen(File_address,"a+");
        fprintf(fp,"%f \n",status[count]);
        fclose(fp);
        count++;       
        best2=0;
        system("pkill -9 stress-ng "); 
        
    }
    */
    

}
