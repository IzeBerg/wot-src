package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.base.meta.IAbstractTweenMeta;
   
   public interface ITween extends IAbstractTweenMeta, IDAAPIModule
   {
       
      
      function setHandler(param1:ITweenHandler) : void;
      
      function get memberData() : Object;
      
      function set memberData(param1:Object) : void;
      
      function get props() : ITweenPropertiesVO;
   }
}
