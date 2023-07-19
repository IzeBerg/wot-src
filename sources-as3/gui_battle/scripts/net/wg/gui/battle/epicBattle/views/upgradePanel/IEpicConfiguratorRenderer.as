package net.wg.gui.battle.epicBattle.views.upgradePanel
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import net.wg.gui.battle.epicBattle.views.upgradePanel.data.EpicConfiguratorModuleVO;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IEpicConfiguratorRenderer extends IDisplayObject, IDisposable
   {
       
      
      function setIndex(param1:uint, param2:uint) : void;
      
      function setData(param1:EpicConfiguratorModuleVO) : void;
      
      function makeUpState() : void;
      
      function makeOverState() : void;
      
      function get moduleIntCD() : uint;
      
      function get moduleIdx() : int;
      
      function get columnIdx() : int;
      
      function getNodeBounds(param1:DisplayObject) : Rectangle;
   }
}
