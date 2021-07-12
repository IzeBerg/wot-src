package net.wg.gui.interfaces
{
   import net.wg.infrastructure.interfaces.ISprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IPersonalCaseBlockTitle extends ISprite, IDisposable
   {
       
      
      function setLeftText(param1:String) : void;
      
      function premiumVehicle(param1:Boolean) : void;
      
      function setRightText(param1:String) : void;
   }
}
