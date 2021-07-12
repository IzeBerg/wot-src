package org.idmedia.as3commons.util
{
   import org.idmedia.as3commons.lang.NullPointerException;
   
   public class Observable
   {
       
      
      private var observers:List;
      
      private var changed:Boolean;
      
      public function Observable()
      {
         super();
         this.observers = new ArrayList();
         this.changed = false;
      }
      
      public function setChanged() : void
      {
         this.changed = true;
      }
      
      public function hasChanged() : Boolean
      {
         return this.changed;
      }
      
      public function clearChanged() : void
      {
         this.changed = false;
      }
      
      public function addObserver(param1:Observer) : void
      {
         if(param1 == null)
         {
            throw new NullPointerException("observer must not be null");
         }
         if(!this.observers.contains(param1))
         {
            this.observers.add(param1);
         }
      }
      
      public function deleteObserver(param1:Observer = null) : void
      {
         this.observers.remove(param1);
      }
      
      public function deleteObservers() : void
      {
         this.observers.clear();
      }
      
      public function notifyObservers(param1:*) : void
      {
         if(!this.changed)
         {
            return;
         }
         this.clearChanged();
         var _loc2_:Iterator = this.observers.iterator();
         while(_loc2_.hasNext())
         {
            Observer(_loc2_.next()).update(this,param1);
         }
      }
      
      public function countObservers() : int
      {
         return this.observers.size();
      }
   }
}
