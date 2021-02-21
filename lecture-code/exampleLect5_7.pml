/* New way to initialise an array, using a for-loop*/
/* and no inline */
byte array1[5];



active proctype A()
{byte myval=10;
 int i;
for( i  :  0 .. 4 ){
           array1[i]=myval
      }
}





