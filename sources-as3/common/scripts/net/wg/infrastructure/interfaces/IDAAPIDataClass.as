package net.wg.infrastructure.interfaces
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDAAPIEntity;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IDAAPIDataClass extends IDisposable, IDAAPIEntity
   {
       
      
      function fromHash(param1:Object) : void;
      
      function toHash() : Object;
      
      function isEquals(param1:DAAPIDataClass) : Boolean;
   }
}
