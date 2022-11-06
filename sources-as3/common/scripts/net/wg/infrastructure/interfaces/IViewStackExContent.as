package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDAAPIEntity;
   
   public interface IViewStackExContent extends IViewStackContent, IDAAPIEntity
   {
       
      
      function setSize(param1:Number, param2:Number) : void;
      
      function setActive(param1:Boolean) : void;
   }
}
