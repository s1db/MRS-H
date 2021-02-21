/* this should produce an error. Can no longer pass an array to an inline */
byte array1[5];
byte array2[7];

inline AssignArray(a,n,val)
{
byte i;
atomic{
      i=0;
      do
      ::i<n -> a[i]=val;i++
      ::i>= n ->break
      od;
      i=0
      }
}

active proctype A()
{byte myval=10;
AssignArray(array1,5,myval);


}

active proctype B()
{byte myval=20;
AssignArray(array2,7,myval)}



