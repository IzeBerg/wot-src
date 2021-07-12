package net.wg.gui.components.battleRoyale
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import net.wg.gui.components.battleRoyale.data.ConfiguratorModuleVO;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IConfiguratorRenderer extends IDisplayObject, IDisposable
   {
       
      
      function setIndex(param1:uint, param2:uint) : void;
      
      function setData(param1:ConfiguratorModuleVO) : void;
      
      function makeUpState() : void;
      
      function makeOverState() : void;
      
      function get moduleIntCD() : uint;
      
      function get moduleIdx() : int;
      
      function get columnIdx() : int;
      
      function set tooltipEnabled(param1:Boolean) : void;
      
      function getNodeBounds(param1:DisplayObject) : Rectangle;
   }
}
