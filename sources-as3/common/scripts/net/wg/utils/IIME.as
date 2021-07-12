package net.wg.utils
{
   import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IIME extends IDisposable
   {
       
      
      function init(param1:Boolean) : void;
      
      function setVisible(param1:Boolean) : void;
      
      function getContainer() : ISimpleManagedContainer;
      
      function onLangBarResize(param1:Number, param2:Number) : void;
   }
}
