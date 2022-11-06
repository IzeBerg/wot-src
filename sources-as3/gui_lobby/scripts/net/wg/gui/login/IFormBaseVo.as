package net.wg.gui.login
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IFormBaseVo extends IDisposable
   {
       
      
      function get invalidType() : String;
      
      function set invalidType(param1:String) : void;
   }
}
