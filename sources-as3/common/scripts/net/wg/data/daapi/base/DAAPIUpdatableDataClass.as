package net.wg.data.daapi.base
{
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public class DAAPIUpdatableDataClass extends DAAPIDataClass implements IUpdatable
   {
       
      
      public function DAAPIUpdatableDataClass(param1:Object)
      {
         super(param1);
      }
      
      public function update(param1:Object) : void
      {
         fromHash(param1);
         if(hasEventListener(Event.CHANGE))
         {
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
   }
}
