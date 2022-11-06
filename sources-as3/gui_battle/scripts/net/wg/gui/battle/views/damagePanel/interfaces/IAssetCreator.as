package net.wg.gui.battle.views.damagePanel.interfaces
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IAssetCreator extends IDisposable
   {
       
      
      function getDisplayItems() : Vector.<DisplayObject>;
      
      function get state() : String;
      
      function set state(param1:String) : void;
      
      function get name() : String;
   }
}
