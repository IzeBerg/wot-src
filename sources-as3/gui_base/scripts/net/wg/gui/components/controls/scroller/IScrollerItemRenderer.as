package net.wg.gui.components.controls.scroller
{
   import flash.geom.Point;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.core.UIComponent;
   
   public interface IScrollerItemRenderer extends IUIComponentEx
   {
       
      
      function measureSize(param1:Point = null) : Point;
      
      function get index() : uint;
      
      function set index(param1:uint) : void;
      
      function get data() : Object;
      
      function set data(param1:Object) : void;
      
      function get owner() : UIComponent;
      
      function set owner(param1:UIComponent) : void;
      
      function get selected() : Boolean;
      
      function set selected(param1:Boolean) : void;
      
      function set tooltipDecorator(param1:ITooltipMgr) : void;
      
      function set isViewPortEnabled(param1:Boolean) : void;
   }
}
